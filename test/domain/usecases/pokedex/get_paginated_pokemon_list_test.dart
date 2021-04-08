import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_page_response_model.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokedex_page_response.dart';
import 'package:rotom_phone/domain/repositories/pokedex_repository.dart';
import 'package:rotom_phone/domain/usercases/pokedex/get_pokedex_page.dart';

import '../../../fixtures/fixture_reader.dart';

class MockPokemonRepository extends Mock implements PokedexRepository {}

void main() {
  GetPokedexPage usecase;
  MockPokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    usecase = GetPokedexPage(mockPokemonRepository);
  });

  /// Mock de los parametros que necesitamos enviar para obtener la
  /// lista de pokemon
  final int tLimit = 40;
  final int tOffset = 0;

  /// Mock de la respuesta tras obtener la lista de pokemon
  final tPokemonPaginatedResponseModel = pokedexPageResponseModelFromJson(
      fixture('pokemon_paginated_response.json'));
  final PokedexPageResponse tPokemonPaginatedResponse =
      tPokemonPaginatedResponseModel;

  test(
    'Deberia obtener una lista de pokemon en base al offset y el limite',
    () async {
      // arrange
      when(mockPokemonRepository.getPaginatedPokemonList(
              limit: anyNamed('limit'), offset: anyNamed('offset')))
          .thenAnswer((_) async => Right(tPokemonPaginatedResponse));
      // act
      final result = await usecase(limit: tLimit, offset: tOffset);
      // assert
      expect(result, Right(tPokemonPaginatedResponse));
      verify(mockPokemonRepository.getPaginatedPokemonList(
          limit: tLimit, offset: tOffset));
      verifyNoMoreInteractions(mockPokemonRepository);
    },
  );
}
