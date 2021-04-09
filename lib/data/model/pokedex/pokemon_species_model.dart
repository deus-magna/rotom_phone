import 'dart:convert';

import 'package:rotom_phone/domain/entities/name.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_species.dart';

import '../resource_path_model.dart';

PokemonSpeciesModel pokemonSpeciesModelFromJson(String str) =>
    PokemonSpeciesModel.fromJson(json.decode(str));

String pokemonSpeciesModelToJson(PokemonSpeciesModel data) =>
    json.encode(data.toJson());

class PokemonSpeciesModel extends PokemonSpecies {
  PokemonSpeciesModel({
    this.baseHappiness,
    this.captureRate,
    this.color,
    this.eggGroups,
    this.evolutionChain,
    this.evolvesFromSpecies,
    this.flavorTextEntries,
    this.formDescriptions,
    this.formsSwitchable,
    this.genderRate,
    this.genera,
    this.generation,
    this.growthRate,
    this.habitat,
    this.hasGenderDifferences,
    this.hatchCounter,
    this.id,
    this.isBaby,
    this.isLegendary,
    this.isMythical,
    this.name,
    this.names,
    this.order,
    this.palParkEncounters,
    this.pokedexNumbers,
    this.shape,
    this.varieties,
  }) : super(
            baseHappiness: baseHappiness,
            captureRate: captureRate,
            color: color,
            eggGroups: eggGroups,
            evolutionChain: evolutionChain,
            evolvesFromSpecies: evolvesFromSpecies,
            flavorTextEntries: flavorTextEntries,
            formDescriptions: formDescriptions,
            formsSwitchable: formsSwitchable,
            genderRate: genderRate,
            genera: genera,
            generation: generation,
            growthRate: growthRate,
            habitat: habitat,
            hasGenderDifferences: hasGenderDifferences,
            hatchCounter: hatchCounter,
            id: id,
            isBaby: isBaby,
            isLegendary: isLegendary,
            isMythical: isMythical,
            name: name,
            order: order,
            palParkEncounters: palParkEncounters,
            pokedexNumbers: pokedexNumbers,
            shape: shape,
            varieties: varieties);

  final int baseHappiness;
  final int captureRate;
  final ResourcePathModel color;
  final List<ResourcePathModel> eggGroups;
  final EvolutionChainModel evolutionChain;
  final dynamic evolvesFromSpecies;
  final List<FlavorTextEntryModel> flavorTextEntries;
  final List<dynamic> formDescriptions;
  final bool formsSwitchable;
  final int genderRate;
  final List<GenusModel> genera;
  final ResourcePathModel generation;
  final ResourcePathModel growthRate;
  final ResourcePathModel habitat;
  final bool hasGenderDifferences;
  final int hatchCounter;
  final int id;
  final bool isBaby;
  final bool isLegendary;
  final bool isMythical;
  final String name;
  final List<NameModel> names;
  final int order;
  final List<PalParkEncounterModel> palParkEncounters;
  final List<PokedexNumberModel> pokedexNumbers;
  final ResourcePathModel shape;
  final List<VarietyModel> varieties;

