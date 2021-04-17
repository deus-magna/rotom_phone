import 'dart:convert';

import 'package:rotom_phone/data/model/pokedex/move_learn_method_model.dart';
import 'package:rotom_phone/data/model/resource_path_model.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_info.dart';

PokemonInfoModel pokemonInfoModelFromJson(String str) =>
    PokemonInfoModel.fromJson(json.decode(str));

String pokemonInfoModelToJson(PokemonInfoModel data) =>
    json.encode(data.toJson());

class PokemonInfoModel extends PokemonInfo {
  PokemonInfoModel({
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
  }) : super(
            abilities: abilities,
            baseExperience: baseExperience,
            forms: forms,
            gameIndices: gameIndices,
            height: height,
            heldItems: heldItems,
            id: id,
            isDefault: isDefault,
            locationAreaEncounters: locationAreaEncounters,
            moves: moves,
            name: name,
            order: order,
            pastTypes: pastTypes,
            species: species,
            sprites: sprites,
            stats: stats,
            types: types,
            weight: weight);

  final List<AbilityModel> abilities;
  final int baseExperience;
  final List<ResourcePathModel> forms;
  final List<GameIndexModel> gameIndices;
  final int height;
  final List<dynamic> heldItems;
  final int id;
  final bool isDefault;
  final String locationAreaEncounters;
  final List<MoveModel> moves;
  final String name;
  final int order;
  final List<dynamic> pastTypes;
  final ResourcePathModel species;
  final SpritesModel sprites;
  final List<StatModel> stats;
  final List<TypeModel> types;
  final int weight;

  factory PokemonInfoModel.fromJson(Map<String, dynamic> json) =>
      PokemonInfoModel(
        abilities: json["abilities"] == null
            ? null
            : List<AbilityModel>.from(
                json["abilities"].map((x) => AbilityModel.fromJson(x))),
        baseExperience:
            json["base_experience"] == null ? null : json["base_experience"],
        forms: json["forms"] == null
            ? null
            : List<ResourcePathModel>.from(
                json["forms"].map((x) => ResourcePathModel.fromJson(x))),
        gameIndices: json["game_indices"] == null
            ? null
            : List<GameIndexModel>.from(
                json["game_indices"].map((x) => GameIndexModel.fromJson(x))),
        height: json["height"] == null ? null : json["height"],
        heldItems: json["held_items"] == null
            ? null
            : List<dynamic>.from(json["held_items"].map((x) => x)),
        id: json["id"] == null ? null : json["id"],
        isDefault: json["is_default"] == null ? null : json["is_default"],
        locationAreaEncounters: json["location_area_encounters"] == null
            ? null
            : json["location_area_encounters"],
        moves: json["moves"] == null
            ? null
            : List<MoveModel>.from(
                json["moves"].map((x) => MoveModel.fromJson(x))),
        name: json["name"] == null ? null : json["name"],
        order: json["order"] == null ? null : json["order"],
        pastTypes: json["past_types"] == null
            ? null
            : List<dynamic>.from(json["past_types"].map((x) => x)),
        species: json["species"] == null
            ? null
            : ResourcePathModel.fromJson(json["species"]),
        sprites: json["sprites"] == null
            ? null
            : SpritesModel.fromJson(json["sprites"]),
        stats: json["stats"] == null
            ? null
            : List<StatModel>.from(
                json["stats"].map((x) => StatModel.fromJson(x))),
        types: json["types"] == null
            ? null
            : List<TypeModel>.from(
                json["types"].map((x) => TypeModel.fromJson(x))),
        weight: json["weight"] == null ? null : json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "abilities": abilities == null
            ? null
            : List<dynamic>.from(abilities.map((x) => x.toJson())),
        "base_experience": baseExperience == null ? null : baseExperience,
        "forms": forms == null
            ? null
            : List<dynamic>.from(forms.map((x) => x.toJson())),
        "game_indices": gameIndices == null
            ? null
            : List<dynamic>.from(gameIndices.map((x) => x.toJson())),
        "height": height == null ? null : height,
        "held_items": heldItems == null
            ? null
            : List<dynamic>.from(heldItems.map((x) => x)),
        "id": id == null ? null : id,
        "is_default": isDefault == null ? null : isDefault,
        "location_area_encounters":
            locationAreaEncounters == null ? null : locationAreaEncounters,
        "moves": moves == null
            ? null
            : List<dynamic>.from(moves.map((x) => x.toJson())),
        "name": name == null ? null : name,
        "order": order == null ? null : order,
        "past_types": pastTypes == null
            ? null
            : List<dynamic>.from(pastTypes.map((x) => x)),
        "species": species == null ? null : species.toJson(),
        "sprites": sprites == null ? null : sprites.toJson(),
        "stats": stats == null
            ? null
            : List<dynamic>.from(stats.map((x) => x.toJson())),
        "types": types == null
            ? null
            : List<dynamic>.from(types.map((x) => x.toJson())),
        "weight": weight == null ? null : weight,
      };
}

