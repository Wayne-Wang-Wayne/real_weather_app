import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/widgets/notifyItem.dart';
import 'package:real_weather_shared_app/utils/someTools.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/areaData.dart';

class EditNotifyPage extends StatefulWidget {
  const EditNotifyPage({Key? key}) : super(key: key);
  static const routeName = "/edit-notify";

  @override
  State<EditNotifyPage> createState() => _EditNotifyPageState();
}

class _EditNotifyPageState extends State<EditNotifyPage> {
  SharedPreferences? prefs;
  List<String> subscribeList = [];
  String listKey = "subscribeListKey";

  _createPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _createPref();
      subscribeList = prefs!.getStringList(listKey) ?? [];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    void _unsuscribeLocation(String locationName) {
      subscribeList.remove(locationName);
      prefs!.setStringList(listKey, subscribeList);
      final cityName = locationName.split(" ")[0];
      final townName = locationName.split(" ")[1];
      final locCode = MyTools.getLocCode(cityName, townName);
      FirebaseMessaging.instance.unsubscribeFromTopic(locCode);
      setState(() {});
    }

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
        actions: [
          TextButton(
              onPressed: () {
                if (subscribeList.length >= 6) {
                  MyTools.showSimpleDialog(context, "最多只能訂閱六個地點！",
                      wordingFontSize: 20);
                } else {
                  _showPicker(context);
                }
              },
              child: Text(
                "新增",
                style: TextStyle(color: Colors.blueAccent, fontSize: 20),
              ))
        ],
      ),
      body: subscribeList.isEmpty
          ? Center(child: Text("目前沒有訂閱的通知，趕快按右上角新增。"))
          : ListView.builder(
              itemBuilder: (context, index) => NotifyItem(
                  key: ValueKey(Timestamp.now().toString()),
                  locationName: subscribeList[index],
                  unsubscribe: _unsuscribeLocation),
              itemCount: subscribeList.length,
            ),
    );
  }

  _showPicker(BuildContext context) async {
    Picker(
            height: 85,
            itemExtent: 40,
            adapter: PickerDataAdapter<String>(
                pickerdata: AreaData().areaDataForMainPostPicker),
            hideHeader: true,
            title: Text("訂閱地點"),
            selectedTextStyle: TextStyle(color: Colors.blue),
            onConfirm: (Picker picker, List value) {
              List<String> pickedLocation =
                  picker.getSelectedValues() as List<String>;
              String pickedString = "${pickedLocation[0]} ${pickedLocation[1]}";
              if (subscribeList.contains(pickedString)) {
                MyTools.showSimpleDialog(context, "您已經訂閱過這個地點！",
                    wordingFontSize: 20);
              } else {
                subscribeList.add(pickedString);
                prefs!.setStringList(listKey, subscribeList);
                final locCode =
                    MyTools.getLocCode(pickedLocation[0], pickedLocation[1]);
                FirebaseMessaging.instance.subscribeToTopic(locCode);
                setState(() {});
              }
            },
            confirmText: "訂閱",
            cancelText: "取消")
        .showDialog(context);
  }
}
