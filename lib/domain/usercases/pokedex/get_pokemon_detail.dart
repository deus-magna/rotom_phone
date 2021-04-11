import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';
import 'package:rotom_phone/domain/repositories/pokedex_repository.dart';

class GetPokemonDetails {
  final PokedexRepository pokedexRepository;

  GetPokemonDetails(this.pokedexRepository) : assert(pokedexRepository != null);

  Future<Either<Failure, Pokemon>> call({
    @required int entryNumber,
  }) async {
    return pokedexRepository.getPokemonDetails(entryNumber: entryNumber);
  }
}
