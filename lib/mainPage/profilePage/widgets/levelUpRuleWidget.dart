import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/screens/allMedalScreen.dart';

class LevelUpRule extends StatelessWidget {
  const LevelUpRule({Key? key}) : super(key: key);

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
              "說明",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        GestureDetector(
          onTap: () =>
              Navigator.of(context).pushNamed(AllMedalScreen.routeName),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(7)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text('獎牌一覽', style: TextStyle(fontSize: 18)),
                Icon(Icons.arrow_forward_ios_outlined)
              ],
            ),
          ),
        )
      ],
    );
  }
}
