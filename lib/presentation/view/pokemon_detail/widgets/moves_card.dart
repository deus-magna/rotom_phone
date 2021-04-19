import 'package:flutter/material.dart';
import 'package:rotom_phone/core/framework/colors.dart';
import 'package:rotom_phone/core/utils/enums.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_info.dart';
import 'package:rotom_phone/presentation/widgets/galar_button.dart';
import 'package:rotom_phone/presentation/widgets/rounded_card.dart';

class MovesCard extends StatelessWidget {
  final List<Move> moves;
  final MoveLearnMethodType selectedMethod;
  final Function(MoveLearnMethodType) onItemSelected;

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: primary,
  );
  final ButtonStyle selectedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: secondary,
  );

  MovesCard({
    Key key,
    @required this.moves,
    @required this.selectedMethod,
    this.onItemSelected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: selectedMethod == MoveLearnMethodType.LEVEL_UP
                    ? selectedButtonStyle
                    : raisedButtonStyle,
                onPressed: () => onItemSelected(MoveLearnMethodType.LEVEL_UP),
                child: Text('Level'),
              ),
              ElevatedButton(
                style: selectedMethod == MoveLearnMethodType.MACHINE
                    ? selectedButtonStyle
                    : raisedButtonStyle,
                onPressed: () => onItemSelected(MoveLearnMethodType.MACHINE),
                child: Text('MT/DT'),
              ),
              ElevatedButton(
                style: selectedMethod == MoveLearnMethodType.EGG
                    ? selectedButtonStyle
                    : raisedButtonStyle,
                onPressed: () => onItemSelected(MoveLearnMethodType.EGG),
                child: Text('Egg'),
              ),
              ElevatedButton(
                style: selectedMethod == MoveLearnMethodType.TUTOR
                    ? selectedButtonStyle
                    : raisedButtonStyle,
                onPressed: () => onItemSelected(MoveLearnMethodType.TUTOR),
                child: Text('Tutor'),
              ),
            ],
          ),
          SizedBox(height: 10),
          ...buildMovesButtonList(moves),
        ],
      ),
    );
  }

  List<Widget> buildMovesButtonList(List<Move> moves) {
    return moves.map((move) => MoveButton(move: move)).toList();
  }
}

class MoveButton extends StatelessWidget {
  final Move move;

  const MoveButton({
    Key key,
    @required this.move,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GalarButton(
      title: move.move.name,
      subtitle: 'Lv. ${move.versionGroupDetails.first.levelLearnedAt}',
    );
  }
}
