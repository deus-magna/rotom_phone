import 'package:flutter/material.dart';
import 'package:rotom_phone/core/framework/colors.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';

class MovesTab extends StatelessWidget {
  final Pokemon pokemon;

  const MovesTab({
    Key key,
    @required this.pokemon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final moves = pokemon.info.moves;
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: moves.length,
        itemBuilder: (context, index) {
          return Container(
            color: primary,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: Text(moves[index].move.name),
          );
        },
      ),
    );
  }
}
