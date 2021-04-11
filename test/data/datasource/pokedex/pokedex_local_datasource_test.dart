import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/datasource/pokedex/pokedex_local_datasource.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_specie_model.dart';
import 'package:rotom_phone/domain/entities/hive_boxes.dart';

import '../../../fixtures/fixture_reader.dart';

class MockBox extends Mock implements Box {}

class MockPokedexBox extends Mock implements PokedexBox {}

class MockPokemonDetailBox extends Mock implements PokemonDetailBox {}

void main() {
  PokedexLocalDataSource localDataSource;
  MockPokedexBox mockPokedexBox;
  PokemonDetailBox mockPokemonDetailBox;

  setUp(() async {
    mockPokemonDetailBox = MockPokemonDetailBox();
    mockPokedexBox = MockPokedexBox();
    mockPokemonDetailBox = MockPokemonDetailBox();
    localDataSource =
        PokedexLocalDataSourceImpl(mockPokedexBox, mockPokemonDetailBox);
  });

  group('PokemonDetail', () {
    final int tEntryNumber = 1;
    final tPokemonDetailModel =
        pokemonDetailModelFromJson(fixture('pokemon_detail.json'));
    group('cachePokemonDetail', () {
      test('Should call PokemonDetalBox to cache the data', () {
        localDataSource.cachePokemonDetail(tPokemonDetailModel);
        final expectedJsonString =
            pokemonDetailModelToJson(tPokemonDetailModel);
        verify(mockPokemonDetailBox.put(tEntryNumber, expectedJsonString));
      });
    });
    group('getCachedPokemonDetail', () {
      test(
        'Should return PokemonDetail from Hive when there is one in the cache',
        () async {
          // arrange
          when(mockPokemonDetailBox.get(any))
              .thenReturn(fixture('pokemon_detail.json'));
          // act
          final result =
              await localDataSource.getCachedPokemonDetail(tEntryNumber);
          // assert
          verify(mockPokemonDetailBox.get(tEntryNumber));
          expect(result, equals(tPokemonDetailModel));
        },
      );

      test(
        'Should throw a CacheException when there is not a cached value',
        () async {
          // arrange
          when(mockPokedexBox.get(any)).thenReturn(null);
          // act
          final call = localDataSource.getCachedPokemonDetail;
          // assert
          expect(() => call(tEntryNumber), throwsA(isA<CacheException>()));
        },
      );
    });
  });

  group('RegionalPokedex', () {
    final tPokedexModel = pokedexModelFromJson(fixture('pokedex.json'));
    final int tRegion = 1;
    group('cacheRegionalPokedex', () {
      test(
        'Should call PokedexBox to cache the data',
        () async {
          // act
          localDataSource.cacheRegionalPokedex(tPokedexModel);
          // assert
          final expectedJsonString = pokedexModelToJson(tPokedexModel);
          verify(mockPokedexBox.put(tRegion, expectedJsonString));
        },
      );
    });

    group('getCachedRegionalPokedex', () {
      test(
        'Should return Pokedex from Hive when there is one in the cache',
        () async {
          // arrange
          when(mockPokedexBox.get(any)).thenReturn(fixture('pokedex.json'));
          // act
          final result =
              await localDataSource.getCachedRegionalPokedex(tRegion);
          // assert
          verify(mockPokedexBox.get(tRegion));
          expect(result, equals(tPokedexModel));
        },
      );

      test(
        'Should throw a CacheException when there is not a cached value',
        () async {
          // arrange
          when(mockPokedexBox.get(any)).thenReturn(null);
          // act
          final call = localDataSource.getCachedRegionalPokedex;
          // assert
          expect(() => call(tRegion), throwsA(isA<CacheException>()));
        },
      );
    });
  });
}