  factory PokemonSpeciesModel.fromJson(Map<String, dynamic> json) =>
      PokemonSpeciesModel(
        baseHappiness:
            json["base_happiness"] == null ? null : json["base_happiness"],
        captureRate: json["capture_rate"] == null ? null : json["capture_rate"],
        color: json["color"] == null
            ? null
            : ResourcePathModel.fromJson(json["color"]),
        eggGroups: json["egg_groups"] == null
            ? null
            : List<ResourcePathModel>.from(
                json["egg_groups"].map((x) => ResourcePathModel.fromJson(x))),
        evolutionChain: json["evolution_chain"] == null
            ? null
            : EvolutionChainModel.fromJson(json["evolution_chain"]),
        evolvesFromSpecies: json["evolves_from_species"],
        flavorTextEntries: json["flavor_text_entries"] == null
            ? null
            : List<FlavorTextEntryModel>.from(json["flavor_text_entries"]
                .map((x) => FlavorTextEntryModel.fromJson(x))),
        formDescriptions: json["form_descriptions"] == null
            ? null
            : List<dynamic>.from(json["form_descriptions"].map((x) => x)),
        formsSwitchable:
            json["forms_switchable"] == null ? null : json["forms_switchable"],
        genderRate: json["gender_rate"] == null ? null : json["gender_rate"],
        genera: json["genera"] == null
            ? null
            : List<GenusModel>.from(
                json["genera"].map((x) => GenusModel.fromJson(x))),
        generation: json["generation"] == null
            ? null
            : ResourcePathModel.fromJson(json["generation"]),
        growthRate: json["growth_rate"] == null
            ? null
            : ResourcePathModel.fromJson(json["growth_rate"]),
        habitat: json["habitat"] == null
            ? null
            : ResourcePathModel.fromJson(json["habitat"]),
        hasGenderDifferences: json["has_gender_differences"] == null
            ? null
            : json["has_gender_differences"],
        hatchCounter:
            json["hatch_counter"] == null ? null : json["hatch_counter"],
        id: json["id"] == null ? null : json["id"],
        isBaby: json["is_baby"] == null ? null : json["is_baby"],
        isLegendary: json["is_legendary"] == null ? null : json["is_legendary"],
        isMythical: json["is_mythical"] == null ? null : json["is_mythical"],
        name: json["name"] == null ? null : json["name"],
        names: json["names"] == null
            ? null
            : List<NameModel>.from(
                json["names"].map((x) => NameModel.fromJson(x))),
        order: json["order"] == null ? null : json["order"],
        palParkEncounters: json["pal_park_encounters"] == null
            ? null
            : List<PalParkEncounterModel>.from(json["pal_park_encounters"]
                .map((x) => PalParkEncounterModel.fromJson(x))),
        pokedexNumbers: json["pokedex_numbers"] == null
            ? null
            : List<PokedexNumberModel>.from(json["pokedex_numbers"]
                .map((x) => PokedexNumberModel.fromJson(x))),
        shape: json["shape"] == null
            ? null
            : ResourcePathModel.fromJson(json["shape"]),
        varieties: json["varieties"] == null
            ? null
            : List<VarietyModel>.from(
                json["varieties"].map((x) => VarietyModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "base_happiness": baseHappiness == null ? null : baseHappiness,
        "capture_rate": captureRate == null ? null : captureRate,
        "color": color == null ? null : color.toJson(),
        "egg_groups": eggGroups == null
            ? null
            : List<dynamic>.from(eggGroups.map((x) => x.toJson())),
        "evolution_chain":
            evolutionChain == null ? null : evolutionChain.toJson(),
        "evolves_from_species": evolvesFromSpecies,
        "flavor_text_entries": flavorTextEntries == null
            ? null
            : List<dynamic>.from(flavorTextEntries.map((x) => x.toJson())),
        "form_descriptions": formDescriptions == null
            ? null
            : List<dynamic>.from(formDescriptions.map((x) => x)),
        "forms_switchable": formsSwitchable == null ? null : formsSwitchable,
        "gender_rate": genderRate == null ? null : genderRate,
        "genera": genera == null
            ? null
            : List<dynamic>.from(genera.map((x) => x.toJson())),
        "generation": generation == null ? null : generation.toJson(),
        "growth_rate": growthRate == null ? null : growthRate.toJson(),
        "habitat": habitat == null ? null : habitat.toJson(),
        "has_gender_differences":
            hasGenderDifferences == null ? null : hasGenderDifferences,
        "hatch_counter": hatchCounter == null ? null : hatchCounter,
        "id": id == null ? null : id,
        "is_baby": isBaby == null ? null : isBaby,
        "is_legendary": isLegendary == null ? null : isLegendary,
        "is_mythical": isMythical == null ? null : isMythical,
        "name": name == null ? null : name,
        "names": names == null
            ? null
            : List<dynamic>.from(names.map((x) => x.toJson())),
        "order": order == null ? null : order,
        "pal_park_encounters": palParkEncounters == null
            ? null
            : List<dynamic>.from(palParkEncounters.map((x) => x.toJson())),
        "pokedex_numbers": pokedexNumbers == null
            ? null
            : List<dynamic>.from(pokedexNumbers.map((x) => x.toJson())),
        "shape": shape == null ? null : shape.toJson(),
        "varieties": varieties == null
            ? null
            : List<dynamic>.from(varieties.map((x) => x.toJson())),
      };
}

class EvolutionChainModel extends EvolutionChain {
  EvolutionChainModel({
    this.url,
  }) : super(url: url);

  final String url;

  factory EvolutionChainModel.fromJson(Map<String, dynamic> json) =>
      EvolutionChainModel(
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
      };
}

class FlavorTextEntryModel extends FlavorTextEntry {
  FlavorTextEntryModel({
    this.flavorText,
    this.language,
    this.version,
  }) : super(
          flavorText: flavorText,
          language: language,
          version: version,
        );

  final String flavorText;
  final ResourcePathModel language;
  final ResourcePathModel version;

  factory FlavorTextEntryModel.fromJson(Map<String, dynamic> json) =>
      FlavorTextEntryModel(
        flavorText: json["flavor_text"] == null ? null : json["flavor_text"],
        language: json["language"] == null
            ? null
            : ResourcePathModel.fromJson(json["language"]),
        version: json["version"] == null
            ? null
            : ResourcePathModel.fromJson(json["version"]),
      );

  Map<String, dynamic> toJson() => {
        "flavor_text": flavorText == null ? null : flavorText,
        "language": language == null ? null : language.toJson(),
        "version": version == null ? null : version.toJson(),
      };
}

class GenusModel extends Genus {
  GenusModel({
    this.genus,
    this.language,
  }) : super(
          genus: genus,
          language: language,
        );

  final String genus;
  final ResourcePathModel language;

  factory GenusModel.fromJson(Map<String, dynamic> json) => GenusModel(
        genus: json["genus"] == null ? null : json["genus"],
        language: json["language"] == null
            ? null
            : ResourcePathModel.fromJson(json["language"]),
      );

  Map<String, dynamic> toJson() => {
        "genus": genus == null ? null : genus,
        "language": language == null ? null : language.toJson(),
      };
}

class NameModel extends Name {
  NameModel({
    this.language,
    this.name,
  }) : super(
          name: name,
          language: language,
        );

  final ResourcePathModel language;
  final String name;

  factory NameModel.fromJson(Map<String, dynamic> json) => NameModel(
        language: json["language"] == null
            ? null
            : ResourcePathModel.fromJson(json["language"]),
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "language": language == null ? null : language.toJson(),
        "name": name == null ? null : name,
      };
}

class PalParkEncounterModel extends PalParkEncounter {
  PalParkEncounterModel({
    this.area,
    this.baseScore,
    this.rate,
  }) : super(
          area: area,
          baseScore: baseScore,
          rate: rate,
        );

  final ResourcePathModel area;
  final int baseScore;
  final int rate;

  factory PalParkEncounterModel.fromJson(Map<String, dynamic> json) =>
      PalParkEncounterModel(
        area: json["area"] == null
            ? null
            : ResourcePathModel.fromJson(json["area"]),
        baseScore: json["base_score"] == null ? null : json["base_score"],
        rate: json["rate"] == null ? null : json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "area": area == null ? null : area.toJson(),
        "base_score": baseScore == null ? null : baseScore,
        "rate": rate == null ? null : rate,
      };
}

class PokedexNumberModel extends PokedexNumber {
  PokedexNumberModel({
    this.entryNumber,
    this.pokedex,
  }) : super(
          pokedex: pokedex,
          entryNumber: entryNumber,
        );

  final int entryNumber;
  final ResourcePathModel pokedex;

  factory PokedexNumberModel.fromJson(Map<String, dynamic> json) =>
      PokedexNumberModel(
        entryNumber: json["entry_number"] == null ? null : json["entry_number"],
        pokedex: json["pokedex"] == null
            ? null
            : ResourcePathModel.fromJson(json["pokedex"]),
      );

  Map<String, dynamic> toJson() => {
        "entry_number": entryNumber == null ? null : entryNumber,
        "pokedex": pokedex == null ? null : pokedex.toJson(),
      };
}

class VarietyModel extends Variety {
  VarietyModel({
    this.isDefault,
    this.pokemon,
  }) : super(
          isDefault: isDefault,
          pokemon: pokemon,
        );

  final bool isDefault;
  final ResourcePathModel pokemon;

  factory VarietyModel.fromJson(Map<String, dynamic> json) => VarietyModel(
        isDefault: json["is_default"] == null ? null : json["is_default"],
        pokemon: json["pokemon"] == null
            ? null
            : ResourcePathModel.fromJson(json["pokemon"]),
      );

  Map<String, dynamic> toJson() => {
        "is_default": isDefault == null ? null : isDefault,
        "pokemon": pokemon == null ? null : pokemon.toJson(),
      };
}
