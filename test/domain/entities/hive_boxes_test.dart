import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/domain/entities/hive_boxes.dart';

import '../../fixtures/fixture_reader.dart';

class MockBox extends Mock implements Box<String> {}

void main() {
  PokedexBox pokedexBox;
  PokemonSpecieBox pokemonDetailBox;
  EvolutionChainBox evolutionChainBox;
  MockBox mockBox;

  setUp(() {
    mockBox = MockBox();
    pokedexBox = PokedexBox(mockBox);
    pokemonDetailBox = PokemonSpecieBox(mockBox);
    evolutionChainBox = EvolutionChainBox(mockBox);
  });

  group('PokedexBox', () {
    test('Should call MockBox.get', () {
      const key = 1;
      // arrange
      when(mockBox.get(any)).thenReturn(fixture('pokedex.json'));
      // act
      final result = pokedexBox.get(key);
      // assert
      verify(mockBox.get(key));
      expect(result, fixture('pokedex.json'));
    });

    test('Should call MockBox.put', () async {
      const key = 1;
      // act
      await pokedexBox.put(key, fixture('pokedex.json'));
      // assert
      verify(mockBox.put(key, fixture('pokedex.json')));
    });
  });

  group('PokemonDetailBox', () {
    test('Should call MockBox.get', () {
      const key = 1;
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
      const key = 1;
      // act
      await pokemonDetailBox.put(key, fixture('pokemon_specie.json'));
      // assert
      verify(pokemonDetailBox.put(key, fixture('pokemon_specie.json')));
    });
  });

  group('EvolutionChainBox', () {
    test('Should call MockBox.get', () {
      const key = 1;
      // arrange
      when(evolutionChainBox.get(any))
          .thenReturn(fixture('evolution_chain.json'));
      // act
      final result = evolutionChainBox.get(key);
      // assert
      verify(evolutionChainBox.get(key));
      expect(result, fixture('evolution_chain.json'));
    });

    test('Should call MockBox.put', () async {
      const key = 1;
      // act
      await evolutionChainBox.put(key, fixture('evolution_chain.json'));
      // assert
      verify(evolutionChainBox.put(key, fixture('evolution_chain.json')));
    });
  });
}
