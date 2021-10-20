import 'package:flutter/material.dart';

class FrontMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final _xScaling = size.width / 235;
    final _yScaling = size.height / 48;

    final path = Path()
      ..lineTo(218.823 * _xScaling, 48 * _yScaling)
      ..cubicTo(
        218.823 * _xScaling,
        48 * _yScaling,
        24 * _xScaling,
        48 * _yScaling,
        24 * _xScaling,
        48 * _yScaling,
      )
      ..cubicTo(
        5.520175485111373 * _xScaling,
        47.98964469921821 * _yScaling,
        -6.018519597641028 * _xScaling,
        27.978175768780243 * _yScaling,
        3.2303606133441356 * _xScaling,
        11.979355931799141 * _yScaling,
      )
      ..cubicTo(
        5.841551644321641 * _xScaling,
        7.462487520536605 * _yScaling,
        9.853179921931025 * _xScaling,
        3.919254254220057 * _yScaling,
        14.658 * _xScaling,
        1.886 * _yScaling,
      )
      ..cubicTo(
        17.613406273553437 * _xScaling,
        0.6352478724074149 * _yScaling,
        20.790830574282808 * _xScaling,
        -0.006222819167828856 * _yScaling,
        24 * _xScaling,
        0 * _yScaling,
      )
      ..cubicTo(
        24 * _xScaling,
        0 * _yScaling,
        234.62 * _xScaling,
        0 * _yScaling,
        234.62 * _xScaling,
        0 * _yScaling,
      )
      ..cubicTo(
        234.62 * _xScaling,
        0 * _yScaling,
        218.82 * _xScaling,
        48 * _yScaling,
        218.82 * _xScaling,
        48 * _yScaling,
      )
      ..cubicTo(
        218.82 * _xScaling,
        48 * _yScaling,
        218.823 * _xScaling,
        48 * _yScaling,
        218.823 * _xScaling,
        48 * _yScaling,
      );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class BackMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final _xScaling = size.width / 315;
    final _yScaling = size.height / 48;
    final path = Path()
      ..lineTo(294.615 * _xScaling, 48 * _yScaling)
      ..cubicTo(
        294.615 * _xScaling,
        48 * _yScaling,
        24 * _xScaling,
        48 * _yScaling,
        24 * _xScaling,
        48 * _yScaling,
      )
      ..cubicTo(
        5.524791385931977 * _xScaling,
        48 * _yScaling,
        -6.022213997860538 * _xScaling,
        28.000000000000014 * _yScaling,
        3.2153903091734684 * _xScaling,
        12.000000000000005 * _yScaling,
      )
      ..cubicTo(
        7.50257738807143 * _xScaling,
        4.574374157795928 * _yScaling,
        15.425625842204072 * _xScaling,
        0 * _yScaling,
        24 * _xScaling,
        -1.7763568394002505e-15 * _yScaling,
      )
      ..cubicTo(
        24 * _xScaling,
        -1.7763568394002505e-15 * _yScaling,
        313.41 * _xScaling,
        -1.7763568394002505e-15 * _yScaling,
        313.41 * _xScaling,
        -1.7763568394002505e-15 * _yScaling,
      )
      ..cubicTo(
        313.932 * _xScaling,
        -1.7763568394002505e-15 * _yScaling,
        314.46000000000004 * _xScaling,
        0.016999999999997684 * _yScaling,
        314.97900000000004 * _xScaling,
        0.049999999999998934 * _yScaling,
      )
      ..cubicTo(
        314.97900000000004 * _xScaling,
        0.049999999999998934 * _yScaling,
        294.616 * _xScaling,
        47.999 * _yScaling,
        294.616 * _xScaling,
        47.999 * _yScaling,
      )
      ..cubicTo(
        294.616 * _xScaling,
        47.999 * _yScaling,
        294.615 * _xScaling,
        48 * _yScaling,
        294.615 * _xScaling,
        48 * _yScaling,
      );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
