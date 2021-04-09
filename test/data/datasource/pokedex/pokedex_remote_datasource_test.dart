import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/datasource/pokedex/pokedex_remote_datasource.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_model.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  PokedexRemoteDataSource pokemonRemoteDataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    pokemonRemoteDataSource =
        PokedexRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response(fixture('pokedex.json'), 200));
  }

  void setUpMockHttpClientSuccess404() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('get paginated pokemon list', () {
    final int tRegion = 0;

    final tPokedexModel = pokedexModelFromJson(fixture('pokedex.json'));

    test(
        'Deberia hacer un request tipo GET al URL de pokemon API con un offset y un limit',
        () {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      pokemonRemoteDataSource.getRegionalPokedex(region: tRegion);
      // assert
      verify(
        mockHttpClient.get(
          'https://pokeapi.co/api/v2/pokedex/$tRegion',
        ),
      );
    });

    test(
      '''Deberia regresar PokemonPaginatedResponse cuando el código de 
      respuesta es 200''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result =
            await pokemonRemoteDataSource.getRegionalPokedex(region: tRegion);
        // assert
        expect(result, equals(tPokedexModel));
      },
    );

    test(
      '''Deberia lanzar una ServerException cuando el código de respuesta 
      es 404 cualquier otro''',
      () async {
        // arrange
        setUpMockHttpClientSuccess404();
        // act
        final call = pokemonRemoteDataSource.getRegionalPokedex;
        // assert
        expect(() => call(region: tRegion), throwsA(isA<ServerException>()));
      },
    );
  });
}
