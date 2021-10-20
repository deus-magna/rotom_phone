import 'package:flutter/material.dart';
import 'package:rotom_phone/core/framework/colors.dart';
import 'package:rotom_phone/core/framework/painters/pokedex_header_clipper.dart';

class PokedexHeaderBackground extends StatelessWidget {
  const PokedexHeaderBackground({
    Key key,
    @required this.outerHeight,
    @required this.innerHeight,
    @required this.background,
  }) : super(key: key);

  final double outerHeight;
  final double innerHeight;
  final Widget background;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ClipPath(
          clipper: PokedexHeaderClipper(),
          child: Container(
            width: size.width,
            height: outerHeight,
            color: secondary,
          ),
        ),
        ClipPath(
          clipper: PokedexHeaderClipper(),
          child: Container(
            width: size.width,
            height: innerHeight,
            color: primary,
          ),
        ),
        ClipPath(
          clipper: PokedexHeaderClipper(),
          child: Container(
            width: size.width,
            height: outerHeight,
            color: Colors.transparent,
            child: Stack(
              children: [
                background,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
