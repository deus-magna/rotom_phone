import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/domain/entities/pokedex/evolution_chain_response.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokedex.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';

abstract class PokedexRepository {
  Future<Either<Failure, Pokedex>> getRegionalPokedex({@required int region});
  Future<Either<Failure, Pokemon>> getPokemonDetails(
      {@required int entryNumber});

  Future<Either<Failure, EvolutionChainResponse>> getEvolutionChain(
      {@required String evolutionChain});
}
