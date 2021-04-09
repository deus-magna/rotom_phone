import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/core/network/network_info.dart';
import 'package:rotom_phone/data/datasource/pokedex/pokedex_local_datasource.dart';
import 'package:rotom_phone/data/datasource/pokedex/pokedex_remote_datasource.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokedex.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_detail.dart';
import 'package:rotom_phone/domain/repositories/pokedex_repository.dart';

class PokedexRepositoryImpl implements PokedexRepository {
  final PokedexRemoteDataSource remoteDataSource;
  final PokedexLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PokedexRepositoryImpl({
    @required this.localDataSource,
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

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
          localDataSource.cacheRegionalPokedex(region, regionalPokedex);
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
  Future<Either<Failure, PokemonDetail>> getPokemonDetail(
      {int entryNumber}) async {
    if (await networkInfo.hasConnection) {
      try {
        final pokemonDetail =
            await remoteDataSource.getPokemonDetail(entryNumber: entryNumber);
        return Right(pokemonDetail);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
