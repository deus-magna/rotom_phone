import 'package:flutter/material.dart';
import 'package:rotom_phone/core/framework/colors.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_info.dart';
import 'package:rotom_phone/presentation/widgets/rounded_card.dart';

import 'pokemon_menu/menu_clippers.dart';

class AbilitiesCard extends StatelessWidget {
  final List<Ability> abilities;

  AbilitiesCard({Key key, this.abilities}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RoundedCardTitle(title: 'Abilities'),
          ...buildAbilities(abilities),
        ],
      ),
    );
  }

  List<Widget> buildAbilities(List<Ability> abilities) {
    return abilities.map((ability) {
      return AbilityButton(
        ability: ability,
      );
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
    final size = MediaQuery.of(context).size;
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: secondary,
      minimumSize: Size(88, 44),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: StadiumBorder(),
    );

    final style = TextStyle(
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontSize: 14,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          ButtonTheme(
            height: 44,
            child: ElevatedButton(
              style: raisedButtonStyle,
              onPressed: () => print('Show ability'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(ability.isHidden ? 'HA' : '', style: style),
                  SizedBox(width: 10),
                  Icon(Icons.info_outline_rounded),
                ],
              ),
            ),
          ),
          Positioned(
            top: 2,
            child: ClipPath(
              clipper: FrontMenuClipper(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 44,
                width: size.width * 0.62,
                color: primary,
                alignment: Alignment.centerLeft,
                child: Text(ability.name, style: style),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
