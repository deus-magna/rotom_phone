import 'package:flutter/material.dart';

import 'package:rotom_phone/domain/entities/pokedex/pokemon_info.dart';
import 'package:rotom_phone/presentation/widgets/galar_button.dart';
import 'package:rotom_phone/presentation/widgets/rounded_card.dart';

class AbilitiesCard extends StatelessWidget {
  AbilitiesCard({Key key, this.abilities}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const RoundedCardTitle(title: 'Abilities'),
          ...buildAbilities(abilities),
        ],
      ),
    );
  }

  final List<Ability> abilities;

  List<Widget> buildAbilities(List<Ability> abilities) {
    return abilities.map((ability) {
      return AbilityButton(ability: ability);
    }).toList();
  }
}

class AbilityButton extends StatelessWidget {
  const AbilityButton({
    Key key,
    @required this.ability,
  }) : super(key: key);

  final Ability ability;

  @override
  Widget build(BuildContext context) {
    return GalarButton(
      title: ability.name,
      subtitle: ability.isHidden ? 'HA' : '',
      icon: const Icon(Icons.info_outline_rounded),
    );
  }
}
