import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../models/userModel.dart';

class EditUserNameDialog extends StatefulWidget {
  final void Function() refreshProfileScreen;
  final String userName;
  EditUserNameDialog(
      {Key? key, required this.refreshProfileScreen, required this.userName})
      : super(key: key);

  @override
  State<EditUserNameDialog> createState() => _EditUserNameDialogState();
}

class _EditUserNameDialogState extends State<EditUserNameDialog> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.userName);
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: Center(
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 32, left: 32, right: 32, bottom: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '修改名字',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLength: 12,
                  controller: _controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'eg. 王小明',
                    errorText: _validate ? '名字需長於兩個字' : null,
                  ),
                  onChanged: (value) {
                    if (value.length >= 2) {
                      setState(() {
                        _validate = false;
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "取消",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          if (_controller!.text.isEmpty ||
                              _controller!.text.length < 2) {
                            setState(() {
                              _validate = true;
                            });
                            return;
                          }
                          setState(() {
                            _validate = false;
                          });
                          upDateUserName();
                        },
                        child: Text("確認", style: TextStyle(fontSize: 20)))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> upDateUserName() async {
    EasyLoading.show(status: "變更名字中..");
    final userDocRef = FirebaseFirestore.instance
        .collection('users')
        .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel userModel, options) =>
                userModel.toFirestore())
        .doc(FirebaseAuth.instance.currentUser!.uid);
    try {
      await userDocRef.update({"userName": _controller!.text});
      widget.refreshProfileScreen();
      Navigator.of(context).pop();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("網路異常，變更名稱失敗。"),
      ));
    }
    EasyLoading.dismiss();
  }
}
