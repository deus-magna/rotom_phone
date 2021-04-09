import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_detail_model.dart';

abstract class PokedexRemoteDataSource {
  Future<PokedexModel> getRegionalPokedex({int region});
  Future<PokemonDetailModel> getPokemonDetail({int entryNumber});
}

class PokedexRemoteDataSourceImpl implements PokedexRemoteDataSource {
  final http.Client client;

  PokedexRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<PokedexModel> getRegionalPokedex({int region}) async {
    final response =
        await getFromServer('https://pokeapi.co/api/v2/pokedex/$region');

    return pokedexModelFromJson(response.body);
  }

  @override
  Future<PokemonDetailModel> getPokemonDetail({int entryNumber}) async {
    final response = await getFromServer(
        'https://pokeapi.co/api/v2/pokemon-species/$entryNumber/');
    return pokemonDetailModelFromJson(response.body);
  }

  Future<http.Response> getFromServer(String url) async {
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw ServerException();
    }
  }
}
