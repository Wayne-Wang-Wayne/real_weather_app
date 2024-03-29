import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../mainPostPage/widgets/postLabel.dart';

class WeatherPicker extends StatefulWidget {
  Function(int) rainLevelCallBack;
  WeatherPicker({Key? key, required this.rainLevelCallBack}) : super(key: key);

  @override
  State<WeatherPicker> createState() => _WeatherPickerState();
}

class _WeatherPickerState extends State<WeatherPicker> {
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
                            child: Text("完成")),
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
            widget.rainLevelCallBack(index);
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
