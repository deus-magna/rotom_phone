import 'package:flutter/material.dart';
import 'package:rotom_phone/core/framework/colors.dart';

import 'menu_clippers.dart';

class PokemonMenuBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ClipPath(
          clipper: BackMenuClipper(),
          child: Container(
            width: size.width * 0.84,
            height: size.height * 0.058,
            color: secondary,
          ),
        ),
        ClipPath(
          clipper: FrontMenuClipper(),
          child: Container(
            width: size.width * 0.63,
            height: size.height * 0.058,
            color: primary,
          ),
        ),
      ],
    );
  }
}
