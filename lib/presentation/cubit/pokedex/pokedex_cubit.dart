import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/data/model/pokedex/local_pokedex_entry_model.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokedex.dart';
import 'package:rotom_phone/domain/usercases/pokedex/get_regional_pokedex.dart';

part 'pokedex_state.dart';

class PokedexCubit extends Cubit<PokedexState> {
  final GetRegionalPokedex getPaginatedPokemonList;

  PokedexCubit(this.getPaginatedPokemonList)
      : assert(getPaginatedPokemonList != null),
        super(PokedexInitial());

  getRegionalPokedex(int region) async {
    emit(PokedexLoading());
    final failureOrPokemonList = await getPaginatedPokemonList(region: region);
    emit(_eitherLoadedOrErrorState(failureOrPokemonList));
  }

  PokedexState _eitherLoadedOrErrorState(
      Either<Failure, Pokedex> failureOrPokemonList) {
    return failureOrPokemonList.fold(
        (failure) => PokedexError(message: _mapFailureToMessage(failure)),
        (pokemonPaginatedResponse) => PokedexLoaded(
            pokedexEntries: getPokedexEntries(pokemonPaginatedResponse)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Ha ocurrido un error, por favor intenta nuevamente.';
      default:
        return 'Unexpected error';
    }
  }

  List<LocalPokedexEntryModel> getPokedexEntries(Pokedex pokedex) {
    return pokedex.pokemonEntries
        .map((pokemonData) => localPokedexEntryFromPokedexEntry(pokemonData))
        .toList();
  }
}
