import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/widgets/notifyItem.dart';

import '../../models/areaData.dart';

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
        actions: [
          TextButton(
              onPressed: () {
                _showPicker(context);
              },
              child: Text(
                "新增",
                style: TextStyle(color: Colors.blueAccent, fontSize: 20),
              ))
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => NotifyItem(),
        itemCount: 1,
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
              // currentLocation = picker.getSelectedValues() as List<String>;
              // loadFirstData(needToRelocate: false);
            },
            confirmText: "訂閱",
            cancelText: "取消")
        .showDialog(context);
  }
}
