import 'package:flutter/material.dart';
import 'package:rotom_phone/presentation/view/pokedex_view.dart';
import 'package:rotom_phone/presentation/view/pokemon_detail_view.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/pokedex': (BuildContext context) => PokedexView(),
    '/pokemon_detail': (BuildContext context) => PokemonDetailView(),
  };
}
