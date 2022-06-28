import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../mainPostPage/widgets/postLabel.dart';

class LocWeatherPicker extends StatefulWidget {
  const LocWeatherPicker({Key? key}) : super(key: key);

  @override
  State<LocWeatherPicker> createState() => _LocWeatherPickerState();
}

class _LocWeatherPickerState extends State<LocWeatherPicker> {
  late FixedExtentScrollController weatehrScrollController;
  final _weatherOptions = ["太陽", "陰天", "下雨"];
  int _weatherIndex = 0;

  @override
  void initState() {
    super.initState();
    weatehrScrollController =
        FixedExtentScrollController(initialItem: _weatherIndex);
  }

  @override
  void dispose() {
    super.dispose();
    weatehrScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PostLabel(
          rainLevel: _weatherIndex,
        ),
        TextButton(
            onPressed: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                        actions: [buildWeatherPicker()],
                        cancelButton: CupertinoActionSheetAction(
                            onPressed: () => Navigator.pop(context),
                            child: Text("取消")),
                      ));
            },
            child: Text("選擇天氣"))
      ],
    );
  }

  Widget buildWeatherPicker() {
    weatehrScrollController.dispose();
    weatehrScrollController =
        FixedExtentScrollController(initialItem: _weatherIndex);
    return SizedBox(
      height: 350,
      child: CupertinoPicker(
          scrollController: weatehrScrollController,
          itemExtent: 64,
          onSelectedItemChanged: (index) {
            setState(() {
              _weatherIndex = index;
            });
          },
          children: [
            for (final item in _weatherOptions)
              Center(
                child: Text(
                  item,
                  style: TextStyle(fontSize: 32),
                ),
              )
          ]),
    );
  }
}
