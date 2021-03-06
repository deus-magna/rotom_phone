import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';
import 'package:rotom_phone/domain/usercases/pokedex/get_pokemon_detail.dart';

part 'pokemon_detail_state.dart';

class PokemonMenuCubit extends Cubit<int> {
  PokemonMenuCubit() : super(0);

  void onItemChanged(int index) => emit(index);
}

class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  PokemonDetailCubit(this.getPokemonDetail)
      : assert(getPokemonDetail != null),
        super(PokemonDetailInitial());

  final GetPokemonDetails getPokemonDetail;

  void init(int entryNumber) {
    getPokemonDetail(entryNumber: entryNumber);
  }

  void getPokemonDetails(int entryNumber) async {
    emit(PokemonDetailLoading());
    final failureOrPokemonList =
        await getPokemonDetail(entryNumber: entryNumber);
    emit(_eitherLoadedOrErrorState(failureOrPokemonList));
  }

  PokemonDetailState _eitherLoadedOrErrorState(
      Either<Failure, Pokemon> failureOrPokemonList) {
    return failureOrPokemonList.fold(
        (failure) => PokemonDetailError(message: _mapFailureToMessage(failure)),
        (pokemon) => PokemonDetailLoaded(pokemonDetail: pokemon));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Ha ocurrido un error, por favor intenta nuevamente.';
      default:
        return 'Unexpected error';
    }
  }
}
