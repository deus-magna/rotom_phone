import 'dart:convert';

import 'package:rotom_phone/domain/entities/pokedex/pokedex.dart';

PokedexModel pokedexModelFromJson(String str) =>
    PokedexModel.fromJson(json.decode(str));

String pokedexModelToJson(PokedexModel data) => json.encode(data.toJson());

class PokedexModel extends Pokedex {
  PokedexModel({
    this.descriptions,
    this.id,
    this.isMainSeries,
    this.name,
    this.names,
    this.pokemonEntries,
    this.region,
    this.versionGroups,
  }) : super(
            descriptions: descriptions,
            id: id,
            isMainSeries: isMainSeries,
            name: name,
            names: names,
            pokemonEntries: pokemonEntries,
            region: region,
            versionGroups: versionGroups);

  final List<DescriptionModel> descriptions;
  final int id;
  final bool isMainSeries;
  final String name;
  final List<NameModel> names;
  final List<PokemonEntryModel> pokemonEntries;
  final dynamic region;
  final List<dynamic> versionGroups;

  factory PokedexModel.fromJson(Map<String, dynamic> json) => PokedexModel(
        descriptions: json["descriptions"] == null
            ? null
            : List<DescriptionModel>.from(
                json["descriptions"].map((x) => DescriptionModel.fromJson(x))),
        id: json["id"] == null ? null : json["id"],
        isMainSeries:
            json["is_main_series"] == null ? null : json["is_main_series"],
        name: json["name"] == null ? null : json["name"],
        names: json["names"] == null
            ? null
            : List<NameModel>.from(
                json["names"].map((x) => NameModel.fromJson(x))),
        pokemonEntries: json["pokemon_entries"] == null
            ? null
            : List<PokemonEntryModel>.from(json["pokemon_entries"]
                .map((x) => PokemonEntryModel.fromJson(x))),
        region: json["region"],
        versionGroups: json["version_groups"] == null
            ? null
            : List<dynamic>.from(json["version_groups"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "descriptions": descriptions == null
            ? null
            : List<dynamic>.from(descriptions.map((x) => x.toJson())),
        "id": id == null ? null : id,
        "is_main_series": isMainSeries == null ? null : isMainSeries,
        "name": name == null ? null : name,
        "names": names == null
            ? null
            : List<dynamic>.from(names.map((x) => x.toJson())),
        "pokemon_entries": pokemonEntries == null
            ? null
            : List<dynamic>.from(pokemonEntries.map((x) => x.toJson())),
        "region": region,
        "version_groups": versionGroups == null
            ? null
            : List<dynamic>.from(versionGroups.map((x) => x)),
      };
}

class DescriptionModel extends Description {
  DescriptionModel({
    this.description,
    this.language,
  }) : super(description: description, language: language);

  final String description;
  final LanguageModel language;

  factory DescriptionModel.fromJson(Map<String, dynamic> json) =>
      DescriptionModel(
        description: json["description"] == null ? null : json["description"],
        language: json["language"] == null
            ? null
            : LanguageModel.fromJson(json["language"]),
      );

  Map<String, dynamic> toJson() => {
        "description": description == null ? null : description,
        "language": language == null ? null : language.toJson(),
      };
}

class LanguageModel extends Language {
  LanguageModel({
    this.name,
    this.url,
  }) : super(name: name, url: url);

  final String name;
  final String url;

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "url": url == null ? null : url,
      };
}

class NameModel extends Name {
  NameModel({
    this.language,
    this.name,
  }) : super(language: language, name: name);

  final LanguageModel language;
  final String name;

  factory NameModel.fromJson(Map<String, dynamic> json) => NameModel(
        language: json["language"] == null
            ? null
            : LanguageModel.fromJson(json["language"]),
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "language": language == null ? null : language.toJson(),
        "name": name == null ? null : name,
      };
}

class PokemonEntryModel extends PokemonEntry {
  PokemonEntryModel({
    this.entryNumber,
    this.pokemonSpecies,
  }) : super(entryNumber: entryNumber, pokemonSpecies: pokemonSpecies);

  final int entryNumber;
  final PokemonSpeciesModel pokemonSpecies;

  factory PokemonEntryModel.fromJson(Map<String, dynamic> json) =>
      PokemonEntryModel(
        entryNumber: json["entry_number"] == null ? null : json["entry_number"],
        pokemonSpecies: json["pokemon_species"] == null
            ? null
            : PokemonSpeciesModel.fromJson(json["pokemon_species"]),
      );

  Map<String, dynamic> toJson() => {
        "entry_number": entryNumber == null ? null : entryNumber,
        "pokemon_species":
            pokemonSpecies == null ? null : pokemonSpecies.toJson(),
      };
}

class PokemonSpeciesModel extends PokemonSpecies {
  PokemonSpeciesModel({
    this.name,
    this.url,
  }) : super(name: name, url: url);

  final String name;
  final String url;

  factory PokemonSpeciesModel.fromJson(Map<String, dynamic> json) =>
      PokemonSpeciesModel(
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "url": url == null ? null : url,
      };
}
