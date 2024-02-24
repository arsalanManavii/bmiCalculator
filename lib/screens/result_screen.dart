import 'dart:math';

import 'package:bmi_application/constant/colors.dart';
import 'package:bmi_application/data/datas.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatefulWidget {
  double status;
  ResultScreen({super.key, required this.status});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  double _x = 8.0;
  double _y = 145.0;
  double _numbericIndicator = 0.0;
  String _statusIndicator = '';
  late Animation x, y;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    if (widget.status < 18.5) {
      x = Tween(begin: 8.0, end: 35.0).animate(controller)
        ..addListener(
          () {
            setState(
              () {
                _x = x.value;
              },
            );
          },
        );

      y = Tween(begin: 145.0, end: 130.0).animate(controller)
        ..addListener(
          () {
            setState(
              () {
                _y = y.value;
              },
            );
          },
        );
      _statusIndicator = 'underWeight';
      _numbericIndicator = widget.status.roundToDouble();
    } else if (widget.status >= 18.5 && widget.status < 25.0) {
      x = Tween(begin: 8.0, end: 65.0).animate(controller)
        ..addListener(
          () {
            setState(
              () {
                _x = x.value;
              },
            );
          },
        );

      y = Tween(begin: 145.0, end: 90.0).animate(controller)
        ..addListener(
          () {
            setState(
              () {
                _y = y.value;
              },
            );
          },
        );
      _statusIndicator = 'Healthy';
      _numbericIndicator = widget.status.roundToDouble();
    } else if (widget.status >= 25.0 && widget.status < 40.0) {
      x = Tween(begin: 8.0, end: 130.0).animate(controller)
        ..addListener(
          () {
            setState(
              () {
                _x = x.value;
              },
            );
          },
        );

      y = Tween(begin: 145.0, end: 90.0).animate(controller)
        ..addListener(
          () {
            setState(
              () {
                _y = y.value;
              },
            );
          },
        );
      _statusIndicator = 'overWeight';
      _numbericIndicator = widget.status.roundToDouble();
    } else if (widget.status >= 40.0) {
      x = Tween(begin: 8.0, end: 185.0).animate(controller)
        ..addListener(
          () {
            setState(
              () {
                _x = x.value;
              },
            );
          },
        );

      y = Tween(begin: 145.0, end: 130.0).animate(controller)
        ..addListener(
          () {
            setState(
              () {
                _y = y.value;
              },
            );
          },
        );
      _statusIndicator = 'Obese';
      _numbericIndicator = widget.status.roundToDouble();
    }

    controller.forward();
  }

  List<Data> _dataSet = [
    Data(value: 0.2, color: Colors.blue),
    Data(value: 0.3, color: Colors.green),
    Data(value: 0.3, color: orangeAccent),
    Data(value: 0.2, color: Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: textColor,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 50.0,
            ),
            Text(
              'Result',
              style: GoogleFonts.lobster(
                  fontSize: 40.0,
                  fontWeight: FontWeight.normal,
                  color: textColor),
            ),
            SizedBox(height: 50.0),
            CustomPaint(
              painter: ResultCustomPaint(dataSet: _dataSet, x: _x, y: _y),
              size: Size(200.0, 200.0),
            ),
            SizedBox(height: 80.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Your BMI is $_numbericIndicator, indicating your weight is in $_statusIndicator Weight category for adults of your height.',
                style: GoogleFonts.oxanium(
                    fontSize: 22.0,
                    color: textColor,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class ResultCustomPaint extends CustomPainter {
  double x;
  double y;

  List<Data> dataSet;
  ResultCustomPaint({required this.dataSet, required this.x, required this.y});
  @override
  void paint(Canvas canvas, Size size) {
    double startAngle = 116.22;
    double radius = size.width;
    Offset center = Offset(size.width / 2.0, size.height / 2.0 + 50);
    drawArcChart(center, radius, startAngle, canvas);

    Paint pointerPaint = Paint()
      ..color = pointerColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    canvas.drawLine(
        Offset(center.dx, center.dy + 20), Offset(x, y), pointerPaint);

    Paint littleCirclePaint = Paint()
      ..color = littleCircleColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(center.dx, center.dy + 20), 9, littleCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  drawArcChart(Offset center, double radius, double startAngle, Canvas canvas) {
    Rect rect = Rect.fromCenter(center: center, width: radius, height: radius);
    dataSet.forEach((element) {
      double sweepAngle = element.value * 180.0 * pi / 180.0;
      Paint paint = Paint()
        ..color = element.color
        ..style = PaintingStyle.fill;
      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
      startAngle += sweepAngle;
    });
  }
}
