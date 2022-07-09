import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:real_weather_shared_app/mainPage/models/postModel.dart';

import '../../models/userModel.dart';

class NewMessageWidget extends StatefulWidget {
  final PostModel postModel;
  NewMessageWidget({Key? key, required this.postModel}) : super(key: key);

  @override
  State<NewMessageWidget> createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  var _enterMessage = "";

  @override
  Widget build(BuildContext context) {
    Future<void> _leaveMessage() async {
      final userDocRef = FirebaseFirestore.instance
          .collection('users')
          .withConverter(
              fromFirestore: UserModel.fromFirestore,
              toFirestore: (UserModel userModel, options) =>
                  userModel.toFirestore())
          .doc(FirebaseAuth.instance.currentUser!.uid);
      final replyDocRef = FirebaseFirestore.instance
          .collection('replies')
          .withConverter(
              fromFirestore: ReplyListModel.fromFirestore,
              toFirestore: (ReplyListModel replyListModel, options) =>
                  replyListModel.toFirestore())
          .doc(widget.postModel.postId);

      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot userSnapshot = await transaction.get(userDocRef);
        DocumentSnapshot replySnapshot = await transaction.get(replyDocRef);
        List<dynamic> tempReplyList = [];
        if (!userSnapshot.exists) {
          throw Exception("User does not exist!");
        }
        final userModel = userSnapshot.data() as Map;
        final Map<String, dynamic> newReplierData = {
          "postId": widget.postModel.postId,
          "replyContent": _enterMessage,
          "replyDateTimestamp": DateTime.now().millisecondsSinceEpoch,
          "replierName": userModel["userName"],
          "replierExp": userModel["userExp"],
          "replierAvatarUrl": userModel["userImageUrl"]
        };

        if (!replySnapshot.exists) {
          tempReplyList = [newReplierData];
        } else {
          final oldReplyList = (replySnapshot.data() as Map)["replyList"];
          print("");
          oldReplyList.add(newReplierData);
          tempReplyList = oldReplyList;
        }
        transaction.set(replyDocRef, ReplyListModel(replyList: tempReplyList));
        return tempReplyList;
      }).then((value) {
        print("object");
      }).catchError((error) {
        print("object");
      });
    }

    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: _controller,
            enableSuggestions: true,
            decoration: InputDecoration(labelText: "輸入訊息 ..."),
            onChanged: (value) {
              setState(() {
                _enterMessage = value;
              });
            },
          ),
        ),
        TextButton(
            onPressed: _enterMessage.trim().isEmpty
                ? null
                : () {
                    _leaveMessage();
                    FocusScope.of(context).unfocus();
                    _controller.clear();
                  },
            child: Text(
              "留言",
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ))
      ]),
    );
  }
}
