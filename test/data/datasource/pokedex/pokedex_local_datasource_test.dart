import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/datasource/pokedex/pokedex_local_datasource.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_model.dart';
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
  final tPokedexModel = pokedexModelFromJson(fixture('pokedex.json'));
  final int tRegion = 1;
  group('cacheRegionalPokedex', () {
    test(
      'Should call Hive to cache the data',
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
      'Should return PokedexPage from Hive when there is one in the cache',
      () async {
        // arrange
        when(mockPokedexBox.get(any)).thenReturn(fixture('pokedex.json'));
        // act
        final result = await localDataSource.getCachedRegionalPokedex(tRegion);
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
}
