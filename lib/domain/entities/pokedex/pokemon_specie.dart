import 'package:equatable/equatable.dart';

import '../name.dart';
import '../resource_path.dart';
import '../../../core/extensions/string_extension.dart';

class PokemonSpecie extends Equatable {
  PokemonSpecie({
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
  });

  String getPokemonId() {
    return (this.id < 10)
        ? '#00${this.id}'
        : (this.id < 100)
            ? '#0${this.id}'
            : '#${this.id}';
  }

  List<FlavorTextEntry> pokedexEntries(String language) => flavorTextEntries
      .where((entry) => entry.language.name == language)
      .toList();

  final int baseHappiness;
  final int captureRate;
  final ResourcePath color;
  final List<ResourcePath> eggGroups;
  final EvolutionChain evolutionChain;
  final dynamic evolvesFromSpecies;
  final List<FlavorTextEntry> flavorTextEntries;
  final List<dynamic> formDescriptions;
  final bool formsSwitchable;
  final int genderRate;
  final List<Genus> genera;
  final ResourcePath generation;
  final ResourcePath growthRate;
  final ResourcePath habitat;
  final bool hasGenderDifferences;
  final int hatchCounter;
  final int id;
  final bool isBaby;
  final bool isLegendary;
  final bool isMythical;
  final String name;
  final List<Name> names;
  final int order;
  final List<PalParkEncounter> palParkEncounters;
  final List<PokedexNumber> pokedexNumbers;
  final ResourcePath shape;
  final List<Variety> varieties;

  @override
  List<Object> get props => [
        baseHappiness,
        captureRate,
        color,
        eggGroups,
        evolutionChain,
        evolvesFromSpecies,
        flavorTextEntries,
        formDescriptions,
        formsSwitchable,
        genderRate,
        genera,
        generation,
        growthRate,
        habitat,
        hasGenderDifferences,
        hatchCounter,
        id,
        isBaby,
        isLegendary,
        isMythical,
        name,
        names,
        order,
        palParkEncounters,
        pokedexNumbers,
        shape,
        varieties,
      ];
}

class EvolutionChain extends Equatable {
  EvolutionChain({
    this.url,
  });

  final String url;

  @override
  List<Object> get props => [url];
}

class FlavorTextEntry extends Equatable {
  FlavorTextEntry({
    this.flavorText,
    this.language,
    this.version,
  });

  final String flavorText;
  final ResourcePath language;
  final ResourcePath version;

  String get versionAcronym {
    if (version.name.length >= 2) {
      if (version.name.contains('-')) {
        final names = version.name.split('-');
        String versionAcronym = '';
        for (var name in names) {
          versionAcronym += name.substring(0, 1);
        }
        return versionAcronym.capitalize();
      }
      return version.name.substring(0, 2).capitalize();
    }
    return version.name.toUpperCase();
  }

  @override
  List<Object> get props => [flavorText, language, version];
}

class Genus extends Equatable {
  Genus({
    this.genus,
    this.language,
  });

  final String genus;
  final ResourcePath language;

  @override
  List<Object> get props => [language];
}

class PalParkEncounter extends Equatable {
  PalParkEncounter({
    this.area,
    this.baseScore,
    this.rate,
  });

  final ResourcePath area;
  final int baseScore;
  final int rate;

  @override
  List<Object> get props => [area, baseScore, rate];
}

class PokedexNumber extends Equatable {
  PokedexNumber({
    this.entryNumber,
    this.pokedex,
  });

  final int entryNumber;
  final ResourcePath pokedex;

  @override
  List<Object> get props => [entryNumber, pokedex];
}

class Variety extends Equatable {
  Variety({
    this.isDefault,
    this.pokemon,
  });

  final bool isDefault;
  final ResourcePath pokemon;

  @override
  List<Object> get props => [isDefault, pokemon];
}
