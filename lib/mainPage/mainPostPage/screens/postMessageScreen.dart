import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/messageItem.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/messageMainInfoWidget.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/msListAndNewMS.dart';
import 'package:real_weather_shared_app/mainPage/models/postModel.dart';

import '../widgets/newMessageWisget.dart';

class PostMessageScreen extends StatelessWidget {
  const PostMessageScreen({Key? key}) : super(key: key);
  static const routeName = "/post-message";

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> rcvdData =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final postModel = rcvdData["postModel"] as PostModel;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.expand_more_outlined,
            color: Colors.black,
            size: 40,
          ),
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              "留言",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        child: Column(
          children: [
            MessageMainInfoWidget(postModel: postModel),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              height: 1,
              color: Colors.grey.shade400,
            ),
            MsListAndNewMS(
              postModel: postModel,
            )
          ],
        ),
      ),
    );
  }
}
