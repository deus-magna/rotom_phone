import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_detail_model.dart';
import 'package:rotom_phone/domain/entities/hive_boxes.dart';

abstract class PokedexLocalDataSource {
  /// Gets the cached [PokedexModel] wich was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheDataException] if no cached data is present
  Future<PokedexModel> getCachedRegionalPokedex(int offset);

  /// Store the pokedex as a String into a Box using Hive, use [PokedexModel.id]
  /// as the key for the Hive Box
  Future<void> cacheRegionalPokedex(PokedexModel pokedexModel);

  Future<PokemonDetailModel> getPokemonDetail(int entryNumber);

  Future<void> cachePokemonDetail(PokemonDetailModel pokemonSpeciesModel);
}

class PokedexLocalDataSourceImpl implements PokedexLocalDataSource {
  final PokedexBox regionalPokedexBox;
  final PokemonDetailBox pokemonDetailBox;

  PokedexLocalDataSourceImpl(
    this.regionalPokedexBox,
    this.pokemonDetailBox,
  );

  @override
  Future<PokedexModel> getCachedRegionalPokedex(int region) {
    final jsonString = regionalPokedexBox.get(region);
    if (jsonString != null) {
      return Future.value(pokedexModelFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheRegionalPokedex(PokedexModel pokedexModel) {
    regionalPokedexBox.put(pokedexModel.id, pokedexModelToJson(pokedexModel));
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
