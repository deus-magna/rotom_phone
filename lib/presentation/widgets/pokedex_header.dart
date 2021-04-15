import 'package:flutter/material.dart';
import 'package:rotom_phone/presentation/widgets/pokedex_header_background.dart';

class PokedexHeader extends StatelessWidget {
  final Widget child;
  final Positioned backgroundWidget;
  final double height;
  final double innerHeight;
  final double outerHeight;

  const PokedexHeader({
    Key key,
    this.child,
    this.backgroundWidget,
    this.height,
    @required this.innerHeight,
    @required this.outerHeight,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PokedexHeaderBackground(
          innerHeight: innerHeight,
          outerHeight: outerHeight,
          background: backgroundWidget != null
              ? backgroundWidget
              : _DefaultBackgroundImage(),
        ),
        child,
      ],
    );
  }
}

class _DefaultBackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
