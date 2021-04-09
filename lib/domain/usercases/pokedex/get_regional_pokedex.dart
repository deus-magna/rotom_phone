import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokedex.dart';
import 'package:rotom_phone/domain/repositories/pokedex_repository.dart';

class GetRegionalPokedex {
  final PokedexRepository pokedexRepository;

  GetRegionalPokedex(this.pokedexRepository)
      : assert(pokedexRepository != null);

  Future<Either<Failure, Pokedex>> call({
    @required int region,
  }) async {
    return pokedexRepository.getRegionalPokedex(region: region);
  }
}
