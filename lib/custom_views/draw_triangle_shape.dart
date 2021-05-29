import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class DrawTriangleShape extends CustomPainter {

    Paint painter;

    DrawTriangleShape() {

        painter = Paint()
            ..color = Colors.purpleAccent
            ..style = PaintingStyle.fill;

    }

    @override
    void paint(Canvas canvas, Size size) {

        var path = Path();

        path.moveTo(30, 2);
        path.lineTo(2, size.height);
        path.lineTo(size.height, size.width);
        path.close();

        canvas.drawPath(path, painter);
    }

    @override
    bool shouldRepaint(CustomPainter oldDelegate) {
        return false;
    }
}