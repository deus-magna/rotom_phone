import 'dart:convert';

import 'package:rotom_phone/domain/entities/pokedex/evolution_chain_response.dart';

EvolutionChainResponseModel evolutionChainResponseModelFromJson(String str) =>
    EvolutionChainResponseModel.fromJson(json.decode(str));

String evolutionChainResponseModelToJson(EvolutionChainResponseModel data) =>
    json.encode(data.toJson());

class EvolutionChainResponseModel extends EvolutionChainResponse {
  EvolutionChainResponseModel({
    this.babyTriggerItem,
    this.chain,
    this.id,
  }) : super(
          babyTriggerItem: babyTriggerItem,
          chain: chain,
          id: id,
        );

  final dynamic babyTriggerItem;
  final ChainModel chain;
  final int id;

  factory EvolutionChainResponseModel.fromJson(Map<String, dynamic> json) =>
      EvolutionChainResponseModel(
        babyTriggerItem: json["baby_trigger_item"],
        chain:
            json["chain"] == null ? null : ChainModel.fromJson(json["chain"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "baby_trigger_item": babyTriggerItem,
        "chain": chain == null ? null : chain.toJson(),
        "id": id == null ? null : id,
      };
}

class ChainModel extends Chain {
  ChainModel({
    this.evolutionDetails,
    this.evolvesTo,
    this.isBaby,
    this.species,
  }) : super(
          evolutionDetails: evolutionDetails,
          evolvesTo: evolvesTo,
          isBaby: isBaby,
          species: species,
        );

  final List<EvolutionDetailModel> evolutionDetails;
  final List<ChainModel> evolvesTo;
  final bool isBaby;
  final SpeciesModel species;

  factory ChainModel.fromJson(Map<String, dynamic> json) => ChainModel(
        evolutionDetails: json["evolution_details"] == null
            ? null
            : List<EvolutionDetail>.from(json["evolution_details"]
                .map((x) => EvolutionDetailModel.fromJson(x))),
        evolvesTo: json["evolves_to"] == null
            ? null
            : List<Chain>.from(
                json["evolves_to"].map((x) => ChainModel.fromJson(x))),
        isBaby: json["is_baby"] == null ? null : json["is_baby"],
        species: json["species"] == null
            ? null
            : SpeciesModel.fromJson(json["species"]),
      );

  Map<String, dynamic> toJson() => {
        "evolution_details": evolutionDetails == null
            ? null
            : List<dynamic>.from(evolutionDetails.map((x) => x.toJson())),
        "evolves_to": evolvesTo == null
            ? null
            : List<dynamic>.from(evolvesTo.map((x) => x.toJson())),
        "is_baby": isBaby == null ? null : isBaby,
        "species": species == null ? null : species.toJson(),
      };
}

class EvolutionDetailModel extends EvolutionDetail {
  EvolutionDetailModel({
    this.gender,
    this.heldItem,
    this.item,
    this.knownMove,
    this.knownMoveType,
    this.location,
    this.minAffection,
    this.minBeauty,
    this.minHappiness,
    this.minLevel,
    this.needsOverworldRain,
    this.partySpecies,
    this.partyType,
    this.relativePhysicalStats,
    this.timeOfDay,
    this.tradeSpecies,
    this.trigger,
    this.turnUpsideDown,
  }) : super(
          gender: gender,
          heldItem: heldItem,
          item: item,
          knownMove: knownMove,
          knownMoveType: knownMoveType,
          location: location,
          minAffection: minAffection,
          minBeauty: minBeauty,
          minHappiness: minHappiness,
          minLevel: minLevel,
          needsOverworldRain: needsOverworldRain,
          partySpecies: partySpecies,
          partyType: partyType,
          relativePhysicalStats: relativePhysicalStats,
          timeOfDay: timeOfDay,
          tradeSpecies: tradeSpecies,
          trigger: trigger,
          turnUpsideDown: turnUpsideDown,
        );

  final dynamic gender;
  final dynamic heldItem;
  final dynamic item;
  final dynamic knownMove;
  final dynamic knownMoveType;
  final dynamic location;
  final dynamic minAffection;
  final dynamic minBeauty;
  final dynamic minHappiness;
  final int minLevel;
  final bool needsOverworldRain;
  final dynamic partySpecies;
  final dynamic partyType;
  final dynamic relativePhysicalStats;
  final String timeOfDay;
  final dynamic tradeSpecies;
  final SpeciesModel trigger;
  final bool turnUpsideDown;

  factory EvolutionDetailModel.fromJson(Map<String, dynamic> json) =>
      EvolutionDetailModel(
        gender: json["gender"],
        heldItem: json["held_item"],
        item: json["item"],
        knownMove: json["known_move"],
        knownMoveType: json["known_move_type"],
        location: json["location"],
        minAffection: json["min_affection"],
        minBeauty: json["min_beauty"],
        minHappiness: json["min_happiness"],
        minLevel: json["min_level"] == null ? null : json["min_level"],
        needsOverworldRain: json["needs_overworld_rain"] == null
            ? null
            : json["needs_overworld_rain"],
        partySpecies: json["party_species"],
        partyType: json["party_type"],
        relativePhysicalStats: json["relative_physical_stats"],
        timeOfDay: json["time_of_day"] == null ? null : json["time_of_day"],
        tradeSpecies: json["trade_species"],
        trigger: json["trigger"] == null
            ? null
            : SpeciesModel.fromJson(json["trigger"]),
        turnUpsideDown:
            json["turn_upside_down"] == null ? null : json["turn_upside_down"],
      );

  Map<String, dynamic> toJson() => {
        "gender": gender,
        "held_item": heldItem,
        "item": item,
        "known_move": knownMove,
        "known_move_type": knownMoveType,
        "location": location,
        "min_affection": minAffection,
        "min_beauty": minBeauty,
        "min_happiness": minHappiness,
        "min_level": minLevel == null ? null : minLevel,
        "needs_overworld_rain":
            needsOverworldRain == null ? null : needsOverworldRain,
        "party_species": partySpecies,
        "party_type": partyType,
        "relative_physical_stats": relativePhysicalStats,
        "time_of_day": timeOfDay == null ? null : timeOfDay,
        "trade_species": tradeSpecies,
        "trigger": trigger == null ? null : trigger.toJson(),
        "turn_upside_down": turnUpsideDown == null ? null : turnUpsideDown,
      };
}

class SpeciesModel extends Species {
  SpeciesModel({
    this.name,
    this.url,
  }) : super(name: name, url: url);

  final String name;
  final String url;

  factory SpeciesModel.fromJson(Map<String, dynamic> json) => SpeciesModel(
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "url": url == null ? null : url,
      };
}
