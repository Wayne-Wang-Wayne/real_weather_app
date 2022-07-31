import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/userModel.dart';

class SignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  // Google Sign In
  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);
      final checkUserResult = await checkIsUserAlreadyExisted();
      if (!checkUserResult!.exists) {
        await addNewUser();
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?>
      checkIsUserAlreadyExisted() async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  Future<void> addNewUser() async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    final userModel = UserModel(
        userId: currentUser.uid,
        userName: currentUser.displayName,
        userImageUrl: currentUser.photoURL,
        userExp: 0,
        userLevel: 0,
        postTime: 0,
        likedTime: 0,
        postList: [],
        userTitle: "",
        lastSingInTimestamp: 0,
        lastPostTimestamp: 0);

    final docRef = FirebaseFirestore.instance
        .collection('users')
        .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel userModel, options) =>
                userModel.toFirestore())
        .doc(currentUser.uid);
    await docRef.set(userModel);
  }

  Future<void> fBLogin() async {
    var existingEmail = null;
    var pendingCred = null;
    try {
      final fbLoginResult = await FacebookAuth.instance.login();
      final facebookAuthCredential =
          FacebookAuthProvider.credential(fbLoginResult.accessToken!.token);

      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      final checkUserResult = await checkIsUserAlreadyExisted();
      if (!checkUserResult!.exists) {
        await addNewUser();
      }
    } catch (error) {
      print(e.toString());
    }
    notifyListeners();
  }
}
