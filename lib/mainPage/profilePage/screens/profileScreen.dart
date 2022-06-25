import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/widgets/myAchievementWidget.dart';

import '../widgets/dailyMissionWidget.dart';
import '../widgets/levelUpRuleWidget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 120,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://scontent.ftpe7-4.fna.fbcdn.net/v/t1.6435-9/48369165_1912940112137595_5358895407491448832_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=h0UpyEBN-RsAX_VBj7E&_nc_ht=scontent.ftpe7-4.fna&oh=00_AT9trOZEUA1NFEVjJSiP38_rTO0FcSbL3cTGO3M7lCLTLQ&oe=62DB7C22"),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                "更換大頭貼",
                style: TextStyle(color: Colors.blue),
              )),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "王翊瑋",
                style: TextStyle(fontSize: 25),
              ),
              Icon(
                Icons.edit,
                size: 15,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          DailyMission(),
          SizedBox(
            height: 5,
          ),
          MyAchievement(),
          SizedBox(
            height: 5,
          ),
          LevelUpRule()
        ],
      ),
    );
  }
}
