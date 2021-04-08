import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/domain/entities/pokemon/pokemon_paginated_response.dart';
import 'package:rotom_phone/domain/repositories/pokemon_repository.dart';

class GetPokedexPage {
  final PokemonRepository pokemonRepository;

  GetPokedexPage(this.pokemonRepository) : assert(pokemonRepository != null);

  Future<Either<Failure, PokemonPaginatedResponse>> call({
    @required int limit,
    @required int offset,
  }) async {
    return pokemonRepository.getPaginatedPokemonList(
        limit: limit, offset: offset);
  }
}
