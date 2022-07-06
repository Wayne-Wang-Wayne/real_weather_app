import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/models/userModel.dart';

class MyAchievement extends StatelessWidget {
  final UserModel userModel;
  MyAchievement({Key? key, required this.userModel}) : super(key: key);

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
              "我的成就",
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
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text('Po文次數: ${userModel.postTime} 次',
                      style: TextStyle(fontSize: 18)),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 18),
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
              Row(
                children: [
                  Text('被讚次數: ${userModel.likedTime} 次',
                      style: TextStyle(fontSize: 18))
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        )
      ],
    );
  }
}
