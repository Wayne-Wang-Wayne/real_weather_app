import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:real_weather_shared_app/mainPage/authPage/widgets/EmailLoginWidget.dart';
import 'package:real_weather_shared_app/utils/someTools.dart';

import '../providers/googleSignInProvider.dart';
import '../widgets/EmailSignUpWidget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 120,
              ),
              Image.asset('assets/images/logo.png'),
              SizedBox(
                height: 60,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "隨時分享天氣實照，天氣好壞由自己決定！",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "登入以繼續",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              isLogin
                  ? EmailLoginWidget(
                      onClickedSignUp: toggle,
                    )
                  : EmailSignUpWidget(
                      onClickedSignUp: toggle,
                    ),
              SizedBox(
                height: 35,
              ),
              googleSingInButton(),
              SizedBox(
                height: 10,
              ),
              fbSingInButton(),
              SizedBox(
                height: 10,
              ),
              appleSingInButton(),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class googleSingInButton extends StatelessWidget {
  const googleSingInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        final provider = Provider.of<SignInProvider>(context, listen: false);
        provider.googleLogin(context);
      },
      label: Text("使用Google帳號登入"),
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          minimumSize: Size(double.infinity, 50)),
      icon: FaIcon(
        FontAwesomeIcons.google,
        color: Colors.red,
      ),
    );
  }
}

class fbSingInButton extends StatelessWidget {
  const fbSingInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        final provider = Provider.of<SignInProvider>(context, listen: false);
        provider.fBLogin(context);
      },
      label: Text("使用Facebook帳號登入"),
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          minimumSize: Size(double.infinity, 50)),
      icon: FaIcon(
        FontAwesomeIcons.facebook,
        color: Colors.blue,
      ),
    );
  }
}

class appleSingInButton extends StatelessWidget {
  const appleSingInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        if (Platform.isAndroid) {
          MyTools.showSimpleDialog(context, "Android裝置目前不支援Apple ID登入",
              wordingFontSize: 17);
          return;
        }
        final provider = Provider.of<SignInProvider>(context, listen: false);
        provider.signInWithApple(context);
      },
      label: Text("使用Apple ID登入"),
      style: ElevatedButton.styleFrom(
          primary: Colors.black,
          onPrimary: Colors.white,
          minimumSize: Size(double.infinity, 50)),
      icon: FaIcon(
        FontAwesomeIcons.apple,
        color: Colors.white,
      ),
    );
  }
}
