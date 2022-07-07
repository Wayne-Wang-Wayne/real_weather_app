import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/postModel.dart';
import '../../models/userModel.dart';

class MainPostProvider extends ChangeNotifier {
  Future<void> likePost(PostModel postModel) async {
    final postDocRef = FirebaseFirestore.instance
        .collection("posts")
        .withConverter(
            fromFirestore: PostModel.fromFirestore,
            toFirestore: (PostModel postModel, options) =>
                postModel.toFirestore())
        .doc(postModel.postId);

    final userDocRef = FirebaseFirestore.instance
        .collection('users')
        .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel userModel, options) =>
                userModel.toFirestore())
        .doc(postModel.posterUserId);

    //記錄貼文讚和到貼問者資料裡記一筆
    FirebaseFirestore.instance
        .runTransaction((transaction) async {
          DocumentSnapshot postSnapshot = await transaction.get(postDocRef);
          DocumentSnapshot userSnapshot = await transaction.get(userDocRef);
          if (!postSnapshot.exists) {
            throw Exception("Post does not exist!");
          }
          if (!userSnapshot.exists) {
            throw Exception("User does not exist!");
          }
          List<dynamic> likedPeopleList =
              (postSnapshot.data() as Map)["likedPeopleList"];
          int likedTime = (userSnapshot.data() as Map)["likedTime"];
          if (likedPeopleList
              .contains(FirebaseAuth.instance.currentUser!.uid)) {
            likedPeopleList.remove(FirebaseAuth.instance.currentUser!.uid);
            likedTime -= 1;
          } else {
            likedPeopleList.add(FirebaseAuth.instance.currentUser!.uid);
            likedTime += 1;
          }
          transaction.update(postDocRef, {'likedPeopleList': likedPeopleList});
          transaction.update(userDocRef, {'likedTime': likedTime});

          return likedPeopleList;
        })
        .then((value) {})
        .catchError((error) {});
  }
}
