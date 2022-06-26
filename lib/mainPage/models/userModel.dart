import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String? userId;
  final String? userName;
  final String? userImageUrl;
  final int? userExp;
  final int? userLevel;
  final int? postTime;
  final int? likedTime;
  final List<String>? postList;

  UserModel(
      {this.userId,
      this.userName,
      this.userImageUrl,
      this.userExp,
      this.userLevel,
      this.postTime,
      this.likedTime,
      this.postList});

  factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return UserModel(
        userId: data?["userId"],
        userName: data?["userName"],
        userImageUrl: data?["userImageUrl"],
        userExp: data?["userExp"],
        userLevel: data?["userLevel"],
        postTime: data?["postTime"],
        likedTime: data?["likedTime"],
        postList: data?["postList"]);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (userId != null) "userId": userId,
      if (userName != null) "userName": userName,
      if (userImageUrl != null) "userImageUrl": userImageUrl,
      if (userExp != null) "userExp": userExp,
      if (userLevel != null) "userLevel": userLevel,
      if (postTime != null) "postTime": postTime,
      if (likedTime != null) "likedTime": likedTime,
      if (postList != null) "postList": postList
    };
  }
}
