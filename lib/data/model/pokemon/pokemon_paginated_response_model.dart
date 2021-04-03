import 'dart:convert';

import 'package:rotom_phone/domain/entities/pokemon/pokemon_paginated_response.dart';

PokemonPaginatedResponseModel pokemonPaginatedResponseModelFromJson(
        String str) =>
    PokemonPaginatedResponseModel.fromJson(json.decode(str));

class PokemonPaginatedResponseModel extends PokemonPaginatedResponse {
  PokemonPaginatedResponseModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  }) : super(count: count, next: next, previous: previous, results: results);

  final int count;
  final String next;
  final String previous;
  final List<ResultModel> results;

  factory PokemonPaginatedResponseModel.fromJson(Map<String, dynamic> json) =>
      PokemonPaginatedResponseModel(
        count: json["count"] == null ? null : json["count"],
        next: json["next"] == null ? null : json["next"],
        previous: json["previous"] == null ? null : json["previous"],
        results: json["results"] == null
            ? null
            : List<ResultModel>.from(
                json["results"].map((x) => ResultModel.fromJson(x))),
      );
}

class ResultModel extends Result {
  ResultModel({
    this.name,
    this.url,
  }) : super(name: name, url: url);

  final String name;
  final String url;

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
      );
}
