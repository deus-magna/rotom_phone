import 'package:equatable/equatable.dart';
import 'package:rotom_phone/core/utils/enums.dart';
import 'package:rotom_phone/domain/entities/resource_path.dart';
import '../../../core/extensions/string_extension.dart';
import 'move_learn_method.dart';

class PokemonInfo extends Equatable {
  PokemonInfo({
    this.abilities,
    this.baseExperience,
    this.forms,
    this.gameIndices,
    this.height,
    this.heldItems,
    this.id,
    this.isDefault,
    this.locationAreaEncounters,
    this.moves,
    this.name,
    this.order,
    this.pastTypes,
    this.species,
    this.sprites,
    this.stats,
    this.types,
    this.weight,
  });

  final List<Ability> abilities;
  final int baseExperience;
  final List<ResourcePath> forms;
  final List<GameIndex> gameIndices;
  final int height;
  final List<dynamic> heldItems;
  final int id;
  final bool isDefault;
  final String locationAreaEncounters;
  final List<Move> moves;
  final String name;
  final int order;
  final List<dynamic> pastTypes;
  final ResourcePath species;
  final Sprites sprites;
  final List<Stat> stats;
  final List<Type> types;
  final int weight;

  List<ResourcePath> get getTypes =>
      types.map((element) => element.type).toList();

  double get getWeight => weight / 10;
  double get getHeight => height / 10;

  List<Move> getMovesByLearnMethod(MoveLearnMethodType method) {
    final String version = 'x-y';
    final filteredMoves = moves.where((move) {
      print('MOVE: ${move.move.name}');
      final versionGroupDetails = move.versionGroupDetails;
      final data = versionGroupDetails.where((versionGroupDetail) {
        if (versionGroupDetail.moveLearnMethod.name == method &&
            versionGroupDetail.versionGroup.name == version) {
          return true;
        }
        return false;
      }).toList();
      print('DATA: ${data.length}');
      if (data.length > 0) {
        return true;
      }
      return false;
    }).toList();

    final List<Move> theMoves = [];
    for (var move in filteredMoves) {
      for (var versionGroupDetail in move.versionGroupDetails) {
        if (versionGroupDetail.moveLearnMethod.name == method &&
            versionGroupDetail.versionGroup.name == version) {
          theMoves.add(
              Move(move: move.move, versionGroupDetails: [versionGroupDetail]));
        }
      }
    }
    return theMoves;
  }

  @override
  List<Object> get props => [
        abilities,
        baseExperience,
        forms,
        gameIndices,
        height,
        heldItems,
        id,
        isDefault,
        locationAreaEncounters,
        moves,
        name,
        order,
        pastTypes,
        species,
        sprites,
        stats,
        types,
        weight,
      ];
}

class Ability extends Equatable {
  Ability({
    this.ability,
    this.isHidden,
    this.slot,
  });

  final ResourcePath ability;
  final bool isHidden;
  final int slot;

  String get name => ability.name.replaceAll('-', ' ').capitalize();

  @override
  List<Object> get props => [ability, isHidden, slot];
}

class GameIndex extends Equatable {
  GameIndex({
    this.gameIndex,
    this.version,
  });

  final int gameIndex;
  final ResourcePath version;

  @override
  List<Object> get props => [gameIndex, version];
}

class Move extends Equatable {
  Move({
    this.move,
    this.versionGroupDetails,
  });

  final ResourcePath move;
  final List<VersionGroupDetail> versionGroupDetails;

  @override
  List<Object> get props => [move, versionGroupDetails];
}

class VersionGroupDetail extends Equatable {
  VersionGroupDetail({
    this.levelLearnedAt,
    this.moveLearnMethod,
    this.versionGroup,
  });

  final int levelLearnedAt;
  final MoveLearnMethod moveLearnMethod;
  final ResourcePath versionGroup;

  @override
  List<Object> get props => [levelLearnedAt, moveLearnMethod, versionGroup];
}

class GenerationV extends Equatable {
  GenerationV({
    this.blackWhite,
  });

  final Sprites blackWhite;

  @override
  List<Object> get props => [blackWhite];
}

class GenerationIv extends Equatable {
  GenerationIv({
    this.diamondPearl,
    this.heartgoldSoulsilver,
    this.platinum,
  });

  final Sprites diamondPearl;
  final Sprites heartgoldSoulsilver;
  final Sprites platinum;

  @override
  List<Object> get props => [diamondPearl, heartgoldSoulsilver, platinum];
}

class Versions extends Equatable {
  Versions({
    this.generationI,
    this.generationIi,
    this.generationIii,
    this.generationIv,
    this.generationV,
    this.generationVi,
    this.generationVii,
    this.generationViii,
  });

