import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
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
                            onPressed: () => Navigator.pop(context),
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
                            onPressed: () => Navigator.pop(context),
                            child: Text("完成")),
                      ));
            },
            icon: Icon(Icons.arrow_drop_down),
            label: Text(areaData.values.toList()[_cityIndex][_townIndex]))
      ],
    );
  }

  Widget buildCityPicker() {
    _cityScrollController.dispose();
    _cityScrollController =
        FixedExtentScrollController(initialItem: _cityIndex);
    return SizedBox(
      height: 400,
      child: CupertinoPicker(
          scrollController: _cityScrollController,
          itemExtent: 64,
          onSelectedItemChanged: (index) {
            setState(() {
              _cityIndex = index;
              _townIndex = 0;
              String city = areaData.keys.toList()[index];
              String town = areaData.values.toList()[index][_townIndex];
              widget.areaCallBack(city, town);
            });
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
    _townScrollController.dispose();
    _townScrollController =
        FixedExtentScrollController(initialItem: _townIndex);
    return SizedBox(
      height: 400,
      child: CupertinoPicker(
          scrollController: _townScrollController,
          itemExtent: 64,
          onSelectedItemChanged: (index) {
            setState(() {
              _townIndex = index;
              String city = areaData.keys.toList()[_cityIndex];
              String town = areaData.values.toList()[_cityIndex][_townIndex];
              widget.areaCallBack(city, town);
            });
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
