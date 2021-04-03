import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/model/pokemon/pokemon_paginated_response_model.dart';

abstract class PokemonRemoteDataSource {
  Future<PokemonPaginatedResponseModel> getPaginatedPokemonList(
      {int limit, int offset});
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client client;

  PokemonRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<PokemonPaginatedResponseModel> getPaginatedPokemonList(
      {int limit, int offset}) async {
    final response = await client.get(
      'https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=$offset',
    );

    if (response.statusCode == 200) {
      return pokemonPaginatedResponseModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
