part of 'evolution_chain_cubit.dart';

abstract class EvolutionchainState extends Equatable {
  const EvolutionchainState();

  @override
  List<Object> get props => [];
}

class EvolutionchainInitial extends EvolutionchainState {}

class EvolutionChainLoading extends EvolutionchainState {}

class EvolutionChainLoaded extends EvolutionchainState {
  EvolutionChainLoaded({@required this.evolutionChain});

  final EvolutionChainResponse evolutionChain;

  @override
  List<Object> get props => [evolutionChain];
}

class EvolutionChainError extends EvolutionchainState {
  EvolutionChainError({@required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
