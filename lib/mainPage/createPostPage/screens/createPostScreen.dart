import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:real_weather_shared_app/mainPage/createPostPage/providers/createPostProvider.dart';
import 'package:real_weather_shared_app/mainPage/createPostPage/widgets/pictureWidget.dart';
import 'package:real_weather_shared_app/mainPage/createPostPage/widgets/postTextField.dart';
import 'package:uuid/uuid.dart';

import '../widgets/areaPicker.dart';
import '../widgets/weatherPicker.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({Key? key}) : super(key: key);
  static const routeName = "/create-post";

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  File? _imageFile;

  int? _rainLevel = 0;

  String? _pickedCity = "臺北市";

  String? _pickedTown = "中正區";

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

  Future<void> createPost(BuildContext context) async {
    if (_imageFile == null) {
      return;
    }
    if (_postText == null || _postText == "") {
      return;
    }
    try {
      Provider.of<CreatePostProvider>(context, listen: false)
          .createPost(_imageFile!, _postText!, DateTime.now(), 0, _rainLevel!,
              _pickedCity!, _pickedTown!)
          .then((value) => Navigator.of(context).pop());
    } catch (error) {
      await showDialog<Null>(
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
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<CreatePostProvider>(context).isLoading;
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
                if (_imageFile != null &&
                    _pickedCity != null &&
                    _pickedTown != null &&
                    _postText != null &&
                    _postText != "") {
                  createPost(context);
                }
              },
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      "完成",
                      style: TextStyle(
                          color: (_imageFile != null &&
                                  _pickedCity != null &&
                                  _pickedTown != null &&
                                  _postText != null &&
                                  _postText != "")
                              ? Colors.blueAccent
                              : Colors.grey,
                          fontSize: 20),
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
    );
  }
}
