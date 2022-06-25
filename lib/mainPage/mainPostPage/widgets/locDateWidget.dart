import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class LocDateWidget extends StatelessWidget {
  final String postLocation;
  final DateTime postDate;
  const LocDateWidget(
      {Key? key, required this.postLocation, required this.postDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 13,
        ),
        Text(
          postLocation,
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          width: 5,
        ),
        Text(DateFormat('yyyy-MM-dd    HH:mm').format(postDate),
            style: TextStyle(fontSize: 15))
      ],
    );
  }
}
