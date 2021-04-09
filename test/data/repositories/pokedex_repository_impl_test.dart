import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/core/network/network_info.dart';
import 'package:rotom_phone/data/datasource/pokedex/pokedex_local_datasource.dart';
import 'package:rotom_phone/data/datasource/pokedex/pokedex_remote_datasource.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_page_response_model.dart';
import 'package:rotom_phone/data/repositories/pokedex_repository_impl.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokedex_page_response.dart';

import '../../fixtures/fixture_reader.dart';

class MockRemoteDataSource extends Mock implements PokedexRemoteDataSource {}

class MockLocalDataSource extends Mock implements PokedexLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  PokedexRepositoryImpl pokemonRepositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;

  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();

    mockNetworkInfo = MockNetworkInfo();
    pokemonRepositoryImpl = PokedexRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.hasConnection).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.hasConnection).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getPokemonPaginatedList', () {
    final int tOffset = 0;
    final int tLimit = 40;
    final tPokemonPaginatedResponseModel =
        pokedexPageResponseModelFromJson(fixture('pokedex_page_response.json'));
    final PokedexPageResponse tPokemonPaginatedResponse =
        tPokemonPaginatedResponseModel;
    test('Should check if the device is online', () async {
      // arrange
      when(mockLocalDataSource.getCachedPokemonPage(tOffset))
          .thenThrow(CacheException());
      when(mockNetworkInfo.hasConnection).thenAnswer((_) async => true);
      // act
      pokemonRepositoryImpl.getPaginatedPokemonList(
          offset: tOffset, limit: tLimit);
      // assert
      verify(mockNetworkInfo.hasConnection);
    });

    runTestsOnline(() {
      group('Device has cached data', () {
        setUp(() {
          when(mockLocalDataSource.getCachedPokemonPage(tOffset))
              .thenAnswer((_) async => tPokemonPaginatedResponse);
        });

        test('Should return last locally data when cached data is present',
            () async {
          // act
          final result = await pokemonRepositoryImpl.getPaginatedPokemonList(
              limit: tLimit, offset: tOffset);
          // assert
          verify(mockLocalDataSource.getCachedPokemonPage(tOffset));
          verifyZeroInteractions(mockRemoteDataSource);
          verifyZeroInteractions(mockNetworkInfo);
          expect(result, equals(Right(tPokemonPaginatedResponse)));
        });
      });

      group('Device doesn`t have cache data', () {
        setUp(() {
          when(mockLocalDataSource.getCachedPokemonPage(tOffset))
              .thenThrow(CacheException());
        });

        test(
            'Should return remote data when call the remote data source is seccesful',
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

        test('''Should return Server failure when there is no cached data 
            present and call the remote data source is unseccessful''',
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
          verify(mockLocalDataSource.getCachedPokemonPage(tOffset));

          expect(result, equals(Left(ServerFailure())));
        });
      });
    });

    runTestsOffline(() {
      group('Device has cached data', () {
        setUp(() {
          when(mockLocalDataSource.getCachedPokemonPage(tOffset))
              .thenAnswer((_) async => tPokemonPaginatedResponse);
        });

        test('Should return last locally data when cached data is present',
            () async {
          // act
          final result = await pokemonRepositoryImpl.getPaginatedPokemonList(
              limit: tLimit, offset: tOffset);
          // assert
          verify(mockLocalDataSource.getCachedPokemonPage(tOffset));
          verifyZeroInteractions(mockRemoteDataSource);
          verifyZeroInteractions(mockNetworkInfo);
          expect(result, equals(Right(tPokemonPaginatedResponse)));
        });
      });
      group('There is no cached data present', () {
        setUp(() {
          when(mockLocalDataSource.getCachedPokemonPage(tOffset))
              .thenThrow(CacheException());
        });
        test(
          'Should return Server failure when device is offline',
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
  });
}
