import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../../utils/someTools.dart';
import '../../authPage/providers/googleSignInProvider.dart';
import '../../models/userModel.dart';

class DeleteAccountDialog extends StatefulWidget {
  DeleteAccountDialog({Key? key}) : super(key: key);

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
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
                const EdgeInsets.only(top: 28, left: 32, right: 32, bottom: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '帳號一經刪除將無法找回，原帳號所擁有之紀錄及個人資料也將隨之消失。\n\n確定要刪除帳號？',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: '如要刪除請輸入"確定刪除"並按確認鍵',
                    errorText: _validate ? '請正確輸入' : null,
                  ),
                  onChanged: (value) {
                    if (value != "確定刪除") {
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
                        onPressed: () async {
                          final hasInternet =
                              await MyTools.hasInternet(context);
                          if (!hasInternet) return;
                          if (_controller!.text != "確定刪除") {
                            setState(() {
                              _validate = true;
                            });
                            return;
                          }
                          setState(() {
                            _validate = false;
                          });
                          deleteAccount();
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

  Future<void> deleteAccount() async {
    EasyLoading.show(status: "帳號刪除中..");
    final userDocRef = FirebaseFirestore.instance
        .collection('users')
        .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel userModel, options) =>
                userModel.toFirestore())
        .doc(FirebaseAuth.instance.currentUser!.uid);
    try {
      UserModel? userModel =
          await userDocRef.get().then((value) => value.data());
      await userDocRef.delete();
      try {
        await FirebaseStorage.instance
            .refFromURL(userModel!.userImageUrl!)
            .delete();
      } catch (error) {
        print('image not found');
      }
      Navigator.of(context).pop();
      final provider = Provider.of<SignInProvider>(context, listen: false);
      provider.logout();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("網路異常，帳號刪除失敗。"),
      ));
    }
    EasyLoading.dismiss();
  }
}
