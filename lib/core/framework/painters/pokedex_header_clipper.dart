import 'package:flutter/material.dart';

class PokedexHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 375;
    final double _yScaling = size.height / 230;
    path.lineTo(0 * _xScaling, 215.219 * _yScaling);
    path.cubicTo(
      62.01390959830233 * _xScaling,
      225.06990287368183 * _yScaling,
      124.70855853487637 * _xScaling,
      230.01224030551165 * _yScaling,
      187.5 * _xScaling,
      230 * _yScaling,
    );
    path.cubicTo(
      250.29144146512363 * _xScaling,
      230.01224030551163 * _yScaling,
      312.98609040169765 * _xScaling,
      225.06990287368183 * _yScaling,
      375 * _xScaling,
      215.219 * _yScaling,
    );
    path.cubicTo(
      375 * _xScaling,
      215.219 * _yScaling,
      375 * _xScaling,
      0 * _yScaling,
      375 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      375 * _xScaling,
      0 * _yScaling,
      0 * _xScaling,
      0 * _yScaling,
      0 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      0 * _xScaling,
      0 * _yScaling,
      0 * _xScaling,
      215.219 * _yScaling,
      0 * _xScaling,
      215.219 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
