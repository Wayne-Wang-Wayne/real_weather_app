import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PostLikeButton extends StatefulWidget {
  const PostLikeButton({Key? key}) : super(key: key);

  @override
  State<PostLikeButton> createState() => _PostLikeButtonState();
}

class _PostLikeButtonState extends State<PostLikeButton> {
  var _isLike = false;
  var _likeAmount = 7;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(_isLike ? Icons.favorite : Icons.favorite_border),
      onPressed: () {
        setState(() {
          if (_isLike) {
            _likeAmount -= 1;
          } else {
            _likeAmount += 1;
          }
          _isLike = !_isLike;
        });
      },
      label: Text("$_likeAmount 讚"),
    );
  }
}
