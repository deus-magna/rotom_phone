import 'package:flutter/material.dart';

import '../colors.dart';

class PokedexHeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('Width: ${size.width}, Height: ${size.height}');

    var paint1 = Paint()
      ..color = secondary
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width / 2, -size.height * 2), size.height * 3, paint1);
    paint1 = Paint()..color = primary;
    canvas.drawCircle(
        Offset(size.width / 2, -(size.height * 2) - (size.height * 0.14)),
        size.height * 3,
        paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
