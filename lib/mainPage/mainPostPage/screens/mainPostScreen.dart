import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/createPostPage/screens/createPostScreen.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/postItem.dart';

import '../../models/postModel.dart';

class MainPostScreen extends StatefulWidget {
  const MainPostScreen({Key? key}) : super(key: key);

  @override
  State<MainPostScreen> createState() => _MainPostScreenState();
}

class _MainPostScreenState extends State<MainPostScreen> {
  var _postList = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    final originData = await FirebaseFirestore.instance
        .collection("posts")
        .withConverter(
            fromFirestore: PostModel.fromFirestore,
            toFirestore: (PostModel postModel, options) =>
                postModel.toFirestore())
        .orderBy("postDateTimeStamp", descending: true)
        .get();
    if (originData.size <= 0) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final postList = [];
    originData.docs.asMap().forEach((index, post) {
      postList.add(post.data());
    });
    setState(() {
      isLoading = false;
      _postList = postList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Text(
                "即時天氣",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(CreatePostScreen.routeName)
                      .then((value) => loadData());
                },
                child: Text(
                  "發佈",
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                )),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _postList == null
                ? Center(
                    child: Text("不好意思，目前沒有相關資料！"),
                  )
                : RefreshIndicator(
                    onRefresh: loadData,
                    child: ListView.builder(
                      itemBuilder: ((context, index) {
                        return PostItem(
                          key: ValueKey(DateTime.now().toString()),
                          postModel: _postList[index],
                        );
                      }),
                      itemCount: _postList.length,
                    ),
                  ));
  }
}
