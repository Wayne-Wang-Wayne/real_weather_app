import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:real_weather_shared_app/mainPage/models/postModel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/someTools.dart';

class MessageItem extends StatelessWidget {
  final Map<String, dynamic> reply;
  MessageItem({Key? key, required this.reply}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final replyItemModel = ReplyItemModel.convertToModel(reply);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(
          onTap: () => MyTools.showUserInfo(
              context: context, userUid: replyItemModel.replierId),
          child: Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(replyItemModel.replierAvatarUrl,
                  fit: BoxFit.cover),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => MyTools.showUserInfo(
                    context: context, userUid: replyItemModel.replierId),
                child: Row(
                  children: [
                    Text(
                      replyItemModel.replierName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "${MyTools.getUserTitle(replyItemModel.replierExp)} ( Lv. ${MyTools.getCurrentLevel(replyItemModel.replierExp)} )",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    )
                  ],
                ),
              ),
              Linkify(
                text: replyItemModel.replyContent,
                style: TextStyle(fontSize: 14),
                onOpen: (link) {
                  _launchUrl(Uri.parse(link.url));
                },
              ),
              Text(MyTools.getReadableTime(replyItemModel.replyDateTimestamp),
                  style: TextStyle(fontSize: 10, color: Colors.grey))
            ],
          ),
        )
      ]),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
