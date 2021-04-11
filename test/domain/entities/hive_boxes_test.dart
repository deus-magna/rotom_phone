import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/domain/entities/hive_boxes.dart';

import '../../fixtures/fixture_reader.dart';

class MockBox extends Mock implements Box<String> {}

void main() {
  PokedexBox pokedexBox;
  PokemonSpecieBox pokemonDetailBox;
  MockBox mockBox;

  setUp(() {
    mockBox = MockBox();
    pokedexBox = PokedexBox(mockBox);
    pokemonDetailBox = PokemonSpecieBox(mockBox);
  });

  group('PokedexBox', () {
    test('Should call MockBox.get', () {
      final int key = 1;
      // arrange
      when(mockBox.get(any)).thenReturn(fixture('pokedex.json'));
      // act
      final result = pokedexBox.get(key);
      // assert
      verify(mockBox.get(key));
      expect(result, fixture('pokedex.json'));
    });

    test('Should call MockBox.put', () async {
      final int key = 1;
      // act
      await pokedexBox.put(key, fixture('pokedex.json'));
      // assert
      verify(mockBox.put(key, fixture('pokedex.json')));
    });
  });

  group('PokemonDetailBox', () {
    test('Should call MockBox.get', () {
      final int key = 1;
      // arrange
      when(pokemonDetailBox.get(any))
          .thenReturn(fixture('pokemon_specie.json'));
      // act
      final result = pokemonDetailBox.get(key);
      // assert
      verify(pokemonDetailBox.get(key));
      expect(result, fixture('pokemon_specie.json'));
    });

    test('Should call MockBox.put', () async {
      final int key = 1;
      // act
      await pokemonDetailBox.put(key, fixture('pokemon_specie.json'));
      // assert
      verify(pokemonDetailBox.put(key, fixture('pokemon_specie.json')));
    });
  });
}
