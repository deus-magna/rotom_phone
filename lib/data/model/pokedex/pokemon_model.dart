import 'package:rotom_phone/data/model/pokedex/pokemon_info_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_specie_model.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';

class PokemonModel extends Pokemon {
  final PokemonInfoModel pokemonInfo;
  final PokemonSpecieModel pokemonSpecie;

  PokemonModel(this.pokemonInfo, this.pokemonSpecie)
      : super(pokemonInfo: pokemonInfo, pokemonSpecie: pokemonSpecie);
}
