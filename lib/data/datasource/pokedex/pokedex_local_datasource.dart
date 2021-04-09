import 'package:hive/hive.dart';
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_page_response_model.dart';

abstract class PokedexLocalDataSource {
  /// Gets the cached [PokedexPageResponseModel] wich was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheDataException] if no cached data is present
  Future<PokedexPageResponseModel> getCachedPokemonPage(int offset);

  /// Store the pokemon page as a String into a Box using Hive
  Future<void> cachePokemonPage(
      int key, PokedexPageResponseModel pokemonPaginatedResponseModel);
}

class PokedexLocalDataSourceImpl implements PokedexLocalDataSource {
  final Box pokedexEntriesBox;

  PokedexLocalDataSourceImpl(this.pokedexEntriesBox);

  @override
  Future<PokedexPageResponseModel> getCachedPokemonPage(int offset) {
    final jsonString = pokedexEntriesBox.get(offset);
    if (jsonString != null) {
      return Future.value(pokedexPageResponseModelFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cachePokemonPage(
      int key, PokedexPageResponseModel pokemonPaginatedResponseModel) {
    pokedexEntriesBox.put(
        key, pokedexPageResponseModelToJson(pokemonPaginatedResponseModel));
    return Future.value(true);
  }
}
