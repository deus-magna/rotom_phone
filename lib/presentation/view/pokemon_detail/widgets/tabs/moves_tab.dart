import 'package:flutter/material.dart';

import 'package:rotom_phone/core/framework/colors.dart';
import 'package:rotom_phone/core/utils/enums.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_info.dart';
import 'package:rotom_phone/presentation/widgets/galar_button.dart';
import 'package:rotom_phone/presentation/widgets/rounded_card.dart';

class MovesTab extends StatefulWidget {
  final Pokemon pokemon;

  const MovesTab({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  @override
  _MovesTabState createState() => _MovesTabState();
}

class _MovesTabState extends State<MovesTab> {
  String version;
  MoveLearnMethodType learnMethodType;

  @override
  void initState() {
    version = 'x-y';
    learnMethodType = MoveLearnMethodType.LEVEL_UP;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final moves =
        widget.pokemon.info.getMovesByLearnMethod(learnMethodType, version);

    return Column(
      children: [
        GenerationsCard(
          onItemSelected: onGenerationChanged,
        ),
        MovesCard(
          moves: moves,
          selectedMethod: learnMethodType,
          onItemSelected: onLearnMethodTypeChanged,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
      ],
    );
  }

  onLearnMethodTypeChanged(MoveLearnMethodType method) {
    setState(() {
      learnMethodType = method;
    });
  }

  onGenerationChanged(int index) {
    switch (index) {
      case 0:
        version = 'yellow';
        break;
      case 1:
        version = 'crystal';
        break;
      case 2:
        version = 'firered-leafgreen';
        break;
      case 3:
        version = 'heartgold-soulsilver';
        break;
      case 4:
        version = 'black-2-white-2';
        break;
      case 5:
        version = 'omega-ruby-alpha-sapphire';
        break;
      case 6:
        version = 'ultra-sun-ultra-moon';
        break;
      case 7:
        version = 'sword-shield';
        break;
      default:
    }
    setState(() {});
  }
}

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

class GenerationsCard extends StatefulWidget {
  final Function(int) onItemSelected;
  final int initialIndex;

  const GenerationsCard({
    Key key,
    @required this.onItemSelected,
    this.initialIndex = 6,
  }) : super(key: key);

  @override
  _GenerationsCardState createState() => _GenerationsCardState();
}

class _GenerationsCardState extends State<GenerationsCard> {
  int _currentIndex;
  @override
  void initState() {
    _currentIndex = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RoundedCardTitle(title: 'Generation'),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GenerationButton(
                onPressed: () => changeSelectedItem(0),
                isSelected: _currentIndex == 0,
              ),
              GenerationButton(
                generation: 'II',
                onPressed: () => changeSelectedItem(1),
                isSelected: _currentIndex == 1,
              ),
              GenerationButton(
                generation: 'III',
                onPressed: () => changeSelectedItem(2),
                isSelected: _currentIndex == 2,
              ),
              GenerationButton(
                generation: 'IV',
                onPressed: () => changeSelectedItem(3),
                isSelected: _currentIndex == 3,
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GenerationButton(
                generation: 'V',
                onPressed: () => changeSelectedItem(4),
                isSelected: _currentIndex == 4,
              ),
              GenerationButton(
                generation: 'VI',
                onPressed: () => changeSelectedItem(5),
                isSelected: _currentIndex == 5,
              ),
              GenerationButton(
                generation: 'VII',
                onPressed: () => changeSelectedItem(6),
                isSelected: _currentIndex == 6,
              ),
              GenerationButton(
                generation: 'VIII',
                onPressed: () => changeSelectedItem(7),
                isSelected: _currentIndex == 7,
              )
            ],
          ),
        ],
      )),
    );
  }

  changeSelectedItem(int index) {
    setState(() => _currentIndex = index);
    widget.onItemSelected(index);
  }
}

class GenerationButton extends StatelessWidget {
  const GenerationButton({
    Key key,
    this.generation = 'I',
    this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  final String generation;
  final Function onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? primary : Colors.grey[100],
        ),
        child: Center(
          child: Text(
            generation,
            style: TextStyle(
              fontSize: 22,
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
