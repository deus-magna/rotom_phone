import 'package:equatable/equatable.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_info.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_specie.dart';

class Pokemon extends Equatable {
  final PokemonSpecie pokemonSpecie;
  final PokemonInfo pokemonInfo;

  Pokemon({this.pokemonSpecie, this.pokemonInfo});

  @override
  List<Object> get props => [pokemonInfo, pokemonSpecie];
}
