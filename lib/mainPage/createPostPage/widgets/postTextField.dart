import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PostTextField extends StatefulWidget {
  const PostTextField({Key? key}) : super(key: key);

  @override
  State<PostTextField> createState() => _PostTextFieldState();
}

class _PostTextFieldState extends State<PostTextField> {
  final _controller = TextEditingController();
  String postText = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 250,
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
            decoration: InputDecoration.collapsed(hintText: "請寫下你的想法！"),
            onChanged: (value) {
              setState(() {
                postText = value;
              });
            },
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
