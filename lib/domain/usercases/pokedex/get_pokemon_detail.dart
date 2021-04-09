import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_detail.dart';
import 'package:rotom_phone/domain/repositories/pokedex_repository.dart';

class GetPokemonDetail {
  final PokedexRepository pokedexRepository;

  GetPokemonDetail(this.pokedexRepository) : assert(pokedexRepository != null);

  Future<Either<Failure, PokemonDetail>> call({
    @required int entryNumber,
  }) async {
    return pokedexRepository.getPokemonDetail(entryNumber: entryNumber);
  }
}
