import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class NoiseBox extends StatefulWidget {
  @override
  _NoiseBoxState createState() => _NoiseBoxState();
}

class _NoiseBoxState extends State<NoiseBox>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  double _WIDTH = 200.0;
  double _HEIGHT = 200.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          color: Colors.white,
          width: _WIDTH,
          height: _HEIGHT,
          child: AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext ctx, Widget w) {
                return CustomPaint(
                  painter: NoisePainter(
                    width: _WIDTH,
                    height: _HEIGHT,
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class NoisePainter extends CustomPainter {
  final double width;
  final double height;

  NoisePainter({this.width, this.height});

  List<Color> colors = [
    Colors.black,
    Colors.grey,
    Colors.blueGrey,
    Colors.red,
    Colors.green,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    Random random = Random();

    for (int i = 0; i < this.width; i += 3) {
      for (int j = 0; j < this.height; j += 3) {
        Offset point = Offset(
          random.nextDouble() * (this.width),
          random.nextDouble() * (this.height),
        );

        Paint p = Paint();
        p.color = colors[random.nextInt(colors.length)];
        p.strokeWidth = random.nextDouble() * 2;

        canvas.drawPoints(PointMode.points, [point], p);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
