import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PosterInfoWidget extends StatelessWidget {
  const PosterInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: 10,
      ),
      Container(
        height: 55,
        width: 55,
        child: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
              "https://scontent.ftpe7-4.fna.fbcdn.net/v/t1.6435-9/48369165_1912940112137595_5358895407491448832_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=h0UpyEBN-RsAX_VBj7E&_nc_ht=scontent.ftpe7-4.fna&oh=00_AT9trOZEUA1NFEVjJSiP38_rTO0FcSbL3cTGO3M7lCLTLQ&oe=62DB7C22"),
          backgroundColor: Colors.transparent,
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Column(
        children: [
          Text(
            "王翊瑋",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            "天氣專家",
            style: TextStyle(color: Colors.grey),
          )
        ],
      )
    ]);
  }
}
