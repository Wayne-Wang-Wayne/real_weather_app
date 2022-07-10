import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import '../../models/postModel.dart';
import 'messageItem.dart';
import 'newMessageWisget.dart';

class MsListAndNewMS extends StatefulWidget {
  final PostModel postModel;
  const MsListAndNewMS({Key? key, required this.postModel}) : super(key: key);

  @override
  State<MsListAndNewMS> createState() => _MsListAndNewMSState();
}

class _MsListAndNewMSState extends State<MsListAndNewMS> {
  @override
  void initState() {
    super.initState();
    _getMessage();
  }

  Future<ReplyListModel> _getMessage() async {
    final replyDocRef = FirebaseFirestore.instance
        .collection('replies')
        .withConverter(
            fromFirestore: ReplyListModel.fromFirestore,
            toFirestore: (ReplyListModel replyListModel, options) =>
                replyListModel.toFirestore())
        .doc(widget.postModel.postId);
    final replyListModel =
        await replyDocRef.get().then((value) => value.data());

    return Future.value(replyListModel);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [
        Expanded(
          child: FutureBuilder<ReplyListModel>(
            future: _getMessage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(child: Text("目前沒有留言"));
              }
              if (snapshot.data!.replyList == null) {
                return Center(child: Text("目前沒有留言"));
              }
              final reply = snapshot.data!.replyList;
              if (reply!.isEmpty) {
                return Center(child: Text("目前沒有留言"));
              }

              return RefreshIndicator(
                onRefresh: () {
                  return Future(() {
                    setState(() {});
                  });
                },
                child: ListView.builder(
                  itemBuilder: ((context, index) =>
                      MessageItem(reply: reply[index])),
                  itemCount: reply.length,
                ),
              );
            },
          ),
        ),
        NewMessageWidget(
          postModel: widget.postModel,
        )
      ]),
    );
  }
}
