import 'package:flutter_test/flutter_test.dart';
import 'package:rotom_phone/core/utils/enums.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_info_model.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_info.dart';

import '../../../fixtures/fixture_reader.dart';

main() {
  final PokemonInfo tPokemonInfo =
      pokemonInfoModelFromJson(fixture('pokemon_info.json'));
  test('Should return the correct types for Bulbasaur', () {
    final types = tPokemonInfo.getTypes;
    expect(types.length, 2);
    expect(types[0].name, 'grass');
    expect(types[1].name, 'poison');
  });

  test('Should return the pokemon Weight', () {
    expect(tPokemonInfo.getWeight, 6.9);
  });

  test('Should return the pokemon Height', () {
    expect(tPokemonInfo.getHeight, 0.7);
  });

  test('Should return the pokemon abilities names', () {
    expect(tPokemonInfo.abilities[0].name, 'Overgrow');
    expect(tPokemonInfo.abilities[1].name, 'Chlorophyll');
  });

  test('Should return the pokemon moves', () {
    expect(
        tPokemonInfo.getMovesByLearnMethod(MoveLearnMethodType.LEVEL_UP, 'x-y'),
        isA<List<Move>>());
  });
}
