import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/someTools.dart';
import '../../models/userModel.dart';

class ProfileAvatarWidget extends StatefulWidget {
  final UserModel userModel;
  ProfileAvatarWidget({Key? key, required this.userModel}) : super(key: key);

  @override
  State<ProfileAvatarWidget> createState() => _ProfileAvatarWidgetState();
}

class _ProfileAvatarWidgetState extends State<ProfileAvatarWidget> {
  bool isLoading = false;

  void _showErrorDialog() {
    showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("更新頭貼失敗！"),
              content: Text("請檢查網路。"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("確認"))
              ],
            ));
  }

  void errorHandel() {
    EasyLoading.dismiss();
    setState(() {
      _showErrorDialog();
      isLoading = false;
    });
  }

  Future<void> _pickPictureFromGallery() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);
    if (imageFile == null) {
      return;
    }
    setState(() {
      isLoading = true;
      EasyLoading.showProgress(0, status: '更新頭貼中.. 0%');
    });

    try {
      final userUid = FirebaseAuth.instance.currentUser!.uid;
      final avatarRef = FirebaseStorage.instance
          .ref()
          .child("user_avatar")
          .child("$userUid.jpg");
      final uploadImageTask = avatarRef.putFile(File(imageFile.path));
      uploadImageTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress = (100.0 *
                    (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes))
                .toInt();
            EasyLoading.showProgress(
                taskSnapshot.bytesTransferred / taskSnapshot.totalBytes,
                status: '更新頭貼中.. $progress%');
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            errorHandel();
            break;
          case TaskState.error:
            errorHandel();
            break;
          case TaskState.success:
            final imageUrl = await avatarRef.getDownloadURL();
            final docRef = FirebaseFirestore.instance
                .collection('users')
                .withConverter(
                    fromFirestore: UserModel.fromFirestore,
                    toFirestore: (UserModel userModel, options) =>
                        userModel.toFirestore())
                .doc(userUid);

            await docRef.update({"userImageUrl": imageUrl});
            EasyLoading.dismiss();
            setState(() {
              widget.userModel.userImageUrl = imageUrl;
              isLoading = false;
            });
            break;
        }
      });
    } catch (error) {
      errorHandel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.grey.shade200,
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage(widget.userModel.userImageUrl!),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "更換大頭貼",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ))
        : Column(
            children: [
              Container(
                height: 120,
                width: 120,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.userModel.userImageUrl!),
                  backgroundColor: Colors.transparent,
                ),
              ),
              TextButton(
                  onPressed: () async {
                    final hasInternet = await MyTools.hasInternet(context);
                    if (!hasInternet) return;
                    _pickPictureFromGallery();
                  },
                  child: Text(
                    "更換大頭貼",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          );
  }
}
