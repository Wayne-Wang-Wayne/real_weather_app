import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PostTextField extends StatefulWidget {
  Function(String) postTextCallBack;
  PostTextField({Key? key, required this.postTextCallBack}) : super(key: key);

  @override
  State<PostTextField> createState() => _PostTextFieldState();
}

class _PostTextFieldState extends State<PostTextField> {
  final _controller = TextEditingController();
  String postText = "";

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _controller,
              decoration: InputDecoration.collapsed(
                  hintText: "請寫下你的想法！",
                  hintStyle: TextStyle(color: Colors.grey)),
              onChanged: (value) {
                setState(() {
                  postText = value;
                  widget.postTextCallBack(postText);
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.clear();
  }
}
