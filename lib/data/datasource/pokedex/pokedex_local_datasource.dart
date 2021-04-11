import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_info_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_model.dart';
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

  Future<PokemonModel> getCachedPokemonDetail(int entryNumber);

  Future<void> cachePokemonDetail(PokemonModel pokemonModel);
}

class PokedexLocalDataSourceImpl implements PokedexLocalDataSource {
  final PokedexBox regionalPokedexBox;
  final PokemonSpecieBox pokemonSpecieBox;
  final PokemonInfoBox pokemonInfoBox;

  PokedexLocalDataSourceImpl(
    this.regionalPokedexBox,
    this.pokemonSpecieBox,
    this.pokemonInfoBox,
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
  Future<void> cachePokemonDetail(PokemonModel pokemonModel) async {
    await pokemonSpecieBox.put(pokemonModel.pokemonSpecie.id,
        pokemonSpecieModelToJson(pokemonModel.pokemonSpecie));
    await pokemonInfoBox.put(pokemonModel.pokemonInfo.id,
        pokemonInfoModelToJson(pokemonModel.pokemonInfo));
    return Future.value(true);
  }

  @override
  Future<PokemonModel> getCachedPokemonDetail(int entryNumber) {
    final specieString = pokemonSpecieBox.get(entryNumber);
    final infoString = pokemonInfoBox.get(entryNumber);
    if (specieString != null && infoString != null) {
      final pokemonModel = PokemonModel(pokemonInfoModelFromJson(infoString),
          pokemonSpecieModelFromJson(specieString));
      return Future.value(pokemonModel);
    } else {
      throw CacheException();
    }
  }
}
