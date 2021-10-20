import 'package:flutter/material.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';
import 'package:rotom_phone/presentation/widgets/rounded_card.dart';

class EvolutionsTab extends StatelessWidget {
  const EvolutionsTab({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedCard(
          child: Column(
            children: [
              const RoundedCardTitle(title: 'Evolution'),
              const RoundedCardTitle(title: 'Evolution'),
              const RoundedCardTitle(title: 'Evolution'),
            ],
          ),
        )
      ],
    );
  }
}
