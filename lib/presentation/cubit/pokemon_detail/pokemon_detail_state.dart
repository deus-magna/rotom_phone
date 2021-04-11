part of 'pokemon_detail_cubit.dart';

abstract class PokemonDetailState extends Equatable {
  const PokemonDetailState();

  @override
  List<Object> get props => [];
}

class PokemonDetailInitial extends PokemonDetailState {}

class PokemonDetailLoading extends PokemonDetailState {}

class PokemonDetailLoaded extends PokemonDetailState {
  final Pokemon pokemonDetail;

  PokemonDetailLoaded({@required this.pokemonDetail});

  @override
  List<Object> get props => [pokemonDetail];
}

class PokemonDetailError extends PokemonDetailState {
  final String message;

  PokemonDetailError({@required this.message});

  @override
  List<Object> get props => [message];
}
