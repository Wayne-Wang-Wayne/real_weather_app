import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:real_weather_shared_app/mainPage/models/userModel.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/screens/EditNotifyPage.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/widgets/deleteAccountDialog.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/widgets/editUserNameDialog.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/widgets/myAchievementWidget.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/widgets/profileAvatarWidget.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/widgets/profileShimmer.dart';

import '../../../utils/someTools.dart';
import '../../authPage/providers/googleSignInProvider.dart';
import '../widgets/dailyMissionAndAchievementWidget.dart';
import '../widgets/levelUpRuleWidget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text("讀取個人資料發生問題"),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text("重試")),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      final provider =
                          Provider.of<SignInProvider>(context, listen: false);
                      provider.logout();
                    },
                    child: Text("登出後重試"))
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
                    _showRenameDialog(userModel.userName!);
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
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.notifications_active_rounded,
                    size: 15,
                    color: Colors.yellow.shade700,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(EditNotifyPage.routeName);
                  },
                  label: Text(
                    "管理我的訂閱通知",
                    style: TextStyle(),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                ),
                DailyMissionAndAchievement(userModel: userModel),
                LevelUpRule(),
                SizedBox(
                  height: 5,
                ),
                TextButton.icon(
                    onPressed: () async {
                      final hasInternet = await MyTools.hasInternet(context);
                      if (!hasInternet) return;
                      final provider =
                          Provider.of<SignInProvider>(context, listen: false);
                      provider.logout();
                    },
                    icon: Icon(Icons.logout),
                    label: Text("登出")),
                SizedBox(
                  height: 5,
                ),
                TextButton.icon(
                  onPressed: () async {
                    final hasInternet = await MyTools.hasInternet(context);
                    if (!hasInternet) return;
                    _showDeleteAccountDialog();
                  },
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                    size: 16,
                  ),
                  label: Text(
                    "刪除帳號",
                    style: TextStyle(color: Colors.red, fontSize: 13),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void refreshProfilePage() {
    setState(() {});
  }

  _showRenameDialog(String userName) async {
    showDialog<Null>(
      context: context,
      builder: (ctx) => EditUserNameDialog(
          refreshProfileScreen: refreshProfilePage, userName: userName),
    );
  }

  _showDeleteAccountDialog() async {
    showDialog<Null>(
      context: context,
      builder: (ctx) => DeleteAccountDialog(),
    );
  }
}
