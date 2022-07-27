import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ExpTextWidget extends StatelessWidget {
  int endExp;
  ExpTextWidget({Key? key, required this.endExp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 210,
        alignment: Alignment.centerRight,
        child: Text("${getExpString()} EXP"));
  }

  String getExpString() {
    int tempExp = 0;
    while (endExp - tempExp >= 0) {
      endExp -= tempExp;
      tempExp += 200;
    }
    return "$endExp/$tempExp";
  }
}
