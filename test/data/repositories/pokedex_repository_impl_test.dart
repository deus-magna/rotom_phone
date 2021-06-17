import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/core/network/network_info.dart';
import 'package:rotom_phone/data/datasource/pokedex/pokedex_local_datasource.dart';
import 'package:rotom_phone/data/datasource/pokedex/pokedex_remote_datasource.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_info_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_model.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_specie_model.dart';
import 'package:rotom_phone/data/repositories/pokedex_repository_impl.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokedex.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_info.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_specie.dart';

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

  group('getPokemonDetail', () {
    const tEntryNumber = 1;
    final tPokemonSpecieModel =
        pokemonSpecieModelFromJson(fixture('pokemon_specie.json'));
    final tPokemonInfoModel =
        pokemonInfoModelFromJson(fixture('pokemon_info.json'));
    final PokemonSpecie tPokemonSpecie = tPokemonSpecieModel;
    final PokemonInfo tPokemonInfo = tPokemonInfoModel;
    final PokemonModel tPokemonModel =
        PokemonModel(tPokemonInfo, tPokemonSpecie);
    final Pokemon tPokemon = tPokemonModel;

    test('Should check if the device is online', () {
      // arrange
      when(mockLocalDataSource.getCachedPokemonDetail(tEntryNumber))
          .thenThrow(CacheException());
      when(mockNetworkInfo.hasConnection).thenAnswer((_) async => true);
      // act
      pokemonRepositoryImpl.getPokemonDetails(entryNumber: tEntryNumber);
      // assert
      verify(mockNetworkInfo.hasConnection);
    });

    runTestsOnline(() {
      group('Device has PokemonDetail cached data', () {
        setUp(() {
          when(mockLocalDataSource.getCachedPokemonDetail(tEntryNumber))
              .thenAnswer((_) async => tPokemonModel);
        });

        test('Should return last locally data when cached data is present',
            () async {
          // act
          final result = await pokemonRepositoryImpl.getPokemonDetails(
              entryNumber: tEntryNumber);
          // assert
          verify(mockLocalDataSource.getCachedPokemonDetail(tEntryNumber));
          verifyZeroInteractions(mockRemoteDataSource);
          verifyZeroInteractions(mockNetworkInfo);
          expect(result, equals(Right(tPokemon)));
        });

        group('Device doesn`t have PokemonDetail cached data', () {
          setUp(() {
            when(mockLocalDataSource.getCachedPokemonDetail(tEntryNumber))
                .thenThrow(CacheException());
          });

          test('''Should return remote data when call the 
              remote data source is seccesful''', () async {
            // arrange
            when(mockRemoteDataSource.getPokemonDetails(
                    entryNumber: anyNamed('entryNumber')))
                .thenAnswer((_) async => tPokemonModel);
            // act
            final result = await pokemonRepositoryImpl.getPokemonDetails(
                entryNumber: tEntryNumber);
            // assert
            verify(mockRemoteDataSource.getPokemonDetails(
                entryNumber: tEntryNumber));
            expect(result, equals(Right(tPokemon)));
          });

          test('''Should cache the data locally when call
              the remote data source is seccesful''', () async {
            // arrange
            when(mockRemoteDataSource.getPokemonDetails(
                    entryNumber: anyNamed('entryNumber')))
                .thenAnswer((_) async => tPokemonModel);
            // act
            await pokemonRepositoryImpl.getPokemonDetails(
                entryNumber: tEntryNumber);
            // assert
            verify(mockRemoteDataSource.getPokemonDetails(
                entryNumber: tEntryNumber));
            verify(mockLocalDataSource.cachePokemonDetail(tPokemonModel));
          });

          test('''Should return Server failure when there is no cached data 
            present and call the remote data source is unseccessful''',
              () async {
            // arrange
            when(mockRemoteDataSource.getPokemonDetails(
                    entryNumber: anyNamed('entryNumber')))
                .thenThrow(ServerException());
            // act
            final result = await pokemonRepositoryImpl.getPokemonDetails(
                entryNumber: tEntryNumber);
            // assert
            verify(mockRemoteDataSource.getPokemonDetails(
                entryNumber: tEntryNumber));
            verify(mockLocalDataSource.getCachedPokemonDetail(tEntryNumber));

            expect(result, equals(Left(ServerFailure())));
          });
        });
      });
    });
  });

  group('getRegionalPokedex', () {
    const tRegion = 1;

    final tPokedexModel = pokedexModelFromJson(fixture('pokedex.json'));
    final Pokedex tPokedex = tPokedexModel;
    test('Should check if the device is online', () async {
      // arrange
      when(mockLocalDataSource.getCachedRegionalPokedex(tRegion))
          .thenThrow(CacheException());
      when(mockNetworkInfo.hasConnection).thenAnswer((_) async => true);
      // act
      pokemonRepositoryImpl.getRegionalPokedex(region: tRegion);
      // assert
      verify(mockNetworkInfo.hasConnection);
    });

    runTestsOnline(() {
      group('Device has cached data', () {
        setUp(() {
          when(mockLocalDataSource.getCachedRegionalPokedex(tRegion))
              .thenAnswer((_) async => tPokedex);
        });

        test('Should return last locally data when cached data is present',
            () async {
          // act
          final result =
              await pokemonRepositoryImpl.getRegionalPokedex(region: tRegion);
          // assert
          verify(mockLocalDataSource.getCachedRegionalPokedex(tRegion));
          verifyZeroInteractions(mockRemoteDataSource);
          verifyZeroInteractions(mockNetworkInfo);
          expect(result, equals(Right(tPokedex)));
        });
      });

      group('Device doesn`t have cache data', () {
        setUp(() {
          when(mockLocalDataSource.getCachedRegionalPokedex(tRegion))
              .thenThrow(CacheException());
        });

        test('''Should return remote data when call 
            the remote data source is seccesful''', () async {
          // arrange
          when(mockRemoteDataSource.getRegionalPokedex(region: tRegion))
              .thenAnswer((_) async => tPokedexModel);
          // act
          final result =
              await pokemonRepositoryImpl.getRegionalPokedex(region: tRegion);
          // assert
          verify(mockRemoteDataSource.getRegionalPokedex(region: tRegion));
          expect(result, equals(Right(tPokedex)));
        });

        test('''Should cache the data locally when call 
            the remote data source is seccesful''', () async {
          // arrange
          when(mockRemoteDataSource.getRegionalPokedex(region: tRegion))
              .thenAnswer((_) async => tPokedexModel);
          // act
          await pokemonRepositoryImpl.getRegionalPokedex(region: tRegion);
          // assert
          verify(mockRemoteDataSource.getRegionalPokedex(region: tRegion));
          verify(mockLocalDataSource.cacheRegionalPokedex(tPokedexModel));
        });

        test('''Should return Server failure when there is no cached data 
            present and call the remote data source is unseccessful''',
            () async {
          // arrange
          when(mockRemoteDataSource.getRegionalPokedex(region: tRegion))
              .thenThrow(ServerException());
          // act
          final result =
              await pokemonRepositoryImpl.getRegionalPokedex(region: tRegion);
          // assert
          verify(mockRemoteDataSource.getRegionalPokedex(region: tRegion));
          verify(mockLocalDataSource.getCachedRegionalPokedex(tRegion));

          expect(result, equals(Left(ServerFailure())));
        });
      });
    });

    runTestsOffline(() {
      group('Device has cached data', () {
        setUp(() {
          when(mockLocalDataSource.getCachedRegionalPokedex(tRegion))
              .thenAnswer((_) async => tPokedex);
        });

        test('Should return last locally data when cached data is present',
            () async {
          // act
          final result =
              await pokemonRepositoryImpl.getRegionalPokedex(region: tRegion);
          // assert
          verify(mockLocalDataSource.getCachedRegionalPokedex(tRegion));
          verifyZeroInteractions(mockRemoteDataSource);
          verifyZeroInteractions(mockNetworkInfo);
          expect(result, equals(Right(tPokedex)));
        });
      });
      group('There is no cached data present', () {
        setUp(() {
          when(mockLocalDataSource.getCachedRegionalPokedex(tRegion))
              .thenThrow(CacheException());
        });
        test(
          'Should return Server failure when device is offline',
          () async {
            // act
            final result =
                await pokemonRepositoryImpl.getRegionalPokedex(region: tRegion);
            // assert
            verifyZeroInteractions(mockRemoteDataSource);
            expect(result, equals(Left(ServerFailure())));
          },
        );
      });
    });
  });
}
