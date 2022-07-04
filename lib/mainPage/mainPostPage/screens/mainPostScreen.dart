import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/createPostPage/screens/createPostScreen.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/postItem.dart';

import '../../models/postModel.dart';
import '../../models/userModel.dart';

class MainPostScreen extends StatefulWidget {
  const MainPostScreen({Key? key}) : super(key: key);

  @override
  State<MainPostScreen> createState() => _MainPostScreenState();
}

class _MainPostScreenState extends State<MainPostScreen> {
  ScrollController? controller;
  var _notYetShowedList = [];
  var _showedList = [];
  bool isFirstLoading = false;
  bool isMoreLoading = false;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
    loadFirstData();
  }

  @override
  void dispose() {
    controller!.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (controller!.position.extentAfter < _showedList.length) {
      loadMore();
    }
  }

  Future<void> loadFirstData() async {
    setState(() {
      isFirstLoading = true;
    });
    _notYetShowedList = [];
    _showedList = [];
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
        isFirstLoading = false;
      });
      return;
    }
    final tempPostList = [];
    originData.docs.asMap().forEach((index, post) {
      tempPostList.add(post.data());
    });
    _notYetShowedList = tempPostList;

    //準備放到_showedList裡開始show
    await prepareShowedList();
    setState(() {
      isFirstLoading = false;
    });
  }

  Future<void> loadMore() async {
    if (_notYetShowedList.length <= 0) {
      return;
    }
    setState(() {
      isMoreLoading = true;
    });
    await prepareShowedList();
    setState(() {
      isMoreLoading = false;
    });
  }

  Future<void> prepareShowedList() async {
    var preparedToShowedList = [];
    if (_notYetShowedList.length < 5) {
      preparedToShowedList = _notYetShowedList.sublist(0);
      _notYetShowedList = [];
    } else {
      preparedToShowedList = _notYetShowedList.sublist(0, 5);
      _notYetShowedList = _notYetShowedList.sublist(5);
    }

    for (final item in preparedToShowedList) {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .withConverter(
              fromFirestore: UserModel.fromFirestore,
              toFirestore: (UserModel userModel, options) =>
                  userModel.toFirestore())
          .doc((item as PostModel).posterUserId);
      final userModel = await docRef.get().then((value) => value.data());
      item.posterImageUrl = userModel!.userImageUrl;
      item.posterName = userModel.userName;
      item.posterTitle = userModel.userTitle;
      _showedList.add(item);
    }
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
                      .then((value) => loadFirstData());
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
        body: isFirstLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _notYetShowedList.isEmpty && _showedList.isEmpty
                ? Center(
                    child: Text("不好意思，目前沒有相關資料！"),
                  )
                : RefreshIndicator(
                    onRefresh: loadFirstData,
                    child: ListView.builder(
                      controller: controller,
                      itemBuilder: ((context, index) {
                        return PostItem(
                          key: ValueKey(DateTime.now().toString()),
                          postModel: _showedList[index],
                        );
                      }),
                      itemCount: _showedList.length,
                    ),
                  ));
  }
}
