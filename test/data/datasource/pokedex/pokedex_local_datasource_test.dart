import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/datasource/pokedex/pokedex_local_datasource.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_info_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_specie_model.dart';
import 'package:rotom_phone/domain/entities/hive_boxes.dart';

import '../../../fixtures/fixture_reader.dart';

class MockBox extends Mock implements Box {}

class MockPokedexBox extends Mock implements PokedexBox {}

class MockPokemonSpecieBox extends Mock implements PokemonSpecieBox {}

class MockPokemonInfoBox extends Mock implements PokemonInfoBox {}

class MockEvolutionChainBox extends Mock implements EvolutionChainBox {}

void main() {
  PokedexLocalDataSource localDataSource;
  MockPokedexBox mockPokedexBox;
  MockPokemonSpecieBox mockPokemonSpecieBox;
  MockPokemonInfoBox mockPokemonInfoBox;
  MockEvolutionChainBox mockEvolutionChainBox;

  setUp(() async {
    mockPokemonSpecieBox = MockPokemonSpecieBox();
    mockPokedexBox = MockPokedexBox();
    mockPokemonSpecieBox = MockPokemonSpecieBox();
    mockPokemonInfoBox = MockPokemonInfoBox();
    mockEvolutionChainBox = MockEvolutionChainBox();
    localDataSource = PokedexLocalDataSourceImpl(
      mockPokedexBox,
      mockPokemonSpecieBox,
      mockPokemonInfoBox,
      mockEvolutionChainBox,
    );
  });

  group('PokemonDetail', () {
    const tEntryNumber = 1;
    final tPokemonSpecieModel =
        pokemonSpecieModelFromJson(fixture('pokemon_specie.json'));
    final tPokemonInfoModel =
        pokemonInfoModelFromJson(fixture('pokemon_info.json'));
    final tPokemonModel = PokemonModel(tPokemonInfoModel, tPokemonSpecieModel);
    group('cachePokemonDetail', () {
      test('Should call PokemonSpecieBox to cache the data', () async {
        await localDataSource.cachePokemonDetail(tPokemonModel);

        final expectedJsonString =
            pokemonSpecieModelToJson(tPokemonSpecieModel);

        verify(mockPokemonSpecieBox.put(tEntryNumber, expectedJsonString));
      });

      test('Should call PokemonInfoBox to cache the data', () async {
        await localDataSource.cachePokemonDetail(tPokemonModel);

        final expectedJsonString = pokemonInfoModelToJson(tPokemonInfoModel);

        verify(mockPokemonInfoBox.put(tEntryNumber, expectedJsonString));
      });
    });
    group('getCachedPokemonDetail', () {
      test(
        'Should return PokemonDetail from Hive when there is one in the cache',
        () async {
          // arrange
          when(mockPokemonSpecieBox.get(any))
              .thenReturn(fixture('pokemon_specie.json'));
          when(mockPokemonInfoBox.get(any))
              .thenReturn(fixture('pokemon_info.json'));
          // act
          final result =
              await localDataSource.getCachedPokemonDetail(tEntryNumber);
          // assert
          verify(mockPokemonSpecieBox.get(tEntryNumber));
          verify(mockPokemonInfoBox.get(tEntryNumber));
          expect(result, equals(tPokemonModel));
        },
      );

      test(
        'Should throw a CacheException when there is not a cached value',
        () async {
          // arrange
          when(mockPokemonSpecieBox.get(any)).thenReturn(null);
          when(mockPokemonInfoBox.get(any)).thenReturn(null);
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
    const tRegion = 1;
    group('cacheRegionalPokedex', () {
      test(
        'Should call PokedexBox to cache the data',
        () async {
          // act
          await localDataSource.cacheRegionalPokedex(tPokedexModel);
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
