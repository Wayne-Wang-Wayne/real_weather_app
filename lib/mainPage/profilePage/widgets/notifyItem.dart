import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class NotifyItem extends StatelessWidget {
  const NotifyItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(7)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "彰化縣 彰化市",
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red.shade200,
              onPressed: () {},
            )
          ]),
    );
  }
}
