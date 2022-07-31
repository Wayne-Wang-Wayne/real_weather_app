import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/googleSignInProvider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

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
              FlutterLogo(
                size: 120,
              ),
              SizedBox(
                height: 100,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hi! \n歡迎回來！",
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
              SizedBox(
                height: 60,
              ),
              googleSingInButton(),
              SizedBox(
                height: 10,
              ),
              fbSingInButton(),
              SizedBox(
                height: 40,
              ),
              RichText(
                  text: TextSpan(
                      text: "已經擁有帳號?",
                      style: TextStyle(color: Colors.black),
                      children: [
                    TextSpan(
                        text: "登入",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black))
                  ])),
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
        provider.googleLogin();
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
        provider.fBLogin();
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
