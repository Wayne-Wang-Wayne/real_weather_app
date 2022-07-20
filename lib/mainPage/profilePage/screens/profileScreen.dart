import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:real_weather_shared_app/mainPage/models/userModel.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/widgets/myAchievementWidget.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/widgets/profileAvatarWidget.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/widgets/profileShimmer.dart';

import '../../authPage/providers/googleSignInProvider.dart';
import '../widgets/dailyMissionWidget.dart';
import '../widgets/levelUpRuleWidget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _controller = TextEditingController();

  Future<UserModel> getUserProfile() async {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel userModel, options) =>
                userModel.toFirestore())
        .doc(FirebaseAuth.instance.currentUser!.uid);
    final userModel = await docRef.get().then((value) => value.data());
    return Future.value(userModel);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.clear();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserModel>(
        future: getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SingleChildScrollView(
              child: ProfileShimmer(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(children: [
                Text("讀取個人資料發生問題"),
                ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text("重試"))
              ]),
            );
          }
          final userModel = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                ProfileAvatarWidget(userModel: userModel),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    _controller =
                        TextEditingController(text: userModel.userName!);
                    _showDialog();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userModel.userName!,
                        style: TextStyle(fontSize: 25),
                      ),
                      Icon(
                        Icons.edit,
                        size: 15,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                DailyMission(userModel: userModel),
                SizedBox(
                  height: 5,
                ),
                MyAchievement(userModel: userModel),
                SizedBox(
                  height: 5,
                ),
                LevelUpRule(),
                SizedBox(
                  height: 5,
                ),
                TextButton.icon(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.logout();
                    },
                    icon: Icon(Icons.logout),
                    label: Text("登出"))
              ],
            ),
          );
        },
      ),
    );
  }

  _showDialog() async {
    showDialog<Null>(
      context: context,
      builder: (ctx) => Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Center(
          child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 32, left: 32, right: 32, bottom: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '修改名字',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    maxLength: 12,
                    controller: _controller,
                    autofocus: true,
                    decoration: new InputDecoration(
                        labelText: 'Full Name', hintText: 'eg. 王小明'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "取消",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            upDateUserName();
                          },
                          child: Text("確認", style: TextStyle(fontSize: 20)))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> upDateUserName() async {
    EasyLoading.show(status: "變更名字中..");
    final userDocRef = FirebaseFirestore.instance
        .collection('users')
        .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel userModel, options) =>
                userModel.toFirestore())
        .doc(FirebaseAuth.instance.currentUser!.uid);
    try {
      await userDocRef.update({"userName": _controller.text});
      Navigator.of(context).pop();
      setState(() {});
      _controller.clear();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("網路異常，變更名稱失敗。"),
      ));
    }
    EasyLoading.dismiss();
  }
}
