import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/models/postModel.dart';
import 'package:real_weather_shared_app/mainPage/models/userModel.dart';

import '../../../utils/someTools.dart';

class PosterInfoWidget extends StatelessWidget {
  final PostModel postModel;
  PosterInfoWidget({Key? key, required this.postModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getPosterInfoWidget();
  }

  Widget getPosterInfoWidget() {
    return Row(children: [
      SizedBox(
        width: 8,
      ),
      Container(
        height: 55,
        width: 55,
        child: Hero(
          tag: postModel.posterImageUrl! + postModel.postId!,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: postModel.posterImageUrl!.isEmpty
                ? Image.asset("assets/images/default_avatar.png")
                : FadeInImage(
                    image: NetworkImage(postModel.posterImageUrl!),
                    placeholder: AssetImage("assets/images/default_avatar.png"),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            postModel.posterName!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            children: [
              Text(
                MyTools.getUserTitle(postModel.posterExp!),
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                "( Lv. ${MyTools.getCurrentLevel(postModel.posterExp!)} )",
                style: TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      )
    ]);
  }
}
