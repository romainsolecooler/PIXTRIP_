import 'package:flutter/material.dart';

import 'package:pixtrip/common/custom_colors.dart';

AppBar appBar = AppBar(
  title: Text(
    'pixtrip',
    style: TextStyle(
      fontFamily: 'Moderna',
      fontSize: 40,
    ),
  ),
  brightness: Brightness.dark,
  backgroundColor: blueColor[900],
  flexibleSpace: Overlay(),
  centerTitle: true,
);

class Overlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return CustomPaint(
      size: Size.infinite,
      painter: CustomWave(statusBarHeight: statusBarHeight),
    );
  }
}

class CustomWave extends CustomPainter {
  final double statusBarHeight;

  CustomWave({this.statusBarHeight});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = darkBlueColor[900];
    paint.style = PaintingStyle.fill;
    var path = Path();

    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(
        size.width / 1.75, size.height * 0.8, size.width, statusBarHeight);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomWave oldDelegate) {
    return true;
  }
}

class Wave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: darkBlueColor[900],
          gradient: RadialGradient(
            center: Alignment(-1, -39.3),
            radius: 20,
            stops: [
              1.0,
              1.0,
            ],
            colors: [
              darkBlueColor[900],
              blueColor[900],
            ],
          )),
    );
  }
}