class AbilityModel extends Ability {
  AbilityModel({
    this.ability,
    this.isHidden,
    this.slot,
  }) : super(ability: ability, isHidden: isHidden, slot: slot);

  final ResourcePathModel ability;
  final bool isHidden;
  final int slot;

  factory AbilityModel.fromJson(Map<String, dynamic> json) => AbilityModel(
        ability: json["ability"] == null
            ? null
            : ResourcePathModel.fromJson(json["ability"]),
        isHidden: json["is_hidden"] == null ? null : json["is_hidden"],
        slot: json["slot"] == null ? null : json["slot"],
      );

  Map<String, dynamic> toJson() => {
        "ability": ability == null ? null : ability.toJson(),
        "is_hidden": isHidden == null ? null : isHidden,
        "slot": slot == null ? null : slot,
      };
}

class GameIndexModel extends GameIndex {
  GameIndexModel({
    this.gameIndex,
    this.version,
  }) : super(gameIndex: gameIndex, version: version);

  final int gameIndex;
  final ResourcePathModel version;

  factory GameIndexModel.fromJson(Map<String, dynamic> json) => GameIndexModel(
        gameIndex: json["game_index"] == null ? null : json["game_index"],
        version: json["version"] == null
            ? null
            : ResourcePathModel.fromJson(json["version"]),
      );

  Map<String, dynamic> toJson() => {
        "game_index": gameIndex == null ? null : gameIndex,
        "version": version == null ? null : version.toJson(),
      };
}

class MoveModel extends Move {
  MoveModel({
    this.move,
    this.versionGroupDetails,
  }) : super(move: move, versionGroupDetails: versionGroupDetails);

  final ResourcePathModel move;
  final List<VersionGroupDetailModel> versionGroupDetails;

