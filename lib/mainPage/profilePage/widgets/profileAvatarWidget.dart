import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import '../../models/userModel.dart';

class ProfileAvatarWidget extends StatefulWidget {
  final UserModel userModel;
  ProfileAvatarWidget({Key? key, required this.userModel}) : super(key: key);

  @override
  State<ProfileAvatarWidget> createState() => _ProfileAvatarWidgetState();
}

class _ProfileAvatarWidgetState extends State<ProfileAvatarWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: 120,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.userModel.userImageUrl!),
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              "更換大頭貼",
              style: TextStyle(color: Colors.blue),
            ))
      ],
    );
  }
}
