import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/utils/someTools.dart';

import '../../createPostPage/screens/createPostScreen.dart';
import '../../models/userModel.dart';

class DailyPostButton extends StatefulWidget {
  final Function(int) refreshAfterPost;
  final UserModel userModel;
  const DailyPostButton(
      {Key? key, required this.refreshAfterPost, required this.userModel})
      : super(key: key);

  @override
  State<DailyPostButton> createState() => _DailyPostButtonState();
}

class _DailyPostButtonState extends State<DailyPostButton> {
  bool _hasPost = false;

  @override
  void initState() {
    super.initState();
    _hasPost = MyTools.checkIsToday(widget.userModel.lastPostTimestamp!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      child: TextButton.icon(
        onPressed: () {
          if (!_hasPost) {
            Navigator.of(context)
                .pushNamed(CreatePostScreen.routeName)
                .then((needToRefresh) {
              if (needToRefresh != null) {
                setState(() {
                  _hasPost = true;
                });
                if (needToRefresh as bool) widget.refreshAfterPost(25);
              }
            });
          }
        },
        icon: _hasPost ? Icon(Icons.check) : SizedBox.shrink(),
        label: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Text(
            _hasPost ? "已發文" : "去發文",
            style: TextStyle(
                color: _hasPost ? Colors.grey : Colors.white,
                fontSize: _hasPost ? 13 : 15),
          ),
        ),
        style: TextButton.styleFrom(backgroundColor: Colors.blue.shade300),
      ),
    );
  }
}
