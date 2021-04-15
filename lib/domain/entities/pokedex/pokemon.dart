import 'package:equatable/equatable.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_info.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_specie.dart';

class Pokemon extends Equatable {
  final PokemonSpecie specie;
  final PokemonInfo info;

  Pokemon({this.specie, this.info});

  List<FlavorTextEntry> pokedexEntries(String language) =>
      specie.pokedexEntries(language);

  @override
  List<Object> get props => [info, specie];
}
