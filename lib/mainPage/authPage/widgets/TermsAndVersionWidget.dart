import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:real_weather_shared_app/mainPage/authPage/screens/UserTermsPage.dart';

class TermsAndVersionWidget extends StatefulWidget {
  const TermsAndVersionWidget({Key? key}) : super(key: key);

  @override
  State<TermsAndVersionWidget> createState() => _TermsAndVersionWidgetState();
}

class _TermsAndVersionWidgetState extends State<TermsAndVersionWidget> {
  String version = "";
  @override
  void initState() {
    super.initState();
    getVersion();
  }

  Future<void> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
              text: TextSpan(
                  text: "當您註冊時表示您已同意",
                  style: TextStyle(color: Colors.black),
                  children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = (() {
                        Navigator.of(context)
                            .pushNamed(UserTermsPage.routeName);
                      }),
                    text: "滑天氣使用者協議",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue))
              ])),
          Text(version != "" ? "版本 $version" : "")
        ],
      ),
    );
  }
}
