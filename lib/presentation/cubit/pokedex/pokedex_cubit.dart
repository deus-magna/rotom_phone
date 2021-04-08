import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_entry_model.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokedex_page_response.dart';
import 'package:rotom_phone/domain/usercases/pokedex/get_pokedex_page.dart';

part 'pokedex_state.dart';

class PokedexCubit extends Cubit<PokedexState> {
  final GetPokedexPage getPaginatedPokemonList;

  PokedexCubit(this.getPaginatedPokemonList)
      : assert(getPaginatedPokemonList != null),
        super(PokedexInitial());

  getFirstPokedexPage() async {
    emit(PokedexLoading());
    final failureOrPokemonList =
        await getPaginatedPokemonList(limit: 40, offset: 0);
    emit(_eitherLoadedOrErrorState(failureOrPokemonList));
  }

  PokedexState _eitherLoadedOrErrorState(
      Either<Failure, PokedexPageResponse> failureOrPokemonList) {
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

  getNextPokedexPage(int limit, int offset) async {
    final failureOrPokemonList =
        await getPaginatedPokemonList(limit: limit, offset: offset);
    emit(_eitherLoadedOrErrorState(failureOrPokemonList));
  }

  List<PokedexEntryModel> getPokedexEntries(
      PokedexPageResponse pokemonPaginatedResponse) {
    return pokemonPaginatedResponse.results
        .map((pokemonData) => pokedexEntryFromResult(pokemonData))
        .toList();
  }
}
