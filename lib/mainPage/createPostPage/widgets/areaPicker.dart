import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/screens/mainPostScreen.dart';
import 'package:real_weather_shared_app/mainPage/models/areaData.dart';

class AreaPicker extends StatefulWidget {
  Function(String, String) areaCallBack;
  AreaPicker({Key? key, required this.areaCallBack}) : super(key: key);

  @override
  State<AreaPicker> createState() => _AreaPickerState();
}

class _AreaPickerState extends State<AreaPicker> {
  late FixedExtentScrollController _cityScrollController;
  late FixedExtentScrollController _townScrollController;
  final areaData = AreaData().area_data;
  int _cityIndex = 0;
  int _townIndex = 0;

  @override
  void initState() {
    super.initState();
    areaData.keys.toList().asMap().forEach((index, value) {
      if (MainPostScreen.staticCurrentLocation[0] == value) _cityIndex = index;
    });
    areaData.values.toList()[_cityIndex].asMap().forEach((index, value) {
      if (MainPostScreen.staticCurrentLocation[1] == value) _townIndex = index;
    });
    _cityScrollController =
        FixedExtentScrollController(initialItem: _cityIndex);
    _townScrollController =
        FixedExtentScrollController(initialItem: _townIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _cityScrollController.dispose();
    _townScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
            onPressed: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                        actions: [buildCityPicker()],
                        cancelButton: CupertinoActionSheetAction(
                            onPressed: () {
                              setState(() {
                                String city =
                                    areaData.keys.toList()[_cityIndex];
                                String town = areaData.values
                                    .toList()[_cityIndex][_townIndex];
                                widget.areaCallBack(city, town);
                                Navigator.pop(context);
                                _cityScrollController.dispose();
                                _cityScrollController =
                                    FixedExtentScrollController(
                                        initialItem: _cityIndex);
                                _townScrollController.dispose();
                                _townScrollController =
                                    FixedExtentScrollController(
                                        initialItem: _townIndex);
                              });
                            },
                            child: Text("完成")),
                      ));
            },
            icon: Icon(Icons.arrow_drop_down),
            label: Text(areaData.keys.toList()[_cityIndex])),
        SizedBox(
          width: 10,
        ),
        ElevatedButton.icon(
            onPressed: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                        actions: [buildTownPicker()],
                        cancelButton: CupertinoActionSheetAction(
                            onPressed: () {
                              setState(() {
                                String city =
                                    areaData.keys.toList()[_cityIndex];
                                String town = areaData.values
                                    .toList()[_cityIndex][_townIndex];
                                widget.areaCallBack(city, town);
                                Navigator.pop(context);
                                _townScrollController.dispose();
                                _townScrollController =
                                    FixedExtentScrollController(
                                        initialItem: _townIndex);
                              });
                            },
                            child: Text("完成")),
                      ));
            },
            icon: Icon(Icons.arrow_drop_down),
            label: Text(areaData.values.toList()[_cityIndex][_townIndex]))
      ],
    );
  }

  Widget buildCityPicker() {
    return SizedBox(
      height: 400,
      child: CupertinoPicker(
          scrollController: _cityScrollController,
          itemExtent: 64,
          onSelectedItemChanged: (index) {
            _cityIndex = index;
            _townIndex = 0;
          },
          children: [
            for (final item in areaData.keys.toList())
              Center(
                child: Text(
                  item,
                  style: TextStyle(fontSize: 20),
                ),
              )
          ]),
    );
  }

  Widget buildTownPicker() {
    return SizedBox(
      height: 400,
      child: CupertinoPicker(
          scrollController: _townScrollController,
          itemExtent: 64,
          onSelectedItemChanged: (index) {
            _townIndex = index;
          },
          children: [
            for (final item in areaData.values.toList()[_cityIndex])
              Center(
                child: Text(
                  item,
                  style: TextStyle(fontSize: 20),
                ),
              )
          ]),
    );
  }
}
