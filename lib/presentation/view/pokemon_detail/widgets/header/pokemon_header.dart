import 'package:flutter/material.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';
import 'package:rotom_phone/presentation/view/pokemon_detail/widgets/header/pokemon_header_info.dart';
import 'package:rotom_phone/presentation/widgets/official_artwork_view.dart';

class PokemonHeader extends StatelessWidget {
  const PokemonHeader({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final artwork =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.specie.id}.png';
    final types = pokemon.info.getTypes;
    final genus = pokemon.specie.genera
        .where((genera) => genera.language.name == 'en')
        .toList()
        .first
        .genus;

    return Container(
      margin: const EdgeInsets.only(top: 100),
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.04),
            child: OfficialArtworkView(
                artwork: artwork,
                height: size.height * 0.1477,
                tag: pokemon.specie.id),
          ),
          Positioned(
            top: 0,
            left: 20,
            child: PokemonHeaderInfo(
              name: pokemon.specie.name,
              id: pokemon.specie.getPokemonId(),
              genus: genus,
              types: types,
            ),
          ),
        ],
      ),
    );
  }
}
