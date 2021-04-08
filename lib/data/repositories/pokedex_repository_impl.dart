import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/core/network/network_info.dart';
import 'package:rotom_phone/data/datasource/pokedex/pokedex_local_datasource.dart';
import 'package:rotom_phone/data/datasource/pokedex/pokedex_remote_datasource.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokedex_page_response.dart';
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
  Future<Either<Failure, PokedexPageResponse>> getPaginatedPokemonList(
      {int limit, int offset}) async {
    try {
      final localPokedexPage =
          await localDataSource.getCachedPokemonPage(offset);
      return Right(localPokedexPage);
    } on CacheException {
      if (await networkInfo.hasConnection) {
        try {
          final paginatedPokemonList = await remoteDataSource
              .getPaginatedPokemonList(limit: limit, offset: offset);
          localDataSource.cachePokemonPage(offset, paginatedPokemonList);
          return Right(paginatedPokemonList);
        } on ServerException {
          return Left(ServerFailure());
        }
      } else {
        return Left(ServerFailure());
      }
    }
  }
}
