import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Line extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LineState();
}

class _LineState extends State<Line> with SingleTickerProviderStateMixin {
  //要分兩種，一個是剛進來，從0開始，一個是簽到，從目前比例開始，還要處理升等狀況
  double _progress = 0.0;
  int _startExp = 80;
  int _finalExp = 150;
  Animation<double>? animation;

  List<double> _getMoveRange(int startExp, int finalExp) {
    final List<double> proportionList = [];
    int tempExp = 100;
    while (startExp - tempExp >= 0) {
      startExp -= tempExp;
      tempExp += 100;
    }
    final startProportion = startExp / tempExp;
    proportionList.add(startProportion);
    tempExp = 0;
    while (finalExp - tempExp >= 0) {
      finalExp -= tempExp;
      tempExp += 100;
    }
    final finalProportion = finalExp / tempExp;
    proportionList.add(finalProportion);
    return proportionList;
  }

  @override
  void initState() {
    super.initState();
    final _moveProportions = _getMoveRange(_startExp, _finalExp);
    var controller = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    final startProportion = _moveProportions[0];
    final endProportion = _moveProportions[1];
    if (startProportion <= endProportion) {
      animation = Tween(begin: 1.0 - startProportion, end: 1.0 - endProportion)
          .animate(controller)
        ..addListener(() {
          setState(() {
            _progress = animation!.value;
          });
        });
      controller.forward();
    } else {
      animation =
          Tween(begin: 1.0 - startProportion, end: 0.0).animate(controller)
            ..addListener(() {
              setState(() {
                _progress = animation!.value;
              });
            });
      controller.forward();

      Future.delayed(const Duration(milliseconds: 2000), () {
        animation =
            Tween(begin: 1.0, end: 1.0 - endProportion).animate(controller)
              ..addListener(() {
                setState(() {
                  _progress = animation!.value;
                });
              });
        setState(() {
          _progress = 0.0;
          controller.reset();
          controller.forward();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: LinePainter(_progress));
  }
}

class LinePainter extends CustomPainter {
  Paint? _paint;
  double _progress;

  LinePainter(this._progress) {
    _paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(0.0, 0.0),
        Offset(size.width - size.width * _progress, 0.0), _paint!);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate._progress != _progress;
  }
}
