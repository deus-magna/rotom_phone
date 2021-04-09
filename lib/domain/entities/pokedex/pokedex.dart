import 'package:equatable/equatable.dart';

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
  final Language language;

  @override
  List<Object> get props => [description, language];
}

class Language extends Equatable {
  Language({
    this.name,
    this.url,
  });

  final String name;
  final String url;

  @override
  List<Object> get props => [name, url];
}

class Name extends Equatable {
  Name({
    this.language,
    this.name,
  });

  final Language language;
  final String name;

  @override
  List<Object> get props => [language, name];
}

class PokemonEntry extends Equatable {
  PokemonEntry({
    this.entryNumber,
    this.pokemonSpecies,
  });

  final int entryNumber;
  final PokemonSpecies pokemonSpecies;

  @override
  List<Object> get props => [entryNumber, pokemonSpecies];
}

class PokemonSpecies extends Equatable {
  PokemonSpecies({
    this.name,
    this.url,
  });

  final String name;
  final String url;

  @override
  List<Object> get props => [name, url];
}
