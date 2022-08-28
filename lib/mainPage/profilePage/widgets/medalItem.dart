import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class MedalItem extends StatelessWidget {
  final String medalPicPath;
  final int level;
  const MedalItem({Key? key, required this.medalPicPath, required this.level})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(7)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              medalPicPath,
              height: 40,
              width: 40,
            ),
            Text(
              "等級 $level",
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            )
          ]),
    );
  }
}
