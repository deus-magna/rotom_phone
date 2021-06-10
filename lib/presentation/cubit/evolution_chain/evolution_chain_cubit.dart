import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:rotom_phone/core/errors/failure.dart';
import 'package:rotom_phone/domain/entities/pokedex/evolution_chain_response.dart';
import 'package:rotom_phone/domain/usercases/pokedex/get_evolution_chain.dart';

part 'evolution_chain_state.dart';

class EvolutionchainCubit extends Cubit<EvolutionchainState> {
  EvolutionchainCubit(this.getEvolutionChain)
      : assert(getEvolutionChain != null),
        super(EvolutionchainInitial());

  GetEvolutionChain getEvolutionChain;

  void init(String evolutionChain) {
    getEvolutionChain(evolutionChain: evolutionChain);
  }

  void getPokemonEvolutions(String evolutionChain) async {
    emit(EvolutionChainLoading());
    final failureOrEvolutionChain =
        await getEvolutionChain(evolutionChain: evolutionChain);
    emit(_eitherLoadedOrErrorState(failureOrEvolutionChain));
  }

  EvolutionchainState _eitherLoadedOrErrorState(
      Either<Failure, EvolutionChainResponse> failureOrPokemonList) {
    return failureOrPokemonList.fold(
        (failure) =>
            EvolutionChainError(message: _mapFailureToMessage(failure)),
        (evolutionChain) =>
            EvolutionChainLoaded(evolutionChain: evolutionChain));
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
