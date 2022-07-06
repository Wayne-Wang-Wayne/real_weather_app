import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:real_weather_shared_app/mainPage/models/userModel.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/widgets/myAchievementWidget.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/widgets/profileAvatarWidget.dart';

import '../../authPage/providers/googleSignInProvider.dart';
import '../widgets/dailyMissionWidget.dart';
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
            return Center(
              child: CircularProgressIndicator(),
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
                Row(
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
}
