import 'package:hive/hive.dart';
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_detail_model.dart';

abstract class PokedexLocalDataSource {
  /// Gets the cached [PokedexModel] wich was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheDataException] if no cached data is present
  Future<PokedexModel> getCachedRegionalPokedex(int offset);

  /// Store the pokemon page as a String into a Box using Hive
  Future<void> cacheRegionalPokedex(int key, PokedexModel pokedexModel);

  Future<PokemonDetailModel> getPokemonDetail(int entryNumber);

  Future<void> cachePokemonDetail(PokemonDetailModel pokemonSpeciesModel);
}

class PokedexLocalDataSourceImpl implements PokedexLocalDataSource {
  final Box regionalPokedexBox;
  final Box pokemonDetailBox;

  PokedexLocalDataSourceImpl(
    this.regionalPokedexBox,
    this.pokemonDetailBox,
  );

  @override
  Future<PokedexModel> getCachedRegionalPokedex(int offset) {
    final jsonString = regionalPokedexBox.get(offset);
    if (jsonString != null) {
      return Future.value(pokedexModelFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheRegionalPokedex(int key, PokedexModel pokedexModel) {
    regionalPokedexBox.put(key, pokedexModelToJson(pokedexModel));
    return Future.value(true);
  }

  @override
  Future<void> cachePokemonDetail(PokemonDetailModel pokemonSpeciesModel) {
    // TODO: implement cachePokemonDetail
    throw UnimplementedError();
  }

  @override
  Future<PokemonDetailModel> getPokemonDetail(int entryNumber) {
    // TODO: implement getPokemonDetail
    throw UnimplementedError();
  }
}
