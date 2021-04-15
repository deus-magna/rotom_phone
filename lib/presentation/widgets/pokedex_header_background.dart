import 'package:flutter/material.dart';
import 'package:rotom_phone/core/framework/colors.dart';
import 'package:rotom_phone/core/framework/painters/pokedex_header_clipper.dart';

class PokedexHeaderBackground extends StatelessWidget {
  final double outerHeight;
  final double innerHeight;

  const PokedexHeaderBackground({
    Key key,
    @required this.outerHeight,
    @required this.innerHeight,
  }) : super(key: key);

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
      ],
    );
  }
}
