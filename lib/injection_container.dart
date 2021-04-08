import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rotom_phone/domain/repositories/pokedex_repository.dart';
import 'package:rotom_phone/presentation/cubit/pokedex/pokedex_cubit.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/network/network_info.dart';
import 'data/datasource/pokedex/pokedex_local_datasource.dart';
import 'data/datasource/pokedex/pokedex_remote_datasource.dart';
import 'data/repositories/pokedex_repository_impl.dart';
import 'domain/usercases/pokedex/get_pokedex_page.dart';

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
  sl.registerLazySingleton<PokedexRepository>(() => PokedexRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<PokedexRemoteDataSource>(
      () => PokedexRemoteDataSourceImpl(
            client: sl(),
          ));
  sl.registerLazySingleton<PokedexLocalDataSource>(
      () => PokedexLocalDataSourceImpl(sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  await Hive.initFlutter();
  final pokedexEntriesBox = await Hive.openBox('pokedex');
  sl.registerLazySingleton(() => pokedexEntriesBox);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
