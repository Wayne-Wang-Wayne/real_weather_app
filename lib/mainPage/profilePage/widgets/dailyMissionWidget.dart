import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/models/userModel.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/widgets/LineAnimation.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/widgets/expTextWidget.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/widgets/signInMissionButton.dart';

import 'levelAndTitleWidget.dart';

class DailyMission extends StatefulWidget {
  final UserModel userModel;
  DailyMission({Key? key, required this.userModel}) : super(key: key);

  @override
  State<DailyMission> createState() => _DailyMissionState();
}

class _DailyMissionState extends State<DailyMission> {
  int _startExp = 0;
  int _endExp = 0;
  @override
  void initState() {
    super.initState();
    _startExp = 0;
    _endExp = widget.userModel.userExp!;
  }

  void gainExp(int gainExp) {
    setState(() {
      _startExp = _endExp;
      _endExp += gainExp;
    });
  }

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
              LVAndTitleWidget(
                endExp: _endExp,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.grey),
                  alignment: Alignment.bottomCenter,
                  height: 8,
                  width: 208,
                  child: SizedBox(
                      height: 4,
                      width: 200,
                      child: Line(
                        startExp: _startExp,
                        endExp: _endExp,
                      ))),
              ExpTextWidget(
                endExp: _endExp,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 18),
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('每日簽到  ', style: TextStyle(fontSize: 18)),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "(+20 exp)",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  SingInMissionButton(
                    userModel: widget.userModel,
                    gainExp: gainExp,
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
