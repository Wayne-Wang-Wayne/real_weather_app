import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/models/postModel.dart';
import 'package:real_weather_shared_app/mainPage/models/userModel.dart';
import 'package:real_weather_shared_app/utils/pictureDetailPage.dart';
import 'package:real_weather_shared_app/utils/someTools.dart';

class UserInfoWidget extends StatelessWidget {
  PostModel? postModel;
  UserModel? userModel;
  UserInfoWidget({Key? key, this.postModel, this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 30,
        ),
        GestureDetector(
            onTap: () => Navigator.of(context)
                    .pushNamed(PictureDetailPage.routeName, arguments: {
                  "pictureUrl": postModel == null
                      ? userModel!.userImageUrl!
                      : postModel!.posterImageUrl!
                }),
            child: Container(
              height: 120,
              width: 120,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(postModel == null
                    ? userModel!.userImageUrl!
                    : postModel!.posterImageUrl!),
                backgroundColor: Colors.transparent,
              ),
            )),
        SizedBox(
          height: 10,
        ),
        Text(
          postModel == null ? userModel!.userName! : postModel!.posterName!,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.blueGrey),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              postModel == null
                  ? MyTools.getUserTitle(userModel!.userExp!)
                  : MyTools.getUserTitle(postModel!.posterExp!),
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              postModel == null
                  ? "( Lv. ${MyTools.getCurrentLevel(userModel!.userExp!)} )"
                  : "( Lv. ${MyTools.getCurrentLevel(postModel!.posterExp!)} )",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "有Po文天數: ${postModel == null ? userModel!.postTime! : postModel!.posterPostTimes!}",
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
            Text(
              "被讚次數: ${postModel == null ? userModel!.likedTime! : postModel!.posterLikedTimes!}",
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            )
          ],
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
