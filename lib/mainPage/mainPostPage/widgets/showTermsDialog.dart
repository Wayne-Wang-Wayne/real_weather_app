import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class ShowTermsDialog extends StatelessWidget {
  const ShowTermsDialog({Key? key}) : super(key: key);

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
                const EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '重要聲明：',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "(1)請勿濫發貼文，一經發現，違者帳號將會受到懲處\n(2)此App旨在共享天氣，請保持版面乾淨，請勿肆意討論完全不相干話題。\n(4)所有貼文僅保留30~45天，超過後將會自動被刪除。\n(3)開心使用App"),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "我會遵守",
                      style: TextStyle(fontSize: 15),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
