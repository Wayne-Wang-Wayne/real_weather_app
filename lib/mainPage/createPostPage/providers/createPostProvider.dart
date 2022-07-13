import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uuid/uuid.dart';

import '../../models/postModel.dart';

class CreatePostProvider extends ChangeNotifier {
  bool isLoading = false;
  bool canPop = true;
  Future<void> createPost(
      File imageFile,
      String postText,
      DateTime postDate,
      int likeAmount,
      int rainLevel,
      String postCity,
      String postTown,
      Function showErrorDialog) async {
    EasyLoading.show(status: '處理中...');
    canPop = false;
    isLoading = true;
    notifyListeners();
    final postUid = Uuid().v4();
    final ref = FirebaseStorage.instance
        .ref()
        .child("post_image")
        .child("$postUid.jpg");

    try {
      await ref.putFile(imageFile).whenComplete(() async {
        final imageUrl = await ref.getDownloadURL();
        final docRef = FirebaseFirestore.instance
            .collection("posts")
            .withConverter(
                fromFirestore: PostModel.fromFirestore,
                toFirestore: (PostModel postModel, options) =>
                    postModel.toFirestore())
            .doc(postUid);
        await docRef.set(PostModel(
            postId: postUid,
            imageUrl: imageUrl,
            postText: postText,
            postDateTimeStamp: DateTime.now().millisecondsSinceEpoch,
            likedPeopleList: [],
            rainLevel: rainLevel,
            posterUserId: FirebaseAuth.instance.currentUser!.uid,
            postCity: postCity,
            postTown: postTown));
        canPop = true;
        isLoading = false;
        notifyListeners();
      });
    } catch (error) {
      EasyLoading.dismiss();
      showErrorDialog();
      canPop = true;
      isLoading = false;
      notifyListeners();
      throw error;
    }
  }
}
