import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:rotom_phone/core/errors/exceptions.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/core/network/network_info.dart';
import 'package:rotom_phone/data/datasource/pokemon/pokemon_remote_datasource.dart';
import 'package:rotom_phone/domain/entities/pokemon/pokemon_paginated_response.dart';
import 'package:rotom_phone/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PokemonRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, PokemonPaginatedResponse>> getPaginatedPokemonList(
      {int limit, int offset}) async {
    if (await networkInfo.hasConnection) {
      try {
        final paginatedPokemonList = await remoteDataSource
            .getPaginatedPokemonList(limit: limit, offset: offset);

        return Right(paginatedPokemonList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
