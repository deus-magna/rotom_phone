import 'package:flutter_test/flutter_test.dart';
import 'package:rotom_phone/data/model/pokemon/pokedex_entry_model.dart';
import 'package:rotom_phone/data/model/pokemon/pokemon_paginated_response_model.dart';

void main() {
  /// Mock de la entrada del pokedex
  final tPokedexEntry = PokedexEntryModel(
      name: 'bulbasaur',
      id: 1,
      url: 'https://pokeapi.co/api/v2/pokemon/1/',
      officialArtwork:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png');

  test('Deberia crear un PokedexEntry desde un Result', () {
    final ResultModel tResult = ResultModel(
        name: 'bulbasaur', url: 'https://pokeapi.co/api/v2/pokemon/1/');
    final result = pokedexEntryFromResult(tResult);
    expect(result, tPokedexEntry);
  });

  test('Deberia regresar un String con 00+Id si el id del pokemon es < 10', () {
    final ResultModel tResult = ResultModel(
        name: 'bulbasaur', url: 'https://pokeapi.co/api/v2/pokemon/1/');
    final result = pokedexEntryFromResult(tResult);
    final id = result.getPokemonId();
    expect(id, '001');
  });

  test('Deberia regresar un String con 0+Id si el id del pokemon es < 100', () {
    final ResultModel tResult = ResultModel(
        name: 'pidgeot', url: 'https://pokeapi.co/api/v2/pokemon/18/');
    final result = pokedexEntryFromResult(tResult);
    final id = result.getPokemonId();
    expect(id, '018');
  });

  test('Deberia regresar un String con Id si el id del pokemon es = 100', () {
    final ResultModel tResult = ResultModel(
        name: 'voltorb', url: 'https://pokeapi.co/api/v2/pokemon/100/');
    final result = pokedexEntryFromResult(tResult);
    final id = result.getPokemonId();
    expect(id, '100');
  });

  test('Deberia regresar un String con Id si el id del pokemon es > 100', () {
    final ResultModel tResult = ResultModel(
        name: 'mewtwo', url: 'https://pokeapi.co/api/v2/pokemon/150/');
    final result = pokedexEntryFromResult(tResult);
    final id = result.getPokemonId();
    expect(id, '150');
  });
}
