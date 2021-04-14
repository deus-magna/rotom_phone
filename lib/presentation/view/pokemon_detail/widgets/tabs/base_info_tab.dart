import 'package:flutter/material.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';
import 'package:rotom_phone/presentation/widgets/pokemon_type_button.dart';
import 'package:rotom_phone/presentation/widgets/pokemon_types_row.dart';

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
          PokedexEntry(entries: pokemon.pokemonSpecie.flavorTextEntries),
          PokemonTypesRow(
            types: pokemon.pokemonInfo.getTypes,
            buttonsForm: ButtonForm.Stadium,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          AboutRow(
              id: pokemon.pokemonSpecie.getPokemonId(),
              weight: pokemon.pokemonInfo.getWeight,
              height: pokemon.pokemonInfo.getHeight)
        ],
      ),
    );
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
    return Container(
      margin: EdgeInsets.all(20),
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
