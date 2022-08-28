import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/models/postModel.dart';
import 'package:real_weather_shared_app/utils/someTools.dart';

import '../../../utils/pictureDetailPage.dart';

class MessageMainInfoWidget extends StatelessWidget {
  final PostModel postModel;
  MessageMainInfoWidget({Key? key, required this.postModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(
          onTap: () =>
              MyTools.showUserInfo(context: context, postModel: postModel),
          child: Container(
            height: 40,
            width: 40,
            child: Hero(
              tag: postModel.posterImageUrl! + postModel.postId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(
                    postModel.posterImageUrl!.isEmpty
                        ? MyTools.defaultAvatarLink
                        : postModel.posterImageUrl!,
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => MyTools.showUserInfo(
                    context: context, postModel: postModel),
                child: Row(
                  children: [
                    Text(
                      postModel.posterName!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Image.asset(
                      MyTools.getMedalPicPath(postModel.posterExp!),
                      height: 30,
                      width: 30,
                    ),
                    Text(
                      "( 等級 ${MyTools.getCurrentLevel(postModel.posterExp!)} )",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    )
                  ],
                ),
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
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
              PictureDetailPage.routeName,
              arguments: {"pictureUrl": postModel.imageUrl!}),
          child: Container(
            height: 120,
            width: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Hero(
                tag: postModel.imageUrl!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(postModel.imageUrl!, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
