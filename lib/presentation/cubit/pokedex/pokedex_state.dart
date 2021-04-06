part of 'pokedex_cubit.dart';

abstract class PokedexState extends Equatable {
  const PokedexState();

  @override
  List<Object> get props => [];
}

class PokedexInitial extends PokedexState {}

class PokedexLoading extends PokedexState {}

class PokedexLoaded extends PokedexState {
  final List<PokedexEntry> pokedexEntries;

  PokedexLoaded({@required this.pokedexEntries});

  @override
  List<Object> get props => [pokedexEntries];
}

class PokedexError extends PokedexState {
  final String message;

  PokedexError({@required this.message});

  @override
  List<Object> get props => [message];
}
