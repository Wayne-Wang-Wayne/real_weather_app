import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/googleSignInProvider.dart';

class EmailSignUpWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const EmailSignUpWidget({Key? key, required this.onClickedSignUp})
      : super(key: key);

  @override
  State<EmailSignUpWidget> createState() => _EmailSignUpWidgetState();
}

class _EmailSignUpWidgetState extends State<EmailSignUpWidget> {
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
              provider.signUpWithMail(emailController.text.trim(),
                  passwordController.text.trim(), context);
            },
            icon: Icon(
              Icons.arrow_forward,
              size: 32,
            ),
            label: Text(
              "註冊",
              style: TextStyle(fontSize: 24),
            ),
            style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
          ),
          SizedBox(height: 16),
          RichText(
              text: TextSpan(
                  text: "已經擁有帳號？ ",
                  style: TextStyle(color: Colors.black),
                  children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignUp,
                    text: "直接登入",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue))
              ]))
        ],
      ),
    );
  }
}
