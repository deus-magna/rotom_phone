import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/data/datasource/pokemon/pokemon_local_datasource.dart';
import 'package:rotom_phone/data/model/pokemon/pokemon_paginated_response_model.dart';

import '../../../fixtures/fixture_reader.dart';

class MockBox extends Mock implements Box {}

void main() {
  PokemonLocalDataSource localDataSource;
  MockBox mockBox;

  setUp(() {
    mockBox = MockBox();
    localDataSource = PokemonLocalDataSourceImpl(mockBox);
  });

  group('cachePokedexPage', () {
    final tPokemonPaginatedResponseModel =
        pokemonPaginatedResponseModelFromJson(
            fixture('pokemon_paginated_response.json'));
    final int tOffset = 40;
    test(
      'Should call Hive to cache the data',
      () async {
        // act
        localDataSource.cachePokemonPage(
            tOffset, tPokemonPaginatedResponseModel);
        // assert
        final expectedJsonString =
            pokemonPaginatedResponseModelToJson(tPokemonPaginatedResponseModel);
        verify(mockBox.put(tOffset, expectedJsonString));
      },
    );
  });
}
