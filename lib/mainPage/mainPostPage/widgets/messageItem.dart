import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../utils/someTools.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.network(
                "https://lh3.googleusercontent.com/a-/AOh14Ggz8N57yEvo4R5KkfPsRn553c3HadhuFLu7oibn0Q=s96-c",
                fit: BoxFit.cover),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "王翊瑋",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "(天氣專家)",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              ),
              Text("天氣真的很好！天氣真的很好！天氣真的很好！天氣真的很好！天氣真的很好！天氣真的很好！天氣真的很好！天氣真的很好！",
                  style: TextStyle(fontSize: 14)),
              Text(MyTools.getReadableTime(1657293423298),
                  style: TextStyle(fontSize: 10, color: Colors.grey))
            ],
          ),
        )
      ]),
    );
  }
}
