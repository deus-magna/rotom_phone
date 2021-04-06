import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/data/model/pokemon/pokemon_paginated_response_model.dart';
import 'package:rotom_phone/data/model/pokemon/pokedex_entry_model.dart';
import 'package:rotom_phone/domain/entities/pokemon/pokemon_paginated_response.dart';
import 'package:rotom_phone/domain/usercases/pokemon/get_paginated_pokemon_list.dart';
import 'package:rotom_phone/presentation/cubit/pokedex/pokedex_cubit.dart';

import '../../../fixtures/fixture_reader.dart';

class MockGetPaginatedPokemonList extends Mock
    implements GetPaginatedPokemonList {}

void main() {
  PokedexCubit pokedexCubit;
  MockGetPaginatedPokemonList mockGetPaginatedPokemonList;
  List<PokedexEntryModel> pokedexEntries = [];

  setUp(() {
    mockGetPaginatedPokemonList = MockGetPaginatedPokemonList();
    pokedexCubit = PokedexCubit(mockGetPaginatedPokemonList);
  });

  /// Mock de los parametros que necesitamos enviar para obtener la
  /// lista de pokemon
  final int tLimit = 40;
  final int tOffset = 0;

  /// Mock de la respuesta tras obtener la lista de pokemon
  final tPokemonPaginatedResponseModel = pokemonPaginatedResponseModelFromJson(
      fixture('pokemon_paginated_response.json'));
  final PokemonPaginatedResponse tPokemonPaginatedResponse =
      tPokemonPaginatedResponseModel;
  // Mock de la lista de entradas en la pokedex
  pokedexEntries = tPokemonPaginatedResponse.results
      .map((pokemonData) => pokedexEntryFromResult(pokemonData))
      .toList();

  group('GetPaginatedPokemonList', () {
    test('El estado inicial deberia ser PokedexInitial', () {
      expect(pokedexCubit.state, equals(PokedexInitial()));
    });

    test(
        'Debe emitir [Loading, Loaded] cuando la data se obtiene correctamente',
        () {
      when(mockGetPaginatedPokemonList(
              limit: anyNamed('limit'), offset: anyNamed('offset')))
          .thenAnswer(
              (realInvocation) async => Right(tPokemonPaginatedResponse));

      final expected = [
        PokedexLoading(),
        PokedexLoaded(pokedexEntries: pokedexEntries),
      ];

      expectLater(pokedexCubit.asBroadcastStream(), emitsInOrder(expected));
      pokedexCubit.getFirstPokedexPage(tLimit, tOffset);
    });

    test(
      'Deberia emitir [Loading, Error] cuando falla al obtener datos',
      () async {
        // arrange
        when(mockGetPaginatedPokemonList(
                limit: anyNamed('limit'), offset: anyNamed('offset')))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        // assert later
        final expected = [
          PokedexLoading(),
          PokedexError(
              message: 'Ha ocurrido un error, por favor intenta nuevamente.'),
        ];
        // act
        expectLater(pokedexCubit.asBroadcastStream(), emitsInOrder(expected));
        pokedexCubit.getFirstPokedexPage(tLimit, tOffset);
      },
    );
  });
}
