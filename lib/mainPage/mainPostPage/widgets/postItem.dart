import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/models/postModel.dart';

class PostItem extends StatefulWidget {
  final Key key;
  final PostModel postModel;
  const PostItem({required this.key, required this.postModel})
      : super(key: key);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(15)),
              child: Text("Hi"),
            )
          ],
        ),
        Image.network(widget.postModel.imageUrl)
      ]),
    );
  }
}
