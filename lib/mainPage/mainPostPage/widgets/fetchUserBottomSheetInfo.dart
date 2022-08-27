import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/models/userModel.dart';
import 'package:real_weather_shared_app/utils/userInfoWidget.dart';

import 'fetchUserBottomSheetShimmer.dart';

class FetchUserBottomSheet extends StatelessWidget {
  final String userUid;
  FetchUserBottomSheet({Key? key, required this.userUid}) : super(key: key);

  Future<UserModel> fetchUserData() async {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel userModel, options) =>
                userModel.toFirestore())
        .doc(userUid);
    final userModel = await docRef.get().then((value) => value.data());
    return Future.value(userModel);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
        future: fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return FetchUserBottomSheetShimmer();
          }
          if (snapshot.hasError) {
            return Container(
                height: 300,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  "讀取個人資料發生問題",
                  style: TextStyle(fontSize: 15),
                ));
          }

          final userModel = snapshot.data;

          return UserInfoWidget(
            userModel: userModel,
          );
        });
  }
}