  final GenerationI generationI;
  final GenerationIi generationIi;
  final GenerationIii generationIii;
  final GenerationIv generationIv;
  final GenerationV generationV;
  final Map<String, GenerationVi> generationVi;
  final GenerationVii generationVii;
  final GenerationViii generationViii;

  @override
  List<Object> get props => [
        generationI,
        generationIi,
        generationIii,
        generationIv,
        generationV,
        generationVi,
        generationVii,
        generationViii
      ];
}

class Sprites extends Equatable {
  Sprites({
    this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
    this.other,
    this.versions,
    this.animated,
  });

  final String backDefault;
  final dynamic backFemale;
  final String backShiny;
  final dynamic backShinyFemale;
  final String frontDefault;
  final dynamic frontFemale;
  final String frontShiny;
  final dynamic frontShinyFemale;
  final Other other;
  final Versions versions;
  final Sprites animated;

  @override
  List<Object> get props => [
        backDefault,
        backFemale,
        backShiny,
        backShinyFemale,
        frontDefault,
        frontFemale,
        frontShiny,
        frontShinyFemale,
        other,
        versions,
        animated
      ];
}

class GenerationI extends Equatable {
  GenerationI({
    this.redBlue,
    this.yellow,
  });

  final RedBlue redBlue;
  final RedBlue yellow;

  @override
  List<Object> get props => [redBlue, yellow];
}

class RedBlue extends Equatable {
  RedBlue({
    this.backDefault,
    this.backGray,
    this.frontDefault,
    this.frontGray,
  });

  final String backDefault;
  final String backGray;
  final String frontDefault;
  final String frontGray;

  @override
  List<Object> get props => [backDefault, backGray, frontDefault, frontGray];
}

class GenerationIi extends Equatable {
  GenerationIi({
    this.crystal,
    this.gold,
    this.silver,
  });

  final Crystal crystal;
  final Crystal gold;
  final Crystal silver;

  @override
  List<Object> get props => [crystal, gold, silver];
}

class Crystal extends Equatable {
  Crystal({
    this.backDefault,
    this.backShiny,
    this.frontDefault,
    this.frontShiny,
  });

  final String backDefault;
  final String backShiny;
  final String frontDefault;
  final String frontShiny;

  @override
  List<Object> get props => [backDefault, backShiny, frontDefault, frontShiny];
}

class GenerationIii extends Equatable {
  GenerationIii({
    this.emerald,
    this.fireredLeafgreen,
    this.rubySapphire,
  });

  final Emerald emerald;
  final Crystal fireredLeafgreen;
  final Crystal rubySapphire;

  @override
  List<Object> get props => [emerald, fireredLeafgreen, rubySapphire];
}

class Emerald extends Equatable {
  Emerald({
    this.frontDefault,
    this.frontShiny,
  });

  final String frontDefault;
  final String frontShiny;

  @override
  List<Object> get props => [frontDefault, frontShiny];
}

class GenerationVi extends Equatable {
  GenerationVi({
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  });

  final String frontDefault;
  final dynamic frontFemale;
  final String frontShiny;
  final dynamic frontShinyFemale;

  @override
  List<Object> get props =>
      [frontDefault, frontFemale, frontShiny, frontShinyFemale];
}

class GenerationVii extends Equatable {
  GenerationVii({
    this.icons,
    this.ultraSunUltraMoon,
  });

  final DreamWorld icons;
  final GenerationVi ultraSunUltraMoon;

  @override
  List<Object> get props => [icons, ultraSunUltraMoon];
}

class DreamWorld extends Equatable {
  DreamWorld({
    this.frontDefault,
    this.frontFemale,
  });

  final String frontDefault;
  final dynamic frontFemale;

  @override
  List<Object> get props => [frontDefault, frontFemale];
}

class GenerationViii extends Equatable {
  GenerationViii({
    this.icons,
  });

  final DreamWorld icons;

  @override
  List<Object> get props => [icons];
}

class Other extends Equatable {
  Other({
    this.dreamWorld,
    this.officialArtwork,
  });

  final DreamWorld dreamWorld;
  final OfficialArtwork officialArtwork;

  @override
  List<Object> get props => [dreamWorld, officialArtwork];
}

class OfficialArtwork extends Equatable {
  OfficialArtwork({
    this.frontDefault,
  });

  final String frontDefault;

  @override
  List<Object> get props => [frontDefault];
}

class Stat extends Equatable {
  Stat({
    this.baseStat,
    this.effort,
    this.stat,
  });

  final int baseStat;
  final int effort;
  final ResourcePath stat;

  @override
  List<Object> get props => [baseStat, effort, stat];
}

class Type extends Equatable {
  Type({
    this.slot,
    this.type,
  });

  final int slot;
  final ResourcePath type;

  @override
  List<Object> get props => [slot, type];
}
