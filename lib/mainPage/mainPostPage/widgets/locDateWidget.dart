import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

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

  String getReadableTime() {
    var dt = DateTime.fromMillisecondsSinceEpoch(postDate);
    var duration = DateTime.now().difference(dt);
    var readableTime = DateFormat('yyyy/MM/dd HH:mm').format(dt);
    if (duration.inDays == 1) {
      readableTime = "昨天 ${DateFormat('HH:mm').format(dt)}";
    }
    if (duration.inDays == 2) {
      readableTime = "前天 ${DateFormat('HH:mm').format(dt)}";
    }
    if (duration.inHours < 24) {
      readableTime = "${duration.inHours}小時前";
    }
    if (duration.inMinutes < 60) {
      readableTime = "${duration.inMinutes}分鐘前";
    }
    if (duration.inSeconds < 60) {
      readableTime = "${duration.inSeconds}秒鐘前";
    }
    return readableTime;
  }

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
        Text(getReadableTime(),
            style: TextStyle(fontSize: 15, color: Colors.grey))
      ],
    );
  }
}
