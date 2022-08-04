import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class SimpleDialogBody extends StatelessWidget {
  final String simpleString;
  final Function? positiveCallBack;
  final double? wordingFontSize;
  final Function? negativeCallBack;
  const SimpleDialogBody(
      {Key? key,
      required this.simpleString,
      this.positiveCallBack,
      this.negativeCallBack,
      this.wordingFontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: Center(
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 16, left: 20, right: 16, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  simpleString,
                  style: TextStyle(fontSize: wordingFontSize ?? null),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (negativeCallBack != null)
                      TextButton(
                          onPressed: () {
                            negativeCallBack!();
                          },
                          child: Text(
                            "取消",
                            style: TextStyle(fontSize: 15),
                          )),
                    TextButton(
                        onPressed: () {
                          if (positiveCallBack != null) positiveCallBack!();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "確定",
                          style: TextStyle(fontSize: 15),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
