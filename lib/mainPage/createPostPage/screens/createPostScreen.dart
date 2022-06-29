import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/createPostPage/widgets/pictureWidget.dart';
import 'package:real_weather_shared_app/mainPage/createPostPage/widgets/postTextField.dart';

import '../widgets/locAndWeatherPicker.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({Key? key}) : super(key: key);
  static const routeName = "/create-post";
  File? _imageFile;
  int? _rainLevel = 0;
  String? _pickedCity;
  String? _pickedTown;
  String? _postText;
  bool isInfoComplete = false;

  void _getImageFile(File imageFile) {
    this._imageFile = imageFile;
  }

  void _getLocAndRainLevel(
      int rainLevel, String pickedCity, String pickedTown) {
    this._rainLevel = rainLevel;
    this._pickedCity = pickedCity;
    this._pickedTown = pickedTown;
  }

  void _getPostText(String postText) {
    this._postText = postText;
  }

  Future<void> createPost(BuildContext context) async {
    if (_imageFile == null) {
      return;
    }
    if (_postText == null || _postText == "") {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onPressed: () {
                createPost(context);
              },
              child: Text(
                "完成",
                style: TextStyle(color: Colors.blueAccent, fontSize: 20),
              ))
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AddPictureWidget(imageFileCallBack: _getImageFile),
                LocWeatherPicker(),
                PostTextField(postTextCallBack: _getPostText),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
