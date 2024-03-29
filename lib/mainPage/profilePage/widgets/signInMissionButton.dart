import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/models/userModel.dart';

import '../../../utils/someTools.dart';

class SingInMissionButton extends StatefulWidget {
  final Function(int) gainExp;
  final UserModel userModel;
  const SingInMissionButton(
      {Key? key, required this.userModel, required this.gainExp})
      : super(key: key);

  @override
  State<SingInMissionButton> createState() => _SingInMissionButtonState();
}

class _SingInMissionButtonState extends State<SingInMissionButton> {
  bool _hasCheckIn = false;
  bool isLoading = false;

  Future<void> checkIn() async {
    setState(() {
      isLoading = true;
    });
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel userModel, options) =>
                userModel.toFirestore())
        .doc(FirebaseAuth.instance.currentUser!.uid);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(docRef);
      if (!snapshot.exists) {
        throw Exception("User does not exist!");
      }
      int newExp = (snapshot.data() as Map)["userExp"] + 20;
      transaction.update(docRef, {
        'userExp': newExp,
        "lastSingInTimestamp": DateTime.now().millisecondsSinceEpoch
      });
      return newExp;
    }).then((value) {
      setState(() {
        isLoading = false;
        _hasCheckIn = true;
      });
      widget.gainExp(20);
    }).catchError((error) {
      setState(() {
        isLoading = false;
        _hasCheckIn = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _hasCheckIn = MyTools.checkIsToday(widget.userModel.lastSingInTimestamp!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      child: TextButton.icon(
        onPressed: () async {
          if (!_hasCheckIn) {
            final hasInternet = await MyTools.hasInternet(context);
            if (!hasInternet) return;
            checkIn();
          }
        },
        icon: isLoading
            ? Center(
                child: SizedBox(
                    height: 20, width: 20, child: CircularProgressIndicator()),
              )
            : _hasCheckIn
                ? Icon(Icons.check)
                : SizedBox.shrink(),
        label: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Text(
            _hasCheckIn ? "已簽到" : "簽到",
            style: TextStyle(
                color: _hasCheckIn ? Colors.grey : Colors.white,
                fontSize: _hasCheckIn ? 13 : 15),
          ),
        ),
        style: TextButton.styleFrom(backgroundColor: Colors.blue.shade300),
      ),
    );
  }
}
