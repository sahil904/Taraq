import 'dart:math';

import 'package:flutter/material.dart';

class SpritePainter extends CustomPainter {
  SpritePainter(this._animation, {this.animationColor}) : super(repaint: _animation);
  final Animation<double> _animation;
  Color animationColor;

  void circle(Canvas canvas, Rect rect, double value) {
    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final Color color = animationColor.withOpacity(opacity);
    /*isSuccess ? Color.fromRGBO(244, 72, 109, opacity) : Color.fromRGBO(244, 72, 72, opacity);*/

    final double size = rect.width / 2;
    final double area = size * size;
    final double radius = sqrt(area * value / 4);

    final Paint paint = Paint()..color = color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(SpritePainter oldDelegate) {
    return true;
  }
}
