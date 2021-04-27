part of 'evolution_chain_cubit.dart';

abstract class EvolutionchainState extends Equatable {
  const EvolutionchainState();

  @override
  List<Object> get props => [];
}

class EvolutionchainInitial extends EvolutionchainState {}

class EvolutionChainLoading extends EvolutionchainState {}

class EvolutionChainLoaded extends EvolutionchainState {
  final EvolutionChainResponse evolutionChain;

  EvolutionChainLoaded({@required this.evolutionChain});

  @override
  List<Object> get props => [evolutionChain];
}

class EvolutionChainError extends EvolutionchainState {
  final String message;

  EvolutionChainError({@required this.message});

  @override
  List<Object> get props => [message];
}
