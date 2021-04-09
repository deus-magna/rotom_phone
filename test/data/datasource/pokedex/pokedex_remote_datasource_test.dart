import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/datasource/pokedex/pokedex_remote_datasource.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_page_response_model.dart';

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
    when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(fixture('pokedex_page_response.json'), 200));
  }

  void setUpMockHttpClientSuccess404() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('get paginated pokemon list', () {
    final int offset = 0;
    final int limit = 40;
    final tPokemonPaginatedResponseModel =
        pokedexPageResponseModelFromJson(fixture('pokedex_page_response.json'));

    test(
        'Deberia hacer un request tipo GET al URL de pokemon API con un offset y un limit',
        () {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      pokemonRemoteDataSource.getPaginatedPokemonList(
          offset: offset, limit: limit);
      // assert
      verify(
        mockHttpClient.get(
          'https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=$offset',
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
        final result = await pokemonRemoteDataSource.getPaginatedPokemonList(
            offset: offset, limit: limit);
        // assert
        expect(result, equals(tPokemonPaginatedResponseModel));
      },
    );

    test(
      '''Deberia lanzar una ServerException cuando el código de respuesta 
      es 404 cualquier otro''',
      () async {
        // arrange
        setUpMockHttpClientSuccess404();
        // act
        final call = pokemonRemoteDataSource.getPaginatedPokemonList;
        // assert
        expect(() => call(offset: offset, limit: limit),
            throwsA(isA<ServerException>()));
      },
    );
  });
}
