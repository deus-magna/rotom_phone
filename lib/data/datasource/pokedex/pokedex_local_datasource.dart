import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_specie_model.dart';
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

  Future<PokemonSpecieModel> getCachedPokemonDetail(int entryNumber);

  Future<void> cachePokemonDetail(PokemonSpecieModel pokemonDetailModel);
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
  Future<void> cacheRegionalPokedex(PokedexModel pokedexModel) async {
    await regionalPokedexBox.put(
        pokedexModel.id, pokedexModelToJson(pokedexModel));
    return Future.value(true);
  }

  @override
  Future<void> cachePokemonDetail(PokemonSpecieModel pokemonDetailModel) async {
    await pokemonDetailBox.put(
        pokemonDetailModel.id, pokemonSpecieModelToJson(pokemonDetailModel));
    return Future.value(true);
  }

  @override
  Future<PokemonSpecieModel> getCachedPokemonDetail(int entryNumber) {
    final jsonString = pokemonDetailBox.get(entryNumber);
    if (jsonString != null) {
      return Future.value(pokemonSpecieModelFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }
}
