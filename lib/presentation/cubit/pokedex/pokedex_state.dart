part of 'pokedex_cubit.dart';

abstract class PokedexState extends Equatable {
  const PokedexState();

  @override
  List<Object> get props => [];
}

class PokedexInitial extends PokedexState {}

class PokedexLoading extends PokedexState {}

class PokedexLoaded extends PokedexState {
  PokedexLoaded({@required this.pokedexEntries});

  final List<LocalPokedexEntryModel> pokedexEntries;

  @override
  List<Object> get props => [pokedexEntries];
}

class PokedexError extends PokedexState {
  PokedexError({@required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
