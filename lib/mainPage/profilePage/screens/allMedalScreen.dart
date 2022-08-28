import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/widgets/medalItem.dart';
import 'package:real_weather_shared_app/utils/someTools.dart';

class AllMedalScreen extends StatelessWidget {
  const AllMedalScreen({Key? key}) : super(key: key);
  static const routeName = "/all-medal";

  @override
  Widget build(BuildContext context) {
    List<String> medalPicPathList = [];
    for (int i = 1; i <= 9; i++) {
      medalPicPathList.add(MyTools.getMedalPicPathByLevel(i));
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            "獎牌一覽",
            style: TextStyle(color: Colors.black),
          )),
      body: ListView.builder(
        itemBuilder: (context, index) => index == medalPicPathList.length
            ? Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(child: Text("更多獎牌將會陸續推出....")),
              )
            : MedalItem(
                medalPicPath: medalPicPathList[index], level: index + 1),
        itemCount: medalPicPathList.length + 1,
      ),
    );
  }
}
