import 'package:rotom_phone/data/model/pokedex/pokemon_info_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_specie_model.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';

class PokemonModel extends Pokemon {
  PokemonModel(PokemonInfoModel info, PokemonSpecieModel specie)
      : super(
          info: info,
          specie: specie,
        );
}
