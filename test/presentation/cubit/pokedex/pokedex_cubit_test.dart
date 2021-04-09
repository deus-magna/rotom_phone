import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_entry_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_page_response_model.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokedex_page_response.dart';
import 'package:rotom_phone/domain/usercases/pokedex/get_pokedex_page.dart';
import 'package:rotom_phone/presentation/cubit/pokedex/pokedex_cubit.dart';

import '../../../fixtures/fixture_reader.dart';

class MockGetPaginatedPokemonList extends Mock implements GetPokedexPage {}

void main() {
  PokedexCubit pokedexCubit;
  MockGetPaginatedPokemonList mockGetPaginatedPokemonList;
  List<PokedexEntryModel> pokedexEntries = [];

  setUp(() {
    mockGetPaginatedPokemonList = MockGetPaginatedPokemonList();
    pokedexCubit = PokedexCubit(mockGetPaginatedPokemonList);
  });

  /// Mock de la respuesta tras obtener la lista de pokemon
  final tPokemonPaginatedResponseModel =
      pokedexPageResponseModelFromJson(fixture('pokedex_page_response.json'));
  final PokedexPageResponse tPokemonPaginatedResponse =
      tPokemonPaginatedResponseModel;
  // Mock de la lista de entradas en la pokedex
  pokedexEntries = tPokemonPaginatedResponse.results
      .map((pokemonData) => pokedexEntryFromResult(pokemonData))
      .toList();

  test('El estado inicial deberia ser PokedexInitial', () {
    expect(pokedexCubit.state, equals(PokedexInitial()));
  });

  group('getFirstPokedexPage', () {
    setUp(() {
      when(mockGetPaginatedPokemonList(
              limit: anyNamed('limit'), offset: anyNamed('offset')))
          .thenAnswer(
              (realInvocation) async => Right(tPokemonPaginatedResponse));
    });

    test('Deberia obtener la primer pagina de entradas de la Pokedex',
        () async {
      await pokedexCubit.getFirstPokedexPage();
      verify(mockGetPaginatedPokemonList(
          limit: anyNamed('limit'), offset: anyNamed('offset')));
    });

    test(
        'Debe emitir [Loading, Loaded] cuando la data se obtiene correctamente',
        () {
      final expected = [
        PokedexLoading(),
        PokedexLoaded(pokedexEntries: pokedexEntries),
      ];

      expectLater(pokedexCubit.asBroadcastStream(), emitsInOrder(expected));
      pokedexCubit.getFirstPokedexPage();
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
        pokedexCubit.getFirstPokedexPage();
      },
    );
  });

  group('getNextPokedexPage', () {
    /// Mock de los parametros que necesitamos enviar para obtener la
    /// lista de pokemon
    final int tLimit = 40;
    final int tOffset = 40;

    setUp(() {
      when(mockGetPaginatedPokemonList(
              limit: anyNamed('limit'), offset: anyNamed('offset')))
          .thenAnswer(
              (realInvocation) async => Right(tPokemonPaginatedResponse));
    });
    test('Deberia obtener la siguiente page del Pokedex', () async {
      await pokedexCubit.getNextPokedexPage(tLimit, tOffset);
      verify(mockGetPaginatedPokemonList(
          limit: anyNamed('limit'), offset: anyNamed('offset')));
    });

    test(
        'Deberia emitir [Loaded] cuando la siguiente pagina se obtiene correctamente',
        () {
      final expected = [
        PokedexLoaded(pokedexEntries: pokedexEntries),
      ];

      expectLater(pokedexCubit.asBroadcastStream(), emitsInOrder(expected));
      pokedexCubit.getNextPokedexPage(tLimit, tOffset);
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
          PokedexError(
              message: 'Ha ocurrido un error, por favor intenta nuevamente.'),
        ];
        // act
        expectLater(pokedexCubit.asBroadcastStream(), emitsInOrder(expected));
        pokedexCubit.getNextPokedexPage(tLimit, tOffset);
      },
    );
  });
}
