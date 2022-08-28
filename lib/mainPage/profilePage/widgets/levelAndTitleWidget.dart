import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../utils/someTools.dart';

class LVAndTitleWidget extends StatelessWidget {
  int endExp;
  LVAndTitleWidget({Key? key, required this.endExp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          Image.asset(MyTools.getMedalPicPath(endExp)),
          Text(
            "等級${MyTools.getCurrentLevel(endExp)}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
      ),
    );
  }
}
