import 'package:flutter/material.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';
import 'package:rotom_phone/presentation/view/pokemon_detail/widgets/header/pokemon_header_info.dart';
import 'package:rotom_phone/presentation/widgets/official_artwork_view.dart';

class PokemonHeader extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonHeader({
    Key key,
    @required this.pokemon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final String artwork =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.pokemonSpecie.id}.png";
    final types =
        pokemon.pokemonInfo.types.map((element) => element.type).toList();
    final genus = pokemon.pokemonSpecie.genera
        .where((genera) => genera.language.name == 'en')
        .toList()
        .first
        .genus;

    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.05),
            child: OfficialArtworkView(
                artwork: artwork, height: 150, tag: pokemon.pokemonSpecie.id),
          ),
          Positioned(
            top: 0,
            left: 20,
            child: PokemonHeaderInfo(
              name: pokemon.pokemonSpecie.name,
              id: pokemon.pokemonSpecie.getPokemonId(),
              genus: genus,
              types: types,
            ),
          ),
        ],
      ),
    );
  }
}
