import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/model/pokedex/evolution_chain_response_model.dart';
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

  Future<EvolutionChainResponseModel> getCachedEvolutionChain(
      String evolutionChainId);

  Future<void> cacheEvolutionChain(EvolutionChainResponseModel evolutionChain);
}

class PokedexLocalDataSourceImpl implements PokedexLocalDataSource {
  final PokedexBox regionalPokedexBox;
  final PokemonSpecieBox pokemonSpecieBox;
  final PokemonInfoBox pokemonInfoBox;
  final EvolutionChainBox evolutionChainBox;

  PokedexLocalDataSourceImpl(
    this.regionalPokedexBox,
    this.pokemonSpecieBox,
    this.pokemonInfoBox,
    this.evolutionChainBox,
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
    await pokemonSpecieBox.put(
        pokemonModel.specie.id, pokemonSpecieModelToJson(pokemonModel.specie));

    await pokemonInfoBox.put(
        pokemonModel.info.id, pokemonInfoModelToJson(pokemonModel.info));
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

  @override
  Future<void> cacheEvolutionChain(
      EvolutionChainResponseModel evolutionChain) async {
    await evolutionChainBox.put(
        evolutionChain.id, evolutionChainResponseModelToJson(evolutionChain));

    return Future.value(true);
  }

  @override
  Future<EvolutionChainResponseModel> getCachedEvolutionChain(
      String evolutionChainId) {
    final jsonString = evolutionChainBox.get(evolutionChainId);
    if (jsonString != null) {
      return Future.value(evolutionChainResponseModelFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }
}
