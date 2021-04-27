import 'package:flutter/material.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';
import 'package:rotom_phone/presentation/widgets/rounded_card.dart';

class EvolutionChainView extends StatelessWidget {
  final Pokemon pokemon;

  const EvolutionChainView({
    Key key,
    @required this.pokemon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedCard(
          child: Column(
            children: [
              RoundedCardTitle(title: 'Evolution'),
              RoundedCardTitle(title: 'Evolution'),
              RoundedCardTitle(title: 'asdas'),
            ],
          ),
        )
      ],
    );
  }
}
