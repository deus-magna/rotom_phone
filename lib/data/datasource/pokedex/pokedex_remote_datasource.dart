import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/model/pokedex/evolution_chain_response_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_info_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_specie_model.dart';

abstract class PokedexRemoteDataSource {
  Future<PokedexModel> getRegionalPokedex({int region});
  Future<PokemonModel> getPokemonDetails({int entryNumber});
  Future<EvolutionChainResponseModel> getEvolutionChain(
      {String evolutionChain});
}

class PokedexRemoteDataSourceImpl implements PokedexRemoteDataSource {
  final http.Client client;

  PokedexRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<PokedexModel> getRegionalPokedex({int region}) async {
    final response =
        await _getFromServer('https://pokeapi.co/api/v2/pokedex/$region');

    return pokedexModelFromJson(response.body);
  }

  @override
  Future<PokemonModel> getPokemonDetails({int entryNumber}) async {
    final pokemonSpecie = await _getPokemonSpecie(entryNumber);
    final pokemonInfo = await _getPokemonInfo(entryNumber);
    return PokemonModel(pokemonInfo, pokemonSpecie);
  }

  Future<PokemonSpecieModel> _getPokemonSpecie(int entryNumber) async {
    final response = await _getFromServer(
        'https://pokeapi.co/api/v2/pokemon-species/$entryNumber/');
    return pokemonSpecieModelFromJson(response.body);
  }

  Future<PokemonInfoModel> _getPokemonInfo(int entryNumber) async {
    final response =
        await _getFromServer('https://pokeapi.co/api/v2/pokemon/$entryNumber/');
    return pokemonInfoModelFromJson(response.body);
  }

  Future<http.Response> _getFromServer(String url) async {
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<EvolutionChainResponseModel> getEvolutionChain(
      {String evolutionChain}) async {
    final response = await _getFromServer(evolutionChain);
    return evolutionChainResponseModelFromJson(response.body);
  }
}
