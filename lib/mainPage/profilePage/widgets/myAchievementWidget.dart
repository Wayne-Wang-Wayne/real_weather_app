import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyAchievement extends StatelessWidget {
  const MyAchievement({Key? key}) : super(key: key);

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
                  Text('Po文次數: 2 次', style: TextStyle(fontSize: 18)),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 18),
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
              Row(
                children: [Text('被讚次數: 1 次', style: TextStyle(fontSize: 18))],
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
