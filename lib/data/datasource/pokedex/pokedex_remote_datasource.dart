import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_page_response_model.dart';

abstract class PokedexRemoteDataSource {
  Future<PokedexPageResponseModel> getPaginatedPokemonList(
      {int limit, int offset});
}

class PokedexRemoteDataSourceImpl implements PokedexRemoteDataSource {
  final http.Client client;

  PokedexRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<PokedexPageResponseModel> getPaginatedPokemonList(
      {int limit, int offset}) async {
    final response = await client.get(
      'https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=$offset',
    );

    if (response.statusCode == 200) {
      return pokedexPageResponseModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
