import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:real_weather_shared_app/mainPage/models/postModel.dart';

class PostMoreOptionWidget extends StatelessWidget {
  PostModel postModel;
  PostMoreOptionWidget({Key? key, required this.postModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          onChanged: (_) {},
          icon: Icon(Icons.more_vert_outlined),
          underline: null),
    );
  }
}
