import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:real_weather_shared_app/mainPage/createPostPage/widgets/createPostShimmer.dart';
import 'package:real_weather_shared_app/mainPage/createPostPage/widgets/pictureWidget.dart';
import 'package:real_weather_shared_app/mainPage/createPostPage/widgets/postTextField.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/screens/mainPostScreen.dart';
import 'package:real_weather_shared_app/utils/someTools.dart';
import 'package:uuid/uuid.dart';

import '../../models/postModel.dart';
import '../../models/userModel.dart';
import '../widgets/areaPicker.dart';
import '../widgets/weatherPicker.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({Key? key}) : super(key: key);
  static const routeName = "/create-post";

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  bool isLoading = false;
  bool canPop = true;

  File? _imageFile;

  int? _rainLevel = 0;

  String? _pickedCity = MainPostScreen.staticCurrentLocation[0];

  String? _pickedTown = MainPostScreen.staticCurrentLocation[1];

  String? _postText;

  void _getImageFile(File imageFile) {
    this._imageFile = imageFile;
    setState(() {});
  }

  void _getRainLevel(int rainLevel) {
    this._rainLevel = rainLevel;
    setState(() {});
  }

  void _getArea(String pickedCity, String pickedTown) {
    this._pickedCity = pickedCity;
    this._pickedTown = pickedTown;
    setState(() {});
  }

  void _getPostText(String postText) {
    this._postText = postText;
    setState(() {});
  }

  void _showErrorDialog() {
    showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("無法上傳"),
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
      canPop = true;
      isLoading = false;
    });
  }

  Future<void> createPost(BuildContext context) async {
    final hasInternet = await MyTools.hasInternet(context);
    if (!hasInternet) return;
    if (_imageFile == null) {
      return;
    }
    if (_postText == null || _postText == "") {
      return;
    }
    if (_postText!.length > 250) {
      MyTools.showSimpleDialog(context, "請精簡扼要，字數勿超過250字！",
          wordingFontSize: 20);
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      setState(() {
        EasyLoading.showProgress(0.0, status: '貼文產生中.. 0%');
        canPop = false;
        isLoading = true;
      });

      final postUid = Uuid().v4();
      final postImageRef = FirebaseStorage.instance
          .ref()
          .child("post_image")
          .child("$postUid.jpg");
      final uploadImageTask = postImageRef.putFile(_imageFile!);

      uploadImageTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            int progress = (100.0 *
                    (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes))
                .toInt();
            if (progress >= 99) progress = 99;
            EasyLoading.showProgress(
                taskSnapshot.bytesTransferred / taskSnapshot.totalBytes,
                status: '貼文產生中.. $progress%');
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            break;
          case TaskState.error:
            errorHandel();
            break;
          case TaskState.success:
            final imageUrl = await postImageRef.getDownloadURL();
            final postRef = FirebaseFirestore.instance
                .collection("posts")
                .withConverter(
                    fromFirestore: PostModel.fromFirestore,
                    toFirestore: (PostModel postModel, options) =>
                        postModel.toFirestore())
                .doc(postUid);
            final userDocRef = FirebaseFirestore.instance
                .collection('users')
                .withConverter(
                    fromFirestore: UserModel.fromFirestore,
                    toFirestore: (UserModel userModel, options) =>
                        userModel.toFirestore())
                .doc(FirebaseAuth.instance.currentUser!.uid);
            UserModel? userModel =
                await userDocRef.get().then((value) => value.data());
            bool _hasPost = MyTools.checkIsToday(userModel!.lastPostTimestamp!);
            final locCode = MyTools.getLocCode(_pickedCity!, _pickedTown!);
            await postRef.set(PostModel(
                postId: postUid,
                imageUrl: imageUrl,
                postText: _postText,
                postDateTimeStamp: DateTime.now().millisecondsSinceEpoch,
                likedPeopleList: [],
                rainLevel: _rainLevel,
                posterUserId: FirebaseAuth.instance.currentUser!.uid,
                postCity: _pickedCity,
                postTown: _pickedTown,
                locCode: locCode));
            if (!_hasPost) {
              await userDocRef.update({
                "postTime": userModel.postTime! + 1,
                "lastPostTimestamp": DateTime.now().millisecondsSinceEpoch,
                "userExp": userModel.userExp! + 25
              });
            }
            EasyLoading.dismiss();
            setState(() {
              canPop = true;
              isLoading = false;
              Navigator.of(context).pop(true);
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
    return WillPopScope(
      onWillPop: () async {
        return canPop;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            "發佈貼文",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  final hasInternet = await MyTools.hasInternet(context);
                  if (!hasInternet) return;
                  if (_imageFile != null &&
                      _pickedCity != null &&
                      _pickedTown != null &&
                      _postText != null &&
                      _postText != "" &&
                      !isLoading) {
                    MyTools.showSimpleDialog(context, "確定要發出貼文？",
                        positiveCallBack: () => {createPost(context)},
                        wordingFontSize: 18,
                        cancelable: true);
                  }
                },
                child: Text(
                  "完成",
                  style: TextStyle(
                      color: (_imageFile == null ||
                              _pickedCity == null ||
                              _pickedTown == null ||
                              _postText == null ||
                              _postText == "" ||
                              isLoading)
                          ? Colors.grey
                          : Colors.blueAccent,
                      fontSize: 20),
                ))
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: isLoading
              ? CreatePostShimmer()
              : Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AddPictureWidget(imageFileCallBack: _getImageFile),
                        WeatherPicker(rainLevelCallBack: _getRainLevel),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AreaPicker(
                              areaCallBack: _getArea,
                            ),
                          ],
                        ),
                        PostTextField(postTextCallBack: _getPostText),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
