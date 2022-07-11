import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/fetchUserBottomSheetInfo.dart';
import 'package:real_weather_shared_app/utils/userInfoWidget.dart';

import '../mainPage/models/postModel.dart';

class MyTools {
  static String getReadableTime(int timeStamp) {
    var dt = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    var duration = DateTime.now().difference(dt);
    var readableTime = DateFormat('yyyy/MM/dd HH:mm').format(dt);
    if (duration.inDays == 1) {
      readableTime = "昨天 ${DateFormat('HH:mm').format(dt)}";
    }
    if (duration.inDays == 2) {
      readableTime = "前天 ${DateFormat('HH:mm').format(dt)}";
    }
    if (duration.inHours < 24) {
      readableTime = "${duration.inHours}小時前";
    }
    if (duration.inMinutes < 60) {
      readableTime = "${duration.inMinutes}分鐘前";
    }
    if (duration.inSeconds < 60) {
      readableTime = "${duration.inSeconds}秒鐘前";
    }
    return readableTime;
  }

  static void showUserInfo(
      {required BuildContext context, PostModel? postModel, String? userUid}) {
    if (postModel != null && userUid == null) {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          isScrollControlled: true,
          context: context,
          builder: (context) => UserInfoWidget(postModel: postModel));
    }

    if (postModel == null && userUid != null) {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          isScrollControlled: true,
          context: context,
          builder: (context) => FetchUserBottomSheet(userUid: userUid));
    }
  }
}
