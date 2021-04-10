import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/datasource/pokedex/pokedex_remote_datasource.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_detail_model.dart';

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

  void setUpMockHttpClientSuccess200(String response) {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response(response, 200));
  }

  void setUpMockHttpClientSuccess404() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('get Pokemon detail', () {
    final int tEntryNumber = 1;
    final String tPokemonDetailResponse = fixture('pokemon_detail.json');
    final tPokemonDetail = pokemonDetailModelFromJson(tPokemonDetailResponse);

    test('Should make a GET request to pokemon_detail endpoint', () {
      // arrange
      setUpMockHttpClientSuccess200(tPokemonDetailResponse);
      // act
      pokemonRemoteDataSource.getPokemonDetail(entryNumber: tEntryNumber);
      // assert
      verify(
        mockHttpClient.get(
          'https://pokeapi.co/api/v2/pokemon-species/$tEntryNumber/',
        ),
      );
    });

    test('Should return a PokemonDetailModel when response code is 200',
        () async {
      // arrange
      setUpMockHttpClientSuccess200(tPokemonDetailResponse);
      // act
      final result = await pokemonRemoteDataSource.getPokemonDetail(
          entryNumber: tEntryNumber);
      // assert
      expect(result, equals(tPokemonDetail));
    });

    test(
      '''Should throws a ServerException when response code 
      is 404 or other''',
      () async {
        // arrange
        setUpMockHttpClientSuccess404();
        // act
        final call = pokemonRemoteDataSource.getPokemonDetail;
        // assert
        expect(() => call(entryNumber: tEntryNumber),
            throwsA(isA<ServerException>()));
      },
    );
  });

  group('get regional pokedex', () {
    final int tRegion = 1;
    final String tPokedexResponse = fixture('pokemon_detail.json');
    final tPokedexModel = pokedexModelFromJson(tPokedexResponse);

    test(
        'Deberia hacer un request tipo GET al URL de pokemon API con un offset y un limit',
        () {
      // arrange
      setUpMockHttpClientSuccess200(tPokedexResponse);
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
      '''Should return a PokedexModel when response code is 200''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200(tPokedexResponse);
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
