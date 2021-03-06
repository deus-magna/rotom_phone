import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:rotom_phone/domain/entities/hive_boxes.dart';
import 'package:rotom_phone/domain/repositories/pokedex_repository.dart';
import 'package:rotom_phone/domain/usercases/pokedex/get_evolution_chain.dart';
import 'package:rotom_phone/domain/usercases/pokedex/get_pokemon_detail.dart';
import 'package:rotom_phone/presentation/cubit/evolution_chain/evolution_chain_cubit.dart';
import 'package:rotom_phone/presentation/cubit/pokedex/pokedex_cubit.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rotom_phone/presentation/cubit/pokemon_detail/pokemon_detail_cubit.dart';

import '../core/network/network_info.dart';
import '../data/datasource/pokedex/pokedex_local_datasource.dart';
import '../data/datasource/pokedex/pokedex_remote_datasource.dart';
import '../data/repositories/pokedex_repository_impl.dart';
import '../domain/usercases/pokedex/get_regional_pokedex.dart';
import 'injection_container.dart';

Future<void> initPokedex() async {
  //! Features - Pokedex
  // Cubit
  sl.registerFactory(() => PokedexCubit(
        sl(),
      ));
  sl.registerFactory(() => PokemonDetailCubit(
        sl(),
      ));
  sl.registerFactory(() => EvolutionchainCubit(
        sl(),
      ));

  // use cases
  sl.registerLazySingleton(() => GetRegionalPokedex(sl()));
  sl.registerLazySingleton(() => GetPokemonDetails(sl()));
  sl.registerLazySingleton(() => GetEvolutionChain(sl()));

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
    () => PokedexLocalDataSourceImpl(
      sl<PokedexBox>(),
      sl<PokemonSpecieBox>(),
      sl<PokemonInfoBox>(),
      sl<EvolutionChainBox>(),
    ),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  await Hive.initFlutter();
  final regionalPokedexBox = PokedexBox(await Hive.openBox('pokedex'));
  final pokemonSpecieBox =
      PokemonSpecieBox(await Hive.openBox('pokemon_specie'));
  final pokemonInfoBox = PokemonInfoBox(await Hive.openBox('pokemon_info'));
  final evolutionChainBox =
      EvolutionChainBox(await Hive.openBox('evolution_chain'));
  sl.registerLazySingleton(() => regionalPokedexBox);
  sl.registerLazySingleton(() => pokemonSpecieBox);
  sl.registerLazySingleton(() => pokemonInfoBox);
  sl.registerLazySingleton(() => evolutionChainBox);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
