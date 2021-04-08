import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokedex_page_response.dart';

abstract class PokedexRepository {
  Future<Either<Failure, PokedexPageResponse>> getPaginatedPokemonList({
    @required int limit,
    @required int offset,
  });
}
