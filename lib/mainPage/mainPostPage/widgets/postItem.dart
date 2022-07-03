import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/locDateWidget.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/postLabel.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/postLikeButton.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/posterInfoWidget.dart';

import '../../models/postModel.dart';

class PostItem extends StatelessWidget {
  final Key key;
  final PostModel postModel;
  const PostItem({required this.key, required this.postModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        SizedBox(
          height: 5,
        ),
        PosterInfoWidget(),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            PostLabel(rainLevel: postModel.rainLevel!),
            LocDateWidget(
                postCity: postModel.postCity!,
                postTown: postModel.postTown!,
                postDate: postModel.postDateTimeStamp!)
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: double.infinity,
          height: 250,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(postModel.imageUrl!, fit: BoxFit.cover),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          child: Text(
            postModel.postText!,
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: 1,
          color: Colors.grey.shade200,
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PostLikeButton(),
            TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.message_outlined),
                label: Text("留言"))
          ],
        )
      ]),
    );
  }
}
