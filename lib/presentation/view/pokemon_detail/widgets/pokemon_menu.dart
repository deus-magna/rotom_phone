import 'package:flutter/material.dart';
import 'package:rotom_phone/core/framework/colors.dart';

class PokemonMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
      decoration: BoxDecoration(
          color: primary, borderRadius: BorderRadius.circular(100)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.ac_unit),
          Icon(Icons.ac_unit),
          Icon(Icons.ac_unit),
          Icon(Icons.ac_unit),
        ],
      ),
    );
  }
}
