import 'package:equatable/equatable.dart';

import '../name.dart';
import '../resource_path.dart';

class Pokedex extends Equatable {
  Pokedex({
    this.descriptions,
    this.id,
    this.isMainSeries,
    this.name,
    this.names,
    this.pokemonEntries,
    this.region,
    this.versionGroups,
  });

  final List<Description> descriptions;
  final int id;
  final bool isMainSeries;
  final String name;
  final List<Name> names;
  final List<PokemonEntry> pokemonEntries;
  final dynamic region;
  final List<dynamic> versionGroups;

  @override
  List<Object> get props => [
        descriptions,
        id,
        isMainSeries,
        name,
        names,
        pokemonEntries,
        region,
        versionGroups
      ];
}

class Description extends Equatable {
  Description({
    this.description,
    this.language,
  });

  final String description;
  final ResourcePath language;

  @override
  List<Object> get props => [description, language];
}

class PokemonEntry extends Equatable {
  PokemonEntry({
    this.entryNumber,
    this.pokemonSpecies,
  });

  final int entryNumber;
  final ResourcePath pokemonSpecies;

  @override
  List<Object> get props => [entryNumber, pokemonSpecies];
}
