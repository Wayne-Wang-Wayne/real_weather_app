import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/googleSignInProvider.dart';

class EmailLoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const EmailLoginWidget({Key? key, required this.onClickedSignUp})
      : super(key: key);

  @override
  State<EmailLoginWidget> createState() => _EmailLoginWidgetState();
}

class _EmailLoginWidgetState extends State<EmailLoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          TextField(
            controller: emailController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "請輸入信箱"),
          ),
          SizedBox(height: 4),
          TextField(
            controller: passwordController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(labelText: "請輸入密碼"),
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              final provider =
                  Provider.of<SignInProvider>(context, listen: false);
              provider.signInWithMail(emailController.text.trim(),
                  passwordController.text.trim(), context);
            },
            icon: Icon(
              Icons.login,
              size: 32,
            ),
            label: Text(
              "登入",
              style: TextStyle(fontSize: 24),
            ),
            style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Text(
                  "忘記密碼",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 1,
                height: 20,
                color: Colors.black,
              ),
              SizedBox(width: 10),
              RichText(
                  text: TextSpan(
                      text: "沒有帳號？",
                      style: TextStyle(color: Colors.black),
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                        text: "去註冊",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue))
                  ])),
            ],
          )
        ],
      ),
    );
  }
}
