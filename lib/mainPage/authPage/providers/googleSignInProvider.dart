import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:real_weather_shared_app/utils/someTools.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../models/userModel.dart';

class SignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  // Google Sign In
  Future googleLogin(BuildContext context,
      [String? email, facebookCredential]) async {
    try {
      final hasInternet = await MyTools.hasInternet(context);
      if (!hasInternet) return;
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await _firebaseCredential(context, credential);
    } catch (e) {
      print(e.toString());
    }
  }

  Future logout() async {
    try {
      await googleSignIn.disconnect();
    } catch (error) {}

    try {
      await FacebookAuth.instance.logOut();
    } catch (error) {}

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
        userName: currentUser.displayName ?? "初心者用戶",
        userImageUrl: currentUser.photoURL ?? MyTools.defaultAvatarLink,
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

  Future fBLogin(BuildContext context) async {
    var existingEmail = null;
    var pendingCred = null;
    try {
      final hasInternet = await MyTools.hasInternet(context);
      if (!hasInternet) return;
      final fbLoginResult = await FacebookAuth.instance.login();
      final facebookAuthCredential =
          FacebookAuthProvider.credential(fbLoginResult.accessToken!.token);

      await _firebaseCredential(context, facebookAuthCredential);
    } catch (error) {
      print(e.toString());
    }
  }

  _firebaseCredential(BuildContext context, credential) async {
    try {
      User user =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
      final checkUserResult = await checkIsUserAlreadyExisted();
      if (!checkUserResult!.exists) {
        await addNewUser();
      }
      notifyListeners();
      //await firebaseProfile.updateUserData(context, user);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'account-exists-with-different-credential') {
        String email = error.email!;
        List<String> signInMethods =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
        var user;
        switch (signInMethods.first) {
          case 'google.com':
            user = await googleLogin(context, email, credential);
            break;
          case 'facebook.com':
            user = await fBLogin(context);
            break;
          case 'apple.com':
            await signInWithApple(context);
            break;
          case 'password':
            // since password is managed by user we force have email provider only
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('auth.signInMethods_password')));
            break;
          // TODO: apple
        }
        await linkProvider(context, credential);
        return user;
      }

      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message!)));
    }
  }

  Future linkProvider(BuildContext context, credential) async {
    try {
      await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('auth.provider_already_linked')));
          break;
        case "invalid-credential":
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('auth.invalid_credential')));
          break;
        case "credential-already-in-use":
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('auth.credential_already_in_use')));
          break;
        default:
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('auth.something_happened')));
      }
    }
  }

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> signInWithApple(BuildContext context) async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    await _firebaseCredential(context, oauthCredential);
  }
}
