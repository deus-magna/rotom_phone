import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/domain/entities/pokedex/evolution_chain_response.dart';
import 'package:rotom_phone/domain/repositories/pokedex_repository.dart';

class GetEvolutionChain {
  final PokedexRepository pokedexRepository;

  GetEvolutionChain(this.pokedexRepository) : assert(pokedexRepository != null);

  Future<Either<Failure, EvolutionChainResponse>> call({
    @required String evolutionChain,
  }) async {
    return pokedexRepository.getEvolutionChain(evolutionChain: evolutionChain);
  }
}
