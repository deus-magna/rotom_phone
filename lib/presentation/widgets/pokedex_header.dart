import 'package:flutter/material.dart';
import 'package:rotom_phone/core/framework/painters/pokedex_header_painter.dart';

class PokedexHeader extends StatelessWidget {
  final Widget child;
  final Positioned backgroundWidget;
  final double height;

  const PokedexHeader({Key key, this.child, this.backgroundWidget, this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: height == null ? size.height * 0.3 : height,
          child: CustomPaint(
            painter: PokedexHeaderPainter(),
          ),
        ),
        backgroundWidget != null
            ? backgroundWidget
            : _DefaultBackgroundImage(size: size),
        child,
      ],
    );
  }
}

class _DefaultBackgroundImage extends StatelessWidget {
  const _DefaultBackgroundImage({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: size.height * 0.04,
      right: 0,
      child: Image.asset(
        'assets/images/rotom_phone_icon.png',
        height: 232,
      ),
    );
  }
}