  factory MoveModel.fromJson(Map<String, dynamic> json) => MoveModel(
        move: json["move"] == null
            ? null
            : ResourcePathModel.fromJson(json["move"]),
        versionGroupDetails: json["version_group_details"] == null
            ? null
            : List<VersionGroupDetailModel>.from(json["version_group_details"]
                .map((x) => VersionGroupDetailModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "move": move == null ? null : move.toJson(),
        "version_group_details": versionGroupDetails == null
            ? null
            : List<dynamic>.from(versionGroupDetails.map((x) => x.toJson())),
      };
}

class VersionGroupDetailModel extends VersionGroupDetail {
  VersionGroupDetailModel({
    this.levelLearnedAt,
    this.moveLearnMethod,
    this.versionGroup,
  }) : super(
            levelLearnedAt: levelLearnedAt,
            moveLearnMethod: moveLearnMethod,
            versionGroup: versionGroup);

  final int levelLearnedAt;
  final MoveLearnMethodModel moveLearnMethod;
  final ResourcePathModel versionGroup;

  factory VersionGroupDetailModel.fromJson(Map<String, dynamic> json) =>
      VersionGroupDetailModel(
        levelLearnedAt:
            json["level_learned_at"] == null ? null : json["level_learned_at"],
        moveLearnMethod: json["move_learn_method"] == null
            ? null
            : MoveLearnMethodModel.fromJson(json["move_learn_method"]),
        versionGroup: json["version_group"] == null
            ? null
            : ResourcePathModel.fromJson(json["version_group"]),
      );

  Map<String, dynamic> toJson() => {
        "level_learned_at": levelLearnedAt == null ? null : levelLearnedAt,
        "move_learn_method":
            moveLearnMethod == null ? null : moveLearnMethod.toJson(),
        "version_group": versionGroup == null ? null : versionGroup.toJson(),
      };
}

class GenerationVModel extends GenerationV {
  GenerationVModel({
    this.blackWhite,
  }) : super(blackWhite: blackWhite);

  final SpritesModel blackWhite;

  factory GenerationVModel.fromJson(Map<String, dynamic> json) =>
      GenerationVModel(
        blackWhite: json["black-white"] == null
            ? null
            : SpritesModel.fromJson(json["black-white"]),
      );

  Map<String, dynamic> toJson() => {
        "black-white": blackWhite == null ? null : blackWhite.toJson(),
      };
}

class GenerationIVModel extends GenerationIv {
  GenerationIVModel({
    this.diamondPearl,
    this.heartgoldSoulsilver,
    this.platinum,
  }) : super(
            diamondPearl: diamondPearl,
            heartgoldSoulsilver: heartgoldSoulsilver,
            platinum: platinum);

  final SpritesModel diamondPearl;
  final SpritesModel heartgoldSoulsilver;
  final SpritesModel platinum;

  factory GenerationIVModel.fromJson(Map<String, dynamic> json) =>
      GenerationIVModel(
        diamondPearl: json["diamond-pearl"] == null
            ? null
            : SpritesModel.fromJson(json["diamond-pearl"]),
        heartgoldSoulsilver: json["heartgold-soulsilver"] == null
            ? null
            : SpritesModel.fromJson(json["heartgold-soulsilver"]),
        platinum: json["platinum"] == null
            ? null
            : SpritesModel.fromJson(json["platinum"]),
      );

  Map<String, dynamic> toJson() => {
        "diamond-pearl": diamondPearl == null ? null : diamondPearl.toJson(),
        "heartgold-soulsilver":
            heartgoldSoulsilver == null ? null : heartgoldSoulsilver.toJson(),
        "platinum": platinum == null ? null : platinum.toJson(),
      };
}

class VersionsModel extends Versions {
  VersionsModel({
    this.generationI,
    this.generationIi,
    this.generationIii,
    this.generationIv,
    this.generationV,
    this.generationVi,
    this.generationVii,
    this.generationViii,
  }) : super(
            generationI: generationI,
            generationIi: generationIi,
            generationIii: generationIii,
            generationIv: generationIv,
            generationV: generationV,
            generationVi: generationVi,
            generationVii: generationVii,
            generationViii: generationViii);

  final GenerationIModel generationI;
  final GenerationIIModel generationIi;
  final GenerationIIIModel generationIii;
  final GenerationIVModel generationIv;
  final GenerationVModel generationV;
  final Map<String, GenerationVIModel> generationVi;
  final GenerationVIIModel generationVii;
  final GenerationVIIIModel generationViii;

  factory VersionsModel.fromJson(Map<String, dynamic> json) => VersionsModel(
        generationI: json["generation-i"] == null
            ? null
            : GenerationIModel.fromJson(json["generation-i"]),
        generationIi: json["generation-ii"] == null
            ? null
            : GenerationIIModel.fromJson(json["generation-ii"]),
        generationIii: json["generation-iii"] == null
            ? null
            : GenerationIIIModel.fromJson(json["generation-iii"]),
        generationIv: json["generation-iv"] == null
            ? null
            : GenerationIVModel.fromJson(json["generation-iv"]),
        generationV: json["generation-v"] == null
            ? null
            : GenerationVModel.fromJson(json["generation-v"]),
        generationVi: json["generation-vi"] == null
            ? null
            : Map.from(json["generation-vi"]).map((k, v) =>
                MapEntry<String, GenerationVIModel>(
                    k, GenerationVIModel.fromJson(v))),
        generationVii: json["generation-vii"] == null
            ? null
            : GenerationVIIModel.fromJson(json["generation-vii"]),
        generationViii: json["generation-viii"] == null
            ? null
            : GenerationVIIIModel.fromJson(json["generation-viii"]),
      );

  Map<String, dynamic> toJson() => {
        "generation-i": generationI == null ? null : generationI.toJson(),
        "generation-ii": generationIi == null ? null : generationIi.toJson(),
        "generation-iii": generationIii == null ? null : generationIii.toJson(),
        "generation-iv": generationIv == null ? null : generationIv.toJson(),
        "generation-v": generationV == null ? null : generationV.toJson(),
        "generation-vi": generationVi == null
            ? null
            : Map.from(generationVi)
                .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "generation-vii": generationVii == null ? null : generationVii.toJson(),
        "generation-viii":
            generationViii == null ? null : generationViii.toJson(),
      };
}

class SpritesModel extends Sprites {
  SpritesModel({
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
  }) : super(
            backDefault: backDefault,
            backFemale: backFemale,
            backShiny: backShiny,
            backShinyFemale: backShinyFemale,
            frontDefault: frontDefault,
            frontFemale: frontFemale,
            frontShiny: frontShiny,
            frontShinyFemale: frontShinyFemale,
            other: other,
            versions: versions,
            animated: animated);

  final String backDefault;
  final dynamic backFemale;
  final String backShiny;
  final dynamic backShinyFemale;
  final String frontDefault;
  final dynamic frontFemale;
  final String frontShiny;
  final dynamic frontShinyFemale;
  final OtherModel other;
  final VersionsModel versions;
  final SpritesModel animated;

  factory SpritesModel.fromJson(Map<String, dynamic> json) => SpritesModel(
        backDefault: json["back_default"] == null ? null : json["back_default"],
        backFemale: json["back_female"],
        backShiny: json["back_shiny"] == null ? null : json["back_shiny"],
        backShinyFemale: json["back_shiny_female"],
        frontDefault:
            json["front_default"] == null ? null : json["front_default"],
        frontFemale: json["front_female"],
        frontShiny: json["front_shiny"] == null ? null : json["front_shiny"],
        frontShinyFemale: json["front_shiny_female"],
        other:
            json["other"] == null ? null : OtherModel.fromJson(json["other"]),
        versions: json["versions"] == null
            ? null
            : VersionsModel.fromJson(json["versions"]),
        animated: json["animated"] == null
            ? null
            : SpritesModel.fromJson(json["animated"]),
      );

  Map<String, dynamic> toJson() => {
        "back_default": backDefault == null ? null : backDefault,
        "back_female": backFemale,
        "back_shiny": backShiny == null ? null : backShiny,
        "back_shiny_female": backShinyFemale,
        "front_default": frontDefault == null ? null : frontDefault,
        "front_female": frontFemale,
        "front_shiny": frontShiny == null ? null : frontShiny,
        "front_shiny_female": frontShinyFemale,
        "other": other == null ? null : other.toJson(),
        "versions": versions == null ? null : versions.toJson(),
        "animated": animated == null ? null : animated.toJson(),
      };
}

class GenerationIModel extends GenerationI {
  GenerationIModel({
    this.redBlue,
    this.yellow,
  }) : super(redBlue: redBlue, yellow: yellow);

  final RedBlueModel redBlue;
  final RedBlueModel yellow;

  factory GenerationIModel.fromJson(Map<String, dynamic> json) =>
      GenerationIModel(
        redBlue: json["red-blue"] == null
            ? null
            : RedBlueModel.fromJson(json["red-blue"]),
        yellow: json["yellow"] == null
            ? null
            : RedBlueModel.fromJson(json["yellow"]),
      );

  Map<String, dynamic> toJson() => {
        "red-blue": redBlue == null ? null : redBlue.toJson(),
        "yellow": yellow == null ? null : yellow.toJson(),
      };
}

class RedBlueModel extends RedBlue {
  RedBlueModel({
    this.backDefault,
    this.backGray,
    this.frontDefault,
    this.frontGray,
  }) : super(
            backDefault: backDefault,
            backGray: backGray,
            frontDefault: frontDefault,
            frontGray: frontGray);

  final String backDefault;
  final String backGray;
  final String frontDefault;
  final String frontGray;

  factory RedBlueModel.fromJson(Map<String, dynamic> json) => RedBlueModel(
        backDefault: json["back_default"] == null ? null : json["back_default"],
        backGray: json["back_gray"] == null ? null : json["back_gray"],
        frontDefault:
            json["front_default"] == null ? null : json["front_default"],
        frontGray: json["front_gray"] == null ? null : json["front_gray"],
      );

  Map<String, dynamic> toJson() => {
        "back_default": backDefault == null ? null : backDefault,
        "back_gray": backGray == null ? null : backGray,
        "front_default": frontDefault == null ? null : frontDefault,
        "front_gray": frontGray == null ? null : frontGray,
      };
}

class GenerationIIModel extends GenerationIi {
  GenerationIIModel({
    this.crystal,
    this.gold,
    this.silver,
  }) : super(crystal: crystal, gold: gold, silver: silver);

  final CrystalModel crystal;
  final CrystalModel gold;
  final CrystalModel silver;

  factory GenerationIIModel.fromJson(Map<String, dynamic> json) =>
      GenerationIIModel(
        crystal: json["crystal"] == null
            ? null
            : CrystalModel.fromJson(json["crystal"]),
        gold: json["gold"] == null ? null : CrystalModel.fromJson(json["gold"]),
        silver: json["silver"] == null
            ? null
            : CrystalModel.fromJson(json["silver"]),
      );

  Map<String, dynamic> toJson() => {
        "crystal": crystal == null ? null : crystal.toJson(),
        "gold": gold == null ? null : gold.toJson(),
        "silver": silver == null ? null : silver.toJson(),
      };
}

class CrystalModel extends Crystal {
  CrystalModel({
    this.backDefault,
    this.backShiny,
    this.frontDefault,
    this.frontShiny,
  }) : super(
            backDefault: backDefault,
            backShiny: backShiny,
            frontDefault: frontDefault,
            frontShiny: frontShiny);

  final String backDefault;
  final String backShiny;
  final String frontDefault;
  final String frontShiny;

  factory CrystalModel.fromJson(Map<String, dynamic> json) => CrystalModel(
        backDefault: json["back_default"] == null ? null : json["back_default"],
        backShiny: json["back_shiny"] == null ? null : json["back_shiny"],
        frontDefault:
            json["front_default"] == null ? null : json["front_default"],
        frontShiny: json["front_shiny"] == null ? null : json["front_shiny"],
      );

  Map<String, dynamic> toJson() => {
        "back_default": backDefault == null ? null : backDefault,
        "back_shiny": backShiny == null ? null : backShiny,
        "front_default": frontDefault == null ? null : frontDefault,
        "front_shiny": frontShiny == null ? null : frontShiny,
      };
}

class GenerationIIIModel extends GenerationIii {
  GenerationIIIModel({
    this.emerald,
    this.fireredLeafgreen,
    this.rubySapphire,
  }) : super(
            emerald: emerald,
            fireredLeafgreen: fireredLeafgreen,
            rubySapphire: rubySapphire);

  final EmeraldModel emerald;
  final CrystalModel fireredLeafgreen;
  final CrystalModel rubySapphire;

  factory GenerationIIIModel.fromJson(Map<String, dynamic> json) =>
      GenerationIIIModel(
        emerald: json["emerald"] == null
            ? null
            : EmeraldModel.fromJson(json["emerald"]),
        fireredLeafgreen: json["firered-leafgreen"] == null
            ? null
            : CrystalModel.fromJson(json["firered-leafgreen"]),
        rubySapphire: json["ruby-sapphire"] == null
            ? null
            : CrystalModel.fromJson(json["ruby-sapphire"]),
      );

  Map<String, dynamic> toJson() => {
        "emerald": emerald == null ? null : emerald.toJson(),
        "firered-leafgreen":
            fireredLeafgreen == null ? null : fireredLeafgreen.toJson(),
        "ruby-sapphire": rubySapphire == null ? null : rubySapphire.toJson(),
      };
}

class EmeraldModel extends Emerald {
  EmeraldModel({
    this.frontDefault,
    this.frontShiny,
  }) : super(frontDefault: frontDefault, frontShiny: frontShiny);

  final String frontDefault;
  final String frontShiny;

  factory EmeraldModel.fromJson(Map<String, dynamic> json) => EmeraldModel(
        frontDefault:
            json["front_default"] == null ? null : json["front_default"],
        frontShiny: json["front_shiny"] == null ? null : json["front_shiny"],
      );

  Map<String, dynamic> toJson() => {
        "front_default": frontDefault == null ? null : frontDefault,
        "front_shiny": frontShiny == null ? null : frontShiny,
      };
}

class GenerationVIModel extends GenerationVi {
  GenerationVIModel({
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  }) : super(
            frontDefault: frontDefault,
            frontFemale: frontFemale,
            frontShiny: frontShiny,
            frontShinyFemale: frontShinyFemale);

  final String frontDefault;
  final dynamic frontFemale;
  final String frontShiny;
  final dynamic frontShinyFemale;

  factory GenerationVIModel.fromJson(Map<String, dynamic> json) =>
      GenerationVIModel(
        frontDefault:
            json["front_default"] == null ? null : json["front_default"],
        frontFemale: json["front_female"],
        frontShiny: json["front_shiny"] == null ? null : json["front_shiny"],
        frontShinyFemale: json["front_shiny_female"],
      );

  Map<String, dynamic> toJson() => {
        "front_default": frontDefault == null ? null : frontDefault,
        "front_female": frontFemale,
        "front_shiny": frontShiny == null ? null : frontShiny,
        "front_shiny_female": frontShinyFemale,
      };
}

class GenerationVIIModel extends GenerationVii {
  GenerationVIIModel({
    this.icons,
    this.ultraSunUltraMoon,
  }) : super(icons: icons, ultraSunUltraMoon: ultraSunUltraMoon);

  final DreamWorldModel icons;
  final GenerationVIModel ultraSunUltraMoon;

  factory GenerationVIIModel.fromJson(Map<String, dynamic> json) =>
      GenerationVIIModel(
        icons: json["icons"] == null
            ? null
            : DreamWorldModel.fromJson(json["icons"]),
        ultraSunUltraMoon: json["ultra-sun-ultra-moon"] == null
            ? null
            : GenerationVIModel.fromJson(json["ultra-sun-ultra-moon"]),
      );

  Map<String, dynamic> toJson() => {
        "icons": icons == null ? null : icons.toJson(),
        "ultra-sun-ultra-moon":
            ultraSunUltraMoon == null ? null : ultraSunUltraMoon.toJson(),
      };
}

class DreamWorldModel extends DreamWorld {
  DreamWorldModel({
    this.frontDefault,
    this.frontFemale,
  }) : super(frontDefault: frontDefault, frontFemale: frontFemale);

  final String frontDefault;
  final dynamic frontFemale;

  factory DreamWorldModel.fromJson(Map<String, dynamic> json) =>
      DreamWorldModel(
        frontDefault:
            json["front_default"] == null ? null : json["front_default"],
        frontFemale: json["front_female"],
      );

  Map<String, dynamic> toJson() => {
        "front_default": frontDefault == null ? null : frontDefault,
        "front_female": frontFemale,
      };
}

class GenerationVIIIModel extends GenerationViii {
  GenerationVIIIModel({
    this.icons,
  }) : super(icons: icons);

  final DreamWorldModel icons;

  factory GenerationVIIIModel.fromJson(Map<String, dynamic> json) =>
      GenerationVIIIModel(
        icons: json["icons"] == null
            ? null
            : DreamWorldModel.fromJson(json["icons"]),
      );

  Map<String, dynamic> toJson() => {
        "icons": icons == null ? null : icons.toJson(),
      };
}

class OtherModel extends Other {
  OtherModel({
    this.dreamWorld,
    this.officialArtwork,
  }) : super(dreamWorld: dreamWorld, officialArtwork: officialArtwork);

  final DreamWorldModel dreamWorld;
  final OfficialArtworkModel officialArtwork;

  factory OtherModel.fromJson(Map<String, dynamic> json) => OtherModel(
        dreamWorld: json["dream_world"] == null
            ? null
            : DreamWorldModel.fromJson(json["dream_world"]),
        officialArtwork: json["official-artwork"] == null
            ? null
            : OfficialArtworkModel.fromJson(json["official-artwork"]),
      );

  Map<String, dynamic> toJson() => {
        "dream_world": dreamWorld == null ? null : dreamWorld.toJson(),
        "official-artwork":
            officialArtwork == null ? null : officialArtwork.toJson(),
      };
}

class OfficialArtworkModel extends OfficialArtwork {
  OfficialArtworkModel({
    this.frontDefault,
  }) : super(frontDefault: frontDefault);

  final String frontDefault;

  factory OfficialArtworkModel.fromJson(Map<String, dynamic> json) =>
      OfficialArtworkModel(
        frontDefault:
            json["front_default"] == null ? null : json["front_default"],
      );

  Map<String, dynamic> toJson() => {
        "front_default": frontDefault == null ? null : frontDefault,
      };
}

class StatModel extends Stat {
  StatModel({
    this.baseStat,
    this.effort,
    this.stat,
  }) : super(baseStat: baseStat, effort: effort, stat: stat);

  final int baseStat;
  final int effort;
  final ResourcePathModel stat;

  factory StatModel.fromJson(Map<String, dynamic> json) => StatModel(
        baseStat: json["base_stat"] == null ? null : json["base_stat"],
        effort: json["effort"] == null ? null : json["effort"],
        stat: json["stat"] == null
            ? null
            : ResourcePathModel.fromJson(json["stat"]),
      );

  Map<String, dynamic> toJson() => {
        "base_stat": baseStat == null ? null : baseStat,
        "effort": effort == null ? null : effort,
        "stat": stat == null ? null : stat.toJson(),
      };
}

class TypeModel extends Type {
  TypeModel({
    this.slot,
    this.type,
  }) : super(slot: slot, type: type);

  final int slot;
  final ResourcePathModel type;

  factory TypeModel.fromJson(Map<String, dynamic> json) => TypeModel(
        slot: json["slot"] == null ? null : json["slot"],
        type: json["type"] == null
            ? null
            : ResourcePathModel.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "slot": slot == null ? null : slot,
        "type": type == null ? null : type.toJson(),
      };
}
