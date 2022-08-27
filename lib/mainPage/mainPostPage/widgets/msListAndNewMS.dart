import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import '../../models/postModel.dart';
import 'messageItem.dart';
import 'messageListShimmer.dart';
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

  void messageSentCallBack() {
    setState(() {});
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
            child: RefreshIndicator(
          onRefresh: () {
            return Future(() {
              setState(() {});
            });
          },
          child: FutureBuilder<ReplyListModel>(
            future: _getMessage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return MessageListShimmer();
              }
              if (snapshot.hasError) {
                return getNoDataView();
              }
              if (snapshot.data == null) {
                return getNoDataView();
              }
              if (snapshot.data!.replyList == null) {
                return getNoDataView();
              }
              final reply = snapshot.data!.replyList;
              if (reply == null) {
                return getNoDataView();
              }
              if (reply.isEmpty) {
                return getNoDataView();
              }

              return ListView.builder(
                itemBuilder: ((context, index) => MessageItem(
                    key: ValueKey(Timestamp.now()), reply: reply[index])),
                itemCount: reply.length,
              );
            },
          ),
        )),
        NewMessageWidget(
            postModel: widget.postModel,
            messageSentCallBack: messageSentCallBack)
      ]),
    );
  }

  Widget getNoDataView() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
          child: Center(
            child: Text('目前沒有留言'),
          ),
          height: MediaQuery.of(context).size.height -
              kBottomNavigationBarHeight -
              AppBar().preferredSize.height -
              120),
    );
  }
}
