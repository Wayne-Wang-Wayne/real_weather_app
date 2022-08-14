import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditNotifyPage extends StatelessWidget {
  const EditNotifyPage({Key? key}) : super(key: key);
  static const routeName = "/edit-notify";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      title: Text(
        "我訂閱的通知",
        style: TextStyle(color: Colors.black),
      ),
    ));
  }
}
