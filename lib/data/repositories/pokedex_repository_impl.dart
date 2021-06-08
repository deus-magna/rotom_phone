import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/core/network/network_info.dart';
import 'package:rotom_phone/data/datasource/pokedex/pokedex_local_datasource.dart';
import 'package:rotom_phone/data/datasource/pokedex/pokedex_remote_datasource.dart';
import 'package:rotom_phone/domain/entities/pokedex/evolution_chain_response.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokedex.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';
import 'package:rotom_phone/domain/repositories/pokedex_repository.dart';

class PokedexRepositoryImpl implements PokedexRepository {
  PokedexRepositoryImpl({
    @required this.localDataSource,
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  final PokedexRemoteDataSource remoteDataSource;
  final PokedexLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Pokedex>> getRegionalPokedex({int region}) async {
    try {
      final localRegionalPokedex =
          await localDataSource.getCachedRegionalPokedex(region);
      return Right(localRegionalPokedex);
    } on CacheException {
      if (await networkInfo.hasConnection) {
        try {
          final regionalPokedex =
              await remoteDataSource.getRegionalPokedex(region: region);
          await localDataSource.cacheRegionalPokedex(regionalPokedex);
          return Right(regionalPokedex);
        } on ServerException {
          return Left(ServerFailure());
        }
      } else {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemonDetails({int entryNumber}) async {
    try {
      final localPokemonDetail =
          await localDataSource.getCachedPokemonDetail(entryNumber);
      return Right(localPokemonDetail);
    } on CacheException {
      if (await networkInfo.hasConnection) {
        try {
          final pokemonDetail = await remoteDataSource.getPokemonDetails(
              entryNumber: entryNumber);
          await localDataSource.cachePokemonDetail(pokemonDetail);
          return Right(pokemonDetail);
        } on ServerException {
          return Left(ServerFailure());
        }
      } else {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, EvolutionChainResponse>> getEvolutionChain(
      {String evolutionChain}) async {
    try {
      final localEvolutionChain =
          await localDataSource.getCachedEvolutionChain(evolutionChain);
      return Right(localEvolutionChain);
    } on CacheException {
      if (await networkInfo.hasConnection) {
        try {
          final remoteEvolutionChain = await remoteDataSource.getEvolutionChain(
              evolutionChain: evolutionChain);
          await localDataSource.cacheEvolutionChain(remoteEvolutionChain);
          return Right(remoteEvolutionChain);
        } on ServerException {
          return Left(ServerFailure());
        }
      } else {
        return Left(ServerFailure());
      }
    }
  }
}
