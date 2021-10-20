import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/data/datasource/pokedex/pokedex_remote_datasource.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_info_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_specie_model.dart';

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
    const tEntryNumber = 1;
    final tPokemonSpecieResponse = fixture('pokemon_specie.json');
    final tPokemonInfoResponse = fixture('pokemon_info.json');
    final tPokemonSpecieModel =
        pokemonSpecieModelFromJson(tPokemonSpecieResponse);

    final tPokemonInfoModel =
        pokemonInfoModelFromJson(fixture('pokemon_info.json'));

    final tPokemonModel = PokemonModel(tPokemonInfoModel, tPokemonSpecieModel);

    test('Should make a GET request to pokemon_specie endpoint', () {
      // arrange
      setUpMockHttpClientSuccess200(tPokemonSpecieResponse);
      // act
      pokemonRemoteDataSource.getPokemonDetails(entryNumber: tEntryNumber);
      // assert
      verify(
        mockHttpClient.get(
          'https://pokeapi.co/api/v2/pokemon-species/$tEntryNumber/',
        ),
      );
    });

    test('Should return a PokemonModel when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get('https://pokeapi.co/api/v2/pokemon-species/$tEntryNumber/'))
          .thenAnswer((_) async => http.Response(tPokemonSpecieResponse, 200));

      when(mockHttpClient
              .get('https://pokeapi.co/api/v2/pokemon/$tEntryNumber/'))
          .thenAnswer((_) async => http.Response(tPokemonInfoResponse, 200));
      // act
      final result = await pokemonRemoteDataSource.getPokemonDetails(
          entryNumber: tEntryNumber);
      // assert
      expect(result, equals(tPokemonModel));
    });

    test(
      '''Should throws a ServerException when response code 
      is 404 or other''',
      () async {
        // arrange
        setUpMockHttpClientSuccess404();
        // act
        final call = pokemonRemoteDataSource.getPokemonDetails;
        // assert
        expect(() => call(entryNumber: tEntryNumber),
            throwsA(isA<ServerException>()));
      },
    );
  });

  group('get regional pokedex', () {
    const tRegion = 1;
    final tPokedexResponse = fixture('pokemon_specie.json');
    final tPokedexModel = pokedexModelFromJson(tPokedexResponse);

    test('''Deberia hacer un request tipo GET al URL de pokemon API 
        con un offset y un limit''', () {
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
