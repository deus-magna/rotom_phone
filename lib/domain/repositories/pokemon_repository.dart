import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/domain/entities/pokemon/pokemon_paginated_response.dart';

abstract class PokemonRepository {
  Future<Either<Failure, PokemonPaginatedResponse>> getPaginatedPokemonList({
    @required int limit,
    @required int offset,
  });
}
