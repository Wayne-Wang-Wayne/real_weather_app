import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/locDateWidget.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/postLabel.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/posterInfoWidget.dart';

import '../../models/postModel.dart';

class PostItem extends StatefulWidget {
  final Key key;
  final PostModel postModel;
  const PostItem({required this.key, required this.postModel})
      : super(key: key);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem>
    with AutomaticKeepAliveClientMixin<PostItem> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 5,
      ),
      PosterInfoWidget(
        postModel: widget.postModel,
      ),
      SizedBox(
        height: 5,
      ),
      Row(
        children: [
          PostLabel(rainLevel: widget.postModel.rainLevel!),
          LocDateWidget(
              postCity: widget.postModel.postCity!,
              postTown: widget.postModel.postTown!,
              postDate: widget.postModel.postDateTimeStamp!)
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
            child: Image.network(widget.postModel.imageUrl!, fit: BoxFit.cover),
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
          widget.postModel.postText!,
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
      )
    ]);
  }

  @override
  bool get wantKeepAlive => true;
}
