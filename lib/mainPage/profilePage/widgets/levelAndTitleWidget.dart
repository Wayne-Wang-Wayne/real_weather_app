import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
          Text(
            "天氣專家",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey),
          ),
          Text("等級${getCurrentLevel()}")
        ],
      ),
    );
  }

  int getCurrentLevel() {
    int tempExp = 0;
    int currentLevel = 0;
    while (endExp - tempExp >= 0) {
      currentLevel++;
      endExp -= tempExp;
      tempExp += 200;
    }
    return currentLevel;
  }
}
