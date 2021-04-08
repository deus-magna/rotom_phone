import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rotom_phone/data/datasource/pokemon/pokemon_local_datasource.dart';
import 'package:rotom_phone/domain/repositories/pokemon_repository.dart';
import 'package:rotom_phone/domain/usercases/pokemon/get_paginated_pokemon_list.dart';
import 'package:rotom_phone/presentation/cubit/pokedex/pokedex_cubit.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/network/network_info.dart';
import 'data/datasource/pokemon/pokemon_remote_datasource.dart';
import 'data/repositories/pokemon_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Auth
  // Provider
  sl.registerFactory(() => PokedexCubit(
        sl(),
      ));

  // use cases
  sl.registerLazySingleton(() => GetPokedexPage(sl()));

  // Repository
  sl.registerLazySingleton<PokemonRepository>(() => PokemonRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<PokemonRemoteDataSource>(
      () => PokemonRemoteDataSourceImpl(
            client: sl(),
          ));
  sl.registerLazySingleton<PokemonLocalDataSource>(
      () => PokemonLocalDataSourceImpl(sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  await Hive.initFlutter();
  final pokedexEntriesBox = await Hive.openBox('pokedex');
  sl.registerLazySingleton(() => pokedexEntriesBox);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
