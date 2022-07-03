import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/models/userModel.dart';

class PosterInfoWidget extends StatelessWidget {
  final String posterUserId;
  PosterInfoWidget({Key? key, required this.posterUserId}) : super(key: key);

  Future<UserModel> getUserDetail() async {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel userModel, options) =>
                userModel.toFirestore())
        .doc(posterUserId);
    final userInfo = await docRef.get();
    final data = userInfo.data();
    return Future.value(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserDetail(),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return getPosterInfoWidget(false);
          } else {
            if (snapshot.hasError) {
              return getPosterInfoWidget(false);
            } else {
              return getPosterInfoWidget(true, userModel: snapshot.data);
            }
          }
        });
  }

  Widget getPosterInfoWidget(bool isSucccess, {UserModel? userModel = null}) {
    return Row(children: [
      SizedBox(
        width: 10,
      ),
      Container(
        height: 55,
        width: 55,
        child: CircleAvatar(
          radius: 30,
          backgroundImage:
              isSucccess ? NetworkImage(userModel!.userImageUrl!) : null,
          backgroundColor: isSucccess ? Colors.transparent : Colors.white,
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userModel != null ? userModel.userName! : "XXX",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            userModel != null ? userModel.userTitle! : "未知階級",
            style: TextStyle(color: Colors.grey),
          )
        ],
      )
    ]);
  }
}
