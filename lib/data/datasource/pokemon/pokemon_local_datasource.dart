import 'package:hive/hive.dart';
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/model/pokemon/pokemon_paginated_response_model.dart';

abstract class PokemonLocalDataSource {
  /// Gets the cached [PokemonPaginatedResponseModel] wich was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheDataException] if no cached data is present
  Future<PokemonPaginatedResponseModel> getCachedPokemonPage(int offset);

  Future<void> cachePokemonPage(
      int key, PokemonPaginatedResponseModel pokemonPaginatedResponseModel);
}

class PokemonLocalDataSourceImpl implements PokemonLocalDataSource {
  final Box pokedexEntriesBox;

  PokemonLocalDataSourceImpl(this.pokedexEntriesBox);

  @override
  Future<PokemonPaginatedResponseModel> getCachedPokemonPage(int offset) {
    final jsonString = pokedexEntriesBox.get(offset);
    if (jsonString != null) {
      return Future.value(pokemonPaginatedResponseModelFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cachePokemonPage(
      int key, PokemonPaginatedResponseModel pokemonPaginatedResponseModel) {
    pokedexEntriesBox.put(key,
        pokemonPaginatedResponseModelToJson(pokemonPaginatedResponseModel));
    return Future.value(true);
  }
}
