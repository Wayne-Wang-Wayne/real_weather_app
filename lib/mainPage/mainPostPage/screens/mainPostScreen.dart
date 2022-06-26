import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/postItem.dart';

import '../../models/postModel.dart';

class MainPostScreen extends StatelessWidget {
  const MainPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _postList = [
      PostModel(
          postId: "1",
          imageUrl: "https://cdn2.ettoday.net/images/4887/d4887809.jpg",
          postText: "天氣真差！！請大家備好雨傘！",
          postDate: DateTime.now(),
          likeAmount: 0,
          rainLevel: 2,
          posterUserId: "XXX",
          postCity: "台北市",
          postTown: "松山區",
          replyList: [
            ReplyModel(
                postId: "1",
                replyId: "1",
                replyContent: "天氣真的很好耶！",
                replyDate: DateTime.now(),
                replyLikeAmount: 0,
                replierUserId: "XXX"),
            ReplyModel(
                postId: "1",
                replyId: "2",
                replyContent: "對啊！真的很不錯！",
                replyDate: DateTime.now(),
                replyLikeAmount: 0,
                replierUserId: "XXX")
          ]),
      PostModel(
          postId: "1",
          imageUrl:
              "https://images.twinkl.co.uk/tw1n/image/private/t_630/u/ux/wolfgang-hasselmann-br-gllg7bs-unsplash-2_ver_1.jpg",
          postText: "天氣真好！！",
          postDate: DateTime.now(),
          likeAmount: 0,
          rainLevel: 0,
          posterUserId: "XXX",
          postCity: "彰化縣",
          postTown: "彰化市",
          replyList: [
            ReplyModel(
                postId: "2",
                replyId: "1",
                replyContent: "天氣真的很好耶！",
                replyDate: DateTime.now(),
                replyLikeAmount: 0,
                replierUserId: "XXX"),
            ReplyModel(
                postId: "2",
                replyId: "2",
                replyContent: "對啊！真的很不錯！",
                replyDate: DateTime.now(),
                replyLikeAmount: 0,
                replierUserId: "XXX")
          ])
    ];

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
                onPressed: () {},
                child: Text(
                  "發佈",
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                )),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: ListView.builder(
          itemBuilder: ((context, index) {
            return PostItem(
              key: ValueKey(DateTime.now().toString()),
              postModel: _postList[index],
            );
          }),
          itemCount: _postList.length,
        ));
  }
}
