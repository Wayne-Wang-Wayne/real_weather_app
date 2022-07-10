import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/models/postModel.dart';
import 'package:real_weather_shared_app/utils/someTools.dart';

class MessageMainInfoWidget extends StatelessWidget {
  final PostModel postModel;
  MessageMainInfoWidget({Key? key, required this.postModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Hero(
                tag: postModel.posterImageUrl! + postModel.postId!,
                child: Image.network(postModel.posterImageUrl!,
                    fit: BoxFit.cover)),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    postModel.posterName!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "(${postModel.posterTitle!})",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              ),
              Text(postModel.postText!, style: TextStyle(fontSize: 14)),
              Text(MyTools.getReadableTime(postModel.postDateTimeStamp!),
                  style: TextStyle(fontSize: 10, color: Colors.grey))
            ],
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Container(
          height: 120,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Hero(
                  tag: postModel.imageUrl! + postModel.postId!,
                  child: Image.network(postModel.imageUrl!, fit: BoxFit.cover)),
            ),
          ),
        )
      ]),
    );
  }
}
