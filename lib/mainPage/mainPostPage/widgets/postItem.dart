import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/locDateWidget.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/postItemImageWidget.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/postLabel.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/postMoreOption.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/posterInfoWidget.dart';
import 'package:real_weather_shared_app/utils/pictureDetailPage.dart';
import 'package:real_weather_shared_app/utils/someTools.dart';

import '../../models/postModel.dart';

class PostItem extends StatelessWidget {
  final PostModel postModel;
  final Function(String) updateDeleteCallBack;
  const PostItem(
      {Key? key, required this.postModel, required this.updateDeleteCallBack})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(children: [
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () =>
                MyTools.showUserInfo(context: context, postModel: postModel),
            child: PosterInfoWidget(
              postModel: postModel,
            ),
          ),
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
          PostItemImage(
            imageUrl: postModel.imageUrl!,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            child: Linkify(
                text: postModel.postText!,
                style: TextStyle(fontSize: 20),
                onOpen: (link) {
                  MyTools.launchMyUrl(Uri.parse(link.url));
                }),
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
        ]),
        Positioned(
          child: PostMoreOptionWidget(
              postModel: postModel, updateDeleteCallBack: updateDeleteCallBack),
          right: 15,
          top: 5,
        )
      ],
    );
  }
}
