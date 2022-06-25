import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DailyMission extends StatefulWidget {
  const DailyMission({Key? key}) : super(key: key);

  @override
  State<DailyMission> createState() => _DailyMissionState();
}

class _DailyMissionState extends State<DailyMission> {
  var _isCheckIn = false;
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('每日簽到', style: TextStyle(fontSize: 18)),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    _isCheckIn = true;
                  });
                },
                icon: _isCheckIn ? Icon(Icons.check) : Container(),
                label: Text(
                  _isCheckIn ? "已簽到" : "簽到",
                  style:
                      TextStyle(color: _isCheckIn ? Colors.grey : Colors.white),
                ),
                style:
                    TextButton.styleFrom(backgroundColor: Colors.red.shade200),
              )
            ],
          ),
        )
      ],
    );
  }
}
