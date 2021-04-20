import 'package:equatable/equatable.dart';

class EvolutionChainResponse extends Equatable {
  EvolutionChainResponse({
    this.babyTriggerItem,
    this.chain,
    this.id,
  });

  final dynamic babyTriggerItem;
  final Chain chain;
  final int id;

  @override
  List<Object> get props => [babyTriggerItem, chain, id];
}

class Chain extends Equatable {
  Chain({
    this.evolutionDetails,
    this.evolvesTo,
    this.isBaby,
    this.species,
  });

  final List<EvolutionDetail> evolutionDetails;
  final List<Chain> evolvesTo;
  final bool isBaby;
  final Species species;

  @override
  List<Object> get props => [evolutionDetails, evolvesTo, isBaby, species];
}

class EvolutionDetail extends Equatable {
  EvolutionDetail({
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
  });

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
  final Species trigger;
  final bool turnUpsideDown;

  @override
  List<Object> get props => [
        gender,
        heldItem,
        item,
        knownMove,
        knownMoveType,
        location,
        minAffection,
        minBeauty,
        minHappiness,
        minLevel,
        needsOverworldRain,
        partySpecies,
        relativePhysicalStats,
        timeOfDay,
        tradeSpecies,
        trigger,
        turnUpsideDown,
      ];
}

class Species extends Equatable {
  Species({
    this.name,
    this.url,
  });

  final String name;
  final String url;

  @override
  List<Object> get props => [name, url];
}
