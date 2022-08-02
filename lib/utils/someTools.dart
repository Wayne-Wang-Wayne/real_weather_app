import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/fetchUserBottomSheetInfo.dart';
import 'package:real_weather_shared_app/utils/simpleDialogWidget.dart';
import 'package:real_weather_shared_app/utils/userInfoWidget.dart';
import 'package:url_launcher/url_launcher.dart';

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

  static showSimpleDialog(BuildContext context, String simpleString) async {
    showDialog<Null>(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => SimpleDialogBody(simpleString: simpleString),
    );
  }

  Future<List<String>> getCurrentLocation(BuildContext context) async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        MyTools.showSimpleDialog(
            context, "如想體驗自動定位，煩請再手動開啟位置權限，謝謝您。(將以預設位置顯示)");
      } else {
        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            MyTools.showSimpleDialog(
                context, "如想體驗自動定位，煩請再手動開啟位置權限，謝謝您。(將以預設位置顯示)");
          } else {
            return await _fetchLocDetail(location);
          }
        } else {
          return await _fetchLocDetail(location);
        }
      }
    } else {
      MyTools.showSimpleDialog(context, "如想體驗自動定位，煩請再手動開啟位置權限，謝謝您。(將以預設位置顯示)");
    }
    return ["臺北市", "中正區"];
  }

  Future<List<String>> _fetchLocDetail(Location location) async {
    LocationData _locationData;
    _locationData = await location.getLocation();
    try {
      final response = await get(Uri.parse(
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=${_locationData.latitude},${_locationData.longitude}&language=zh-TW&key=AIzaSyCB1bluJpoXlSHbICx713NMtOYaXC4YU48"));
      if (json.decode(response.body) != null) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        final locDetail = extractedData["results"] as List<dynamic>;
        if (locDetail.isNotEmpty) {
          final List<String> currentLocate = ["臺北市", "中正區"];
          (locDetail[0]["address_components"] as List<dynamic>)
              .forEach((value) {
            value as Map<dynamic, dynamic>;
            switch (value["types"][0]) {
              case "administrative_area_level_3":
                {
                  currentLocate[1] =
                      (value["long_name"] as String).replaceAll("台", "臺");
                  break;
                }
              case "administrative_area_level_2":
                {
                  currentLocate[0] =
                      (value["long_name"] as String).replaceAll("台", "臺");
                  break;
                }
              case "administrative_area_level_1":
                {
                  currentLocate[0] =
                      (value["long_name"] as String).replaceAll("台", "臺");
                  break;
                }
            }
          });
          return currentLocate;
        }
        ;
      }
    } catch (error) {}
    return ["臺北市", "中正區"];
  }

  static bool checkIsToday(int lastTimestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    var dateToCheck = DateTime.fromMillisecondsSinceEpoch(lastTimestamp);
    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (aDate == today) {
      return true;
    } else {
      return false;
    }
  }

  static int getCurrentLevel(int endExp) {
    int tempExp = 0;
    int currentLevel = 0;
    while (endExp - tempExp >= 0) {
      currentLevel++;
      endExp -= tempExp;
      tempExp += 75;
    }
    return currentLevel;
  }

  static String getUserTitle(int userExp) {
    // todo 到時候規則出來要完善邏輯
    return "天氣專家";
  }

  static Future<void> launchMyUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
