import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokedex_page_response.dart';
import 'package:rotom_phone/domain/repositories/pokedex_repository.dart';

class GetPokedexPage {
  final PokedexRepository pokemonRepository;

  GetPokedexPage(this.pokemonRepository) : assert(pokemonRepository != null);

  Future<Either<Failure, PokedexPageResponse>> call({
    @required int limit,
    @required int offset,
  }) async {
    return pokemonRepository.getPaginatedPokemonList(
        limit: limit, offset: offset);
  }
}
