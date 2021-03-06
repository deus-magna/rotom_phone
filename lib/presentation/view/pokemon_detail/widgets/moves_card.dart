import 'package:flutter/material.dart';
import 'package:rotom_phone/core/framework/colors.dart';
import 'package:rotom_phone/core/utils/enums.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_info.dart';
import 'package:rotom_phone/presentation/widgets/galar_button.dart';
import 'package:rotom_phone/presentation/widgets/rounded_card.dart';

class MovesCard extends StatelessWidget {
  MovesCard({
    Key key,
    @required this.moves,
    @required this.selectedMethod,
    this.onItemSelected,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: selectedMethod == MoveLearnMethodType.levelUp
                    ? selectedButtonStyle
                    : raisedButtonStyle,
                onPressed: () => onItemSelected(MoveLearnMethodType.levelUp),
                child: const Text('Level'),
              ),
              ElevatedButton(
                style: selectedMethod == MoveLearnMethodType.machine
                    ? selectedButtonStyle
                    : raisedButtonStyle,
                onPressed: () => onItemSelected(MoveLearnMethodType.machine),
                child: const Text('MT/DT'),
              ),
              ElevatedButton(
                style: selectedMethod == MoveLearnMethodType.egg
                    ? selectedButtonStyle
                    : raisedButtonStyle,
                onPressed: () => onItemSelected(MoveLearnMethodType.egg),
                child: const Text('Egg'),
              ),
              ElevatedButton(
                style: selectedMethod == MoveLearnMethodType.tutor
                    ? selectedButtonStyle
                    : raisedButtonStyle,
                onPressed: () => onItemSelected(MoveLearnMethodType.tutor),
                child: const Text('Tutor'),
              ),
            ],
          ),
          const SizedBox(height: 10),
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
  const MoveButton({
    Key key,
    @required this.move,
  }) : super(key: key);

  final Move move;

  @override
  Widget build(BuildContext context) {
    return GalarButton(
      title: move.move.name,
      subtitle: 'Lv. ${move.versionGroupDetails.first.levelLearnedAt}',
    );
  }
}
