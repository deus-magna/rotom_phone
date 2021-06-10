part of 'pokemon_detail_cubit.dart';

abstract class PokemonDetailState extends Equatable {
  const PokemonDetailState();

  @override
  List<Object> get props => [];
}

class PokemonDetailInitial extends PokemonDetailState {}

class PokemonDetailLoading extends PokemonDetailState {}

class PokemonDetailLoaded extends PokemonDetailState {
  PokemonDetailLoaded({@required this.pokemonDetail});

  final Pokemon pokemonDetail;

  @override
  List<Object> get props => [pokemonDetail];
}

class PokemonDetailError extends PokemonDetailState {
  PokemonDetailError({@required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
