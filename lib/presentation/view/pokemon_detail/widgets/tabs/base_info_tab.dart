import 'package:flutter/material.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';
import 'package:rotom_phone/presentation/widgets/pokemon_type_button.dart';
import 'package:rotom_phone/presentation/widgets/pokemon_types_row.dart';
import 'package:rotom_phone/presentation/widgets/rounded_card.dart';

import '../abilities_card.dart';
import '../pokedex_entry.dart';

class BaseInfoTab extends StatelessWidget {
  const BaseInfoTab({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PokedexEntry(entries: pokemon.pokedexEntries('en')),
        PokemonTypesRow(
          types: pokemon.info.getTypes,
          buttonsForm: ButtonForm.stadium,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        AboutRow(
            id: pokemon.specie.getPokemonId(),
            weight: pokemon.info.getWeight,
            height: pokemon.info.getHeight),
        AbilitiesCard(abilities: pokemon.info.abilities),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
      ],
    );
  }
}

class AboutRow extends StatelessWidget {
  const AboutRow({
    Key key,
    @required this.id,
    @required this.weight,
    @required this.height,
  }) : super(key: key);

  final String id;
  final double weight;
  final double height;

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
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        Text(
          label,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF8C8B90)),
        ),
      ],
    );
  }
}
