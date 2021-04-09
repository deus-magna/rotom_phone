import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/datasource/pokedex/pokedex_local_datasource.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_model.dart';

import '../../../fixtures/fixture_reader.dart';

class MockBox extends Mock implements Box {}

void main() {
  PokedexLocalDataSource localDataSource;
  MockBox mockBox;

  setUp(() {
    mockBox = MockBox();
    localDataSource = PokedexLocalDataSourceImpl(mockBox);
  });
  final tPokedexModel = pokedexModelFromJson(fixture('pokedex.json'));
  final int tRegion = 1;
  group('cachePokedexPage', () {
    test(
      'Should call Hive to cache the data',
      () async {
        // act
        localDataSource.cacheRegionalPokedex(tRegion, tPokedexModel);
        // assert
        final expectedJsonString = pokedexModelToJson(tPokedexModel);
        verify(mockBox.put(tRegion, expectedJsonString));
      },
    );
  });

  group('getCachedPokemonPage', () {
    test(
      'Should return PokedexPage from Hive when there is one in the cache',
      () async {
        // arrange
        when(mockBox.get(any)).thenReturn(fixture('pokedex.json'));
        // act
        final result = await localDataSource.getCachedRegionalPokedex(tRegion);
        // assert
        verify(mockBox.get(tRegion));
        expect(result, equals(tPokedexModel));
      },
    );

    test(
      'Should throw a CacheException when there is not a cached value',
      () async {
        // arrange
        when(mockBox.get(any)).thenReturn(null);
        // act
        final call = localDataSource.getCachedRegionalPokedex;
        // assert
        expect(() => call(tRegion), throwsA(isA<CacheException>()));
      },
    );
  });
}
