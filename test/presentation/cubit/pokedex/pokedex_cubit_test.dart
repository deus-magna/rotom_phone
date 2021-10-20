import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/data/model/pokedex/local_pokedex_entry_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_model.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokedex.dart';
import 'package:rotom_phone/domain/usercases/pokedex/get_regional_pokedex.dart';
import 'package:rotom_phone/presentation/cubit/pokedex/pokedex_cubit.dart';

import '../../../fixtures/fixture_reader.dart';

class MockGetRegionalPokedex extends Mock implements GetRegionalPokedex {}

void main() {
  PokedexCubit pokedexCubit;
  MockGetRegionalPokedex mockGetRegionalPokedex;
  var pokedexEntries = <LocalPokedexEntryModel>[];

  setUp(() {
    mockGetRegionalPokedex = MockGetRegionalPokedex();
    pokedexCubit = PokedexCubit(mockGetRegionalPokedex);
  });

  /// Mock de la respuesta tras obtener la lista de pokemon
  final tPokemonPaginatedResponseModel =
      pokedexModelFromJson(fixture('pokedex.json'));
  final Pokedex tRegionalPokedex = tPokemonPaginatedResponseModel;
  // Mock de la lista de entradas en la pokedex
  pokedexEntries = tRegionalPokedex.pokemonEntries
      .map((pokemonData) => localPokedexEntryFromPokedexEntry(pokemonData))
      .toList();

  test('El estado inicial deberia ser PokedexInitial', () {
    expect(pokedexCubit.state, equals(PokedexInitial()));
  });

  const tRegion = 1;
  group('getRegionalPokedex', () {
    setUp(() {
      when(mockGetRegionalPokedex(region: anyNamed('region')))
          .thenAnswer((realInvocation) async => Right(tRegionalPokedex));
    });

    test('Deberia obtener la primer pagina de entradas de la Pokedex',
        () async {
      await pokedexCubit.getRegionalPokedex(1);
      verify(mockGetRegionalPokedex(region: anyNamed('region')));
    });

    test(
        'Debe emitir [Loading, Loaded] cuando la data se obtiene correctamente',
        () {
      final expected = [
        PokedexLoading(),
        PokedexLoaded(pokedexEntries: pokedexEntries),
      ];

      expectLater(pokedexCubit.asBroadcastStream(), emitsInOrder(expected));
      pokedexCubit.getRegionalPokedex(tRegion);
    });

    test(
      'Deberia emitir [Loading, Error] cuando falla al obtener datos',
      () async {
        // arrange
        when(mockGetRegionalPokedex(region: anyNamed('region')))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        // assert later
        final expected = [
          PokedexLoading(),
          PokedexError(
              message: 'Ha ocurrido un error, por favor intenta nuevamente.'),
        ];
        // act
        expectLater(pokedexCubit.asBroadcastStream(), emitsInOrder(expected));
        pokedexCubit.getRegionalPokedex(tRegion);
      },
    );
  });
}
