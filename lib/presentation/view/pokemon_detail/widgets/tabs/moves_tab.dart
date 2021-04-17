import 'package:flutter/material.dart';
import 'package:rotom_phone/core/framework/colors.dart';
import 'package:rotom_phone/core/utils/enums.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';

class MovesTab extends StatelessWidget {
  final Pokemon pokemon;

  const MovesTab({
    Key key,
    @required this.pokemon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final moves =
        pokemon.info.getMovesByLearnMethod(MoveLearnMethodType.MACHINE);
    print('LENGHT: ${moves.length}');
    return Container(
      height: 500,
      child: ListView.builder(
        itemCount: moves.length,
        itemBuilder: (context, index) {
          return Container(
            color: primary,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(moves[index].move.name),
                Text(
                    'Lv. ${moves[index].versionGroupDetails.first.levelLearnedAt}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
