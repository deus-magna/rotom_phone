import 'package:equatable/equatable.dart';

class PokemonPaginatedResponse extends Equatable {
  PokemonPaginatedResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  final int count;
  final String next;
  final String previous;
  final List<Result> results;

  @override
  List<Object> get props => [count, next, previous, results];
}

class Result extends Equatable {
  Result({
    this.name,
    this.url,
  });

  final String name;
  final String url;

  @override
  List<Object> get props => [name, url];
}
