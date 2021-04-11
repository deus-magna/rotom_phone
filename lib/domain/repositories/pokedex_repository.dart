import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokedex.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_specie.dart';

abstract class PokedexRepository {
  Future<Either<Failure, Pokedex>> getRegionalPokedex({@required int region});
  Future<Either<Failure, PokemonSpecie>> getPokemonDetail(
      {@required int entryNumber});
}
