import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 30,
        ),
        Container(
          height: 120,
          width: 120,
          child: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                "https://lh3.googleusercontent.com/a-/AOh14Ggz8N57yEvo4R5KkfPsRn553c3HadhuFLu7oibn0Q=s96-c"),
            backgroundColor: Colors.transparent,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "王翊瑋",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.blueGrey),
        ),
        Text(
          "天氣專家",
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "貼文次數: 1",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "被讚次數: 7",
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
