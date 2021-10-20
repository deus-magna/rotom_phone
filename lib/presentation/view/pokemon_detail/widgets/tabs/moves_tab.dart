import 'package:flutter/material.dart';

import 'package:rotom_phone/core/utils/enums.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';

import '../generation_card.dart';
import '../moves_card.dart';

class MovesTab extends StatefulWidget {
  const MovesTab({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  _MovesTabState createState() => _MovesTabState();
}

class _MovesTabState extends State<MovesTab> {
  String version;
  MoveLearnMethodType learnMethodType;

  @override
  void initState() {
    version = 'x-y';
    learnMethodType = MoveLearnMethodType.levelUp;

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

  void onLearnMethodTypeChanged(MoveLearnMethodType method) {
    setState(() {
      learnMethodType = method;
    });
  }

  void onGenerationChanged(int index) {
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
