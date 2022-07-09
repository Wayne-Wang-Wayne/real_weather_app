import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:real_weather_shared_app/utils/someTools.dart';

class LocDateWidget extends StatelessWidget {
  final String postCity;
  final String postTown;
  final int postDate;
  const LocDateWidget(
      {Key? key,
      required this.postCity,
      required this.postTown,
      required this.postDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 13,
        ),
        Text(
          postCity,
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          postTown,
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          width: 20,
        ),
        Text(MyTools.getReadableTime(postDate),
            style: TextStyle(fontSize: 15, color: Colors.grey))
      ],
    );
  }
}
