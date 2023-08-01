import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  const ClockView({super.key});

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  Timer? timer;

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Container(
        height: 300,
        width: 300,
        child: Transform.rotate(
          angle: -pi / 2,
          child: CustomPaint(
            painter: ClockPainter(),
          ),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  //12 hour = 360      1 hour = 30

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = const Color(0xff534A5D);
    var outlineBrush = Paint()
      ..color = Colors.white70
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke;
    var centerFillBrush = Paint()..color = const Color(0xffD9D9D9);

    var secHandBrush = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    var minHandBrush = Paint()
      ..shader = const RadialGradient(
        colors: [Colors.pink, Colors.lightBlue],
        stops: [0, .3],
      ).createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    var hourHandBrush = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    var hourHnadX = centerX + 60 * cos(dateTime.hour * 30 * pi / 180);
    var hourHnadY = centerX + 60 * sin(dateTime.hour * 30 * pi / 180);
    canvas.drawLine(center, Offset(hourHnadX, hourHnadY), hourHandBrush,);

    var minHnadX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHnadY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHnadX, minHnadY), minHandBrush);

    var secHnadX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHnadY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHnadX, secHnadY), secHandBrush);

    canvas.drawCircle(center, 16, centerFillBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
