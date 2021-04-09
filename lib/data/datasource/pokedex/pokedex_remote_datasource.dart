import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_model.dart';

abstract class PokedexRemoteDataSource {
  Future<PokedexModel> getRegionalPokedex({int region});
}

class PokedexRemoteDataSourceImpl implements PokedexRemoteDataSource {
  final http.Client client;

  PokedexRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<PokedexModel> getRegionalPokedex({int region}) async {
    final response = await client.get(
      'https://pokeapi.co/api/v2/pokedex/$region',
    );

    if (response.statusCode == 200) {
      return pokedexModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
