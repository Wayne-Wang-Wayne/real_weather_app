import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../models/userModel.dart';

class DailyPostButton extends StatefulWidget {
  final Function(int) gainExp;
  final UserModel userModel;
  const DailyPostButton(
      {Key? key, required this.gainExp, required this.userModel})
      : super(key: key);

  @override
  State<DailyPostButton> createState() => _DailyPostButtonState();
}

class _DailyPostButtonState extends State<DailyPostButton> {
  bool _hasCheckIn = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 40,
      child: TextButton.icon(
        onPressed: () {
          if (!_hasCheckIn) {}
        },
        icon: _hasCheckIn ? Icon(Icons.check) : SizedBox.shrink(),
        label: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Text(
            _hasCheckIn ? "已發文" : "去發文",
            style: TextStyle(
                color: _hasCheckIn ? Colors.grey : Colors.white,
                fontSize: _hasCheckIn ? 13 : 15),
          ),
        ),
        style: TextButton.styleFrom(backgroundColor: Colors.red.shade200),
      ),
    );
  }
}
