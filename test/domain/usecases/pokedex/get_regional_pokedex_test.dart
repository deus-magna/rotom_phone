import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_model.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokedex.dart';
import 'package:rotom_phone/domain/repositories/pokedex_repository.dart';
import 'package:rotom_phone/domain/usercases/pokedex/get_regional_pokedex.dart';

import '../../../fixtures/fixture_reader.dart';

class MockPokemonRepository extends Mock implements PokedexRepository {}

void main() {
  GetRegionalPokedex usecase;
  MockPokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    usecase = GetRegionalPokedex(mockPokemonRepository);
  });

  /// Mock de los parametros que necesitamos enviar para obtener la
  /// lista de pokemon
  const tRegion = 1;

  /// Mock de la respuesta tras obtener la lista de pokemon
  final tPokemonPaginatedResponseModel =
      pokedexModelFromJson(fixture('pokedex.json'));
  final Pokedex tRegionalPokedex = tPokemonPaginatedResponseModel;

  test(
    'Deberia obtener una lista de pokemon en base al offset y el limite',
    () async {
      // arrange
      when(mockPokemonRepository.getRegionalPokedex(region: anyNamed('region')))
          .thenAnswer((_) async => Right(tRegionalPokedex));
      // act
      final result = await usecase(region: tRegion);
      // assert
      expect(result, Right(tRegionalPokedex));
      verify(mockPokemonRepository.getRegionalPokedex(region: tRegion));
      verifyNoMoreInteractions(mockPokemonRepository);
    },
  );
}
