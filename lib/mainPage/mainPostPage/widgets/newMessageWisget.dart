import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class NewMessageWidget extends StatefulWidget {
  const NewMessageWidget({Key? key}) : super(key: key);

  @override
  State<NewMessageWidget> createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  var _enterMessage = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: _controller,
            enableSuggestions: true,
            decoration: InputDecoration(labelText: "輸入訊息 ..."),
            onChanged: (value) {
              setState(() {
                _enterMessage = value;
              });
            },
          ),
        ),
        TextButton(
            onPressed: _enterMessage.trim().isEmpty
                ? null
                : () {
                    FocusScope.of(context).unfocus();
                    _controller.clear();
                  },
            child: Text(
              "留言",
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ))
      ]),
    );
  }
}
