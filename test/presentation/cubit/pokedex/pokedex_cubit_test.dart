import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/data/model/pokemon/pokemon_paginated_response_model.dart';
import 'package:rotom_phone/domain/entities/pokemon/pokemon_paginated_response.dart';
import 'package:rotom_phone/domain/usercases/pokemon/get_paginated_pokemon_list.dart';
import 'package:rotom_phone/presentation/cubit/pokedex/pokedex_cubit.dart';

import '../../../fixtures/fixture_reader.dart';

class MockGetPaginatedPokemonList extends Mock
    implements GetPaginatedPokemonList {}

void main() {
  PokedexCubit pokedexCubit;
  MockGetPaginatedPokemonList mockGetPaginatedPokemonList;

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

  test('El estado inicial debe ser PokedexInitial', () {
    expect(pokedexCubit.state, equals(PokedexInitial()));
  });

  test('Debe emitir loading y luego loaded', () {
    when(mockGetPaginatedPokemonList(
            limit: anyNamed('limit'), offset: anyNamed('offset')))
        .thenAnswer((realInvocation) async => Right(tPokemonPaginatedResponse));

    final expected = [
      //Empty(),
      PokedexLoading(),
      PokedexLoaded(pokemonPaginatedResponse: tPokemonPaginatedResponse),
    ];

    expectLater(pokedexCubit.asBroadcastStream(), emitsInOrder(expected));
    pokedexCubit.getPokemonList(tLimit, tOffset);
  });
}
