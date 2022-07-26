import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/models/userModel.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/widgets/LineAnimation.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/widgets/signInMissionButton.dart';

class DailyMission extends StatelessWidget {
  final UserModel userModel;
  DailyMission({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Text(
              "每日任務",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(7)),
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.grey),
                  alignment: Alignment.bottomCenter,
                  height: 8,
                  width: 208,
                  child: SizedBox(height: 4, width: 200, child: Line())),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('每日簽到', style: TextStyle(fontSize: 18)),
                  SingInMissionButton(userModel: userModel)
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
