import 'package:flutter/material.dart';
import 'package:rotom_phone/core/framework/colors.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_info.dart';
import 'package:rotom_phone/presentation/view/pokemon_detail/widgets/pokemon_menu/menu_clippers.dart';
import 'package:rotom_phone/presentation/widgets/pokemon_type_button.dart';
import 'package:rotom_phone/presentation/widgets/pokemon_types_row.dart';
import 'package:rotom_phone/presentation/widgets/rounded_card.dart';

import '../pokedex_entry.dart';

class BaseInfoTab extends StatelessWidget {
  final Pokemon pokemon;

  const BaseInfoTab({
    Key key,
    @required this.pokemon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          PokedexEntry(entries: pokemon.pokedexEntries('en')),
          PokemonTypesRow(
            types: pokemon.info.getTypes,
            buttonsForm: ButtonForm.Stadium,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          AboutRow(
              id: pokemon.specie.getPokemonId(),
              weight: pokemon.info.getWeight,
              height: pokemon.info.getHeight),
          AbilitiesCard(abilities: pokemon.info.abilities),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        ],
      ),
    );
  }
}

class AbilitiesCard extends StatelessWidget {
  final List<Ability> abilities;
  final style = TextStyle(
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontSize: 14,
  );

  AbilitiesCard({Key key, this.abilities}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Abilities',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          ...buildAbilities(abilities),
        ],
      ),
    );
  }

  List<Widget> buildAbilities(List<Ability> abilities) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: secondary,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: StadiumBorder(),
    );

    return abilities.map((ability) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Stack(
          children: [
            ElevatedButton(
              style: raisedButtonStyle,
              onPressed: () => print('Show ability'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipPath(
                    clipper: BackMenuClipper(),
                    child: Container(
                      // height: 30,
                      width: 50,

                      child: Text(ability.isHidden ? '' : ''),
                    ),
                  ),
                  Text(ability.isHidden ? 'HA' : '', style: style),
                  SizedBox(width: 10),
                  Icon(Icons.info_outline_rounded),
                ],
              ),
            ),
            Positioned(
              top: 2,
              child: ClipPath(
                clipper: BackMenuClipper(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 44,
                  width: 240,
                  color: primary,
                  alignment: Alignment.centerLeft,
                  child: Text(ability.name, style: style),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

class AboutRow extends StatelessWidget {
  final String id;
  final double weight;
  final double height;

  const AboutRow({
    Key key,
    @required this.id,
    @required this.weight,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AboutView(
            id: id.substring(1),
            label: 'National N',
          ),
          AboutView(
            id: '$height M',
            label: 'Height',
          ),
          AboutView(
            id: '$weight KG',
            label: 'Weight',
          )
        ],
      ),
    );
  }
}

class AboutView extends StatelessWidget {
  const AboutView({
    Key key,
    @required this.id,
    @required this.label,
  }) : super(key: key);

  final String id;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          id,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        Text(
          label,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF8C8B90)),
        ),
      ],
    );
  }
}
