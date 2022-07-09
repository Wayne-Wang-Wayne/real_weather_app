import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PostMessageScreen extends StatelessWidget {
  const PostMessageScreen({Key? key}) : super(key: key);
  static const routeName = "/post-message";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.expand_more_outlined,
            color: Colors.black,
            size: 40,
          ),
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              "留言",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
