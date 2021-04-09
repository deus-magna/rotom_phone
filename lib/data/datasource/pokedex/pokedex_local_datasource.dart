import 'package:hive/hive.dart';
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_model.dart';

abstract class PokedexLocalDataSource {
  /// Gets the cached [PokedexModel] wich was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheDataException] if no cached data is present
  Future<PokedexModel> getCachedRegionalPokedex(int offset);

  /// Store the pokemon page as a String into a Box using Hive
  Future<void> cacheRegionalPokedex(int key, PokedexModel pokedexModel);
}

class PokedexLocalDataSourceImpl implements PokedexLocalDataSource {
  final Box pokedexEntriesBox;

  PokedexLocalDataSourceImpl(this.pokedexEntriesBox);

  @override
  Future<PokedexModel> getCachedRegionalPokedex(int offset) {
    final jsonString = pokedexEntriesBox.get(offset);
    if (jsonString != null) {
      return Future.value(pokedexModelFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheRegionalPokedex(int key, PokedexModel pokedexModel) {
    pokedexEntriesBox.put(key, pokedexModelToJson(pokedexModel));
    return Future.value(true);
  }
}
