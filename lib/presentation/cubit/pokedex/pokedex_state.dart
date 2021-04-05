part of 'pokedex_cubit.dart';

abstract class PokedexState extends Equatable {
  const PokedexState();

  @override
  List<Object> get props => [];
}

class PokedexInitial extends PokedexState {}

class PokedexLoading extends PokedexState {}

class PokedexLoaded extends PokedexState {
  final PokemonPaginatedResponse pokemonPaginatedResponse;

  PokedexLoaded({@required this.pokemonPaginatedResponse});

  @override
  List<Object> get props => [pokemonPaginatedResponse];
}

class PokedexError extends PokedexState {
  final String message;

  PokedexError({@required this.message});

  @override
  List<Object> get props => [message];
}
