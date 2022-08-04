import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:real_weather_shared_app/mainPage/models/postModel.dart';
import 'package:real_weather_shared_app/utils/someTools.dart';

class PostMoreOptionWidget extends StatelessWidget {
  PostModel postModel;
  final Function(String) updateDeleteCallBack;
  PostMoreOptionWidget(
      {Key? key, required this.postModel, required this.updateDeleteCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> deletePost() async {
      try {
        final postRef = FirebaseFirestore.instance
            .collection('posts')
            .doc(postModel.postId);
        final replyRef = FirebaseFirestore.instance
            .collection('replies')
            .doc(postModel.postId);
        EasyLoading.show(status: "刪除中..");
        await postRef.delete();
        await replyRef.delete();
        await FirebaseStorage.instance.refFromURL(postModel.imageUrl!).delete();
        EasyLoading.dismiss();
        updateDeleteCallBack(postModel.postId!);
      } catch (error) {
        EasyLoading.dismiss();
      }
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
          items: <String>[
            postModel.posterUserId == FirebaseAuth.instance.currentUser!.uid
                ? '刪除貼文'
                : '檢舉貼文'
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (todo) {
            switch (todo) {
              case '刪除貼文':
                {
                  MyTools.showSimpleDialog(context, "確定要刪除貼文？",
                      cancelable: false,
                      wordingFontSize: 18,
                      positiveCallBack: () {
                        deletePost();
                      },
                      negativeCallBack: () => Navigator.pop(context));
                  break;
                }
              case '檢舉貼文':
                {
                  break;
                }
            }
          },
          icon: Icon(Icons.more_vert_outlined),
          underline: null),
    );
  }
}
