import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/locDateWidget.dart';

class PostLabel extends StatelessWidget {
  final int rainLevel;
  const PostLabel({Key? key, required this.rainLevel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _labelText = "";
    var _labelColor = Colors.yellow.shade800;
    switch (rainLevel) {
      case 0:
        _labelText = "太陽";
        _labelColor = Colors.yellow.shade700;
        break;
      case 1:
        _labelText = "陰天";
        _labelColor = Colors.grey.shade400;
        break;
      case 2:
        _labelText = "下雨";
        _labelColor = Colors.blue.shade500;
        break;
    }
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: _labelColor, borderRadius: BorderRadius.circular(15)),
          child: Text(
            _labelText,
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
