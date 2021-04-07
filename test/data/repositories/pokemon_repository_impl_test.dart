import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/core/network/network_info.dart';
import 'package:rotom_phone/data/datasource/pokemon/pokemon_local_datasource.dart';
import 'package:rotom_phone/data/datasource/pokemon/pokemon_remote_datasource.dart';
import 'package:rotom_phone/data/model/pokemon/pokemon_paginated_response_model.dart';
import 'package:rotom_phone/data/repositories/pokemon_repository_impl.dart';
import 'package:rotom_phone/domain/entities/pokemon/pokemon_paginated_response.dart';

import '../../fixtures/fixture_reader.dart';

class MockRemoteDataSource extends Mock implements PokemonRemoteDataSource {}

class MockLocalDataSource extends Mock implements PokemonLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  PokemonRepositoryImpl pokemonRepositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;

  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();

    mockNetworkInfo = MockNetworkInfo();
    pokemonRepositoryImpl = PokemonRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getPokemonPaginatedList', () {
    final int tOffset = 0;
    final int tLimit = 40;
    final tPokemonPaginatedResponseModel =
        pokemonPaginatedResponseModelFromJson(
            fixture('pokemon_paginated_response.json'));
    final PokemonPaginatedResponse tPokemonPaginatedResponse =
        tPokemonPaginatedResponseModel;
    test('Should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.hasConnection).thenAnswer((_) async => true);
      // act
      pokemonRepositoryImpl.getPaginatedPokemonList(
          offset: tOffset, limit: tLimit);
      // assert
      verify(mockNetworkInfo.hasConnection);
    });

    group('Dispositivo tiene Internet', () {
      setUp(() {
        when(mockNetworkInfo.hasConnection).thenAnswer((_) async => true);
      });

      test(
          'Deberia regresar los datos remotos cuando la llamada al remoteDatasource es exitosa',
          () async {
        // arrange
        when(mockRemoteDataSource.getPaginatedPokemonList(
                limit: tLimit, offset: tOffset))
            .thenAnswer((_) async => tPokemonPaginatedResponseModel);
        // act
        final result = await pokemonRepositoryImpl.getPaginatedPokemonList(
            limit: tLimit, offset: tOffset);
        // assert
        verify(mockRemoteDataSource.getPaginatedPokemonList(
            limit: tLimit, offset: tOffset));
        expect(result, equals(Right(tPokemonPaginatedResponse)));
      });

      test(
          'Should cache the data locally when call the remote data source is seccesful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPaginatedPokemonList(
                limit: tLimit, offset: tOffset))
            .thenAnswer((_) async => tPokemonPaginatedResponseModel);
        // act
        await pokemonRepositoryImpl.getPaginatedPokemonList(
            limit: tLimit, offset: tOffset);
        // assert
        verify(mockRemoteDataSource.getPaginatedPokemonList(
            limit: tLimit, offset: tOffset));
        verify(mockLocalDataSource.cachePokemonPage(
            tOffset, tPokemonPaginatedResponseModel));
      });

      test(
          'Should return Server failure when call the remote data source is unseccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPaginatedPokemonList(
                limit: tLimit, offset: tOffset))
            .thenThrow(ServerException());
        // act
        final result = await pokemonRepositoryImpl.getPaginatedPokemonList(
            limit: tLimit, offset: tOffset);
        // assert
        verify(mockRemoteDataSource.getPaginatedPokemonList(
            limit: tLimit, offset: tOffset));

        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('Dispositivo no tiene Internet', () {
      setUp(() {
        when(mockNetworkInfo.hasConnection).thenAnswer((_) async => false);
      });
      test(
        'Deberia regresar un Server Failure cuando no hay Internet ',
        () async {
          // act
          final result = await pokemonRepositoryImpl.getPaginatedPokemonList(
              offset: tOffset, limit: tLimit);
          // assert

          verifyZeroInteractions(mockRemoteDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });
}
