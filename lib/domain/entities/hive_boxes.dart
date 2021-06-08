import 'package:hive/hive.dart';

abstract class HiveBox {
  Future<void> put(dynamic key, String data);
  String get(dynamic key, {String defaultValue});
}

class PokedexBox implements HiveBox {
  PokedexBox(this.box);

  final Box<String> box;

  @override
  Future<void> put(dynamic key, String data) => box.put(key, data);

  @override
  String get(key, {String defaultValue}) =>
      box.get(key, defaultValue: defaultValue);
}

class PokemonSpecieBox implements HiveBox {
  PokemonSpecieBox(this.box);

  final Box<String> box;

  @override
  Future<void> put(dynamic key, String data) => box.put(key, data);

  @override
  String get(key, {String defaultValue}) =>
      box.get(key, defaultValue: defaultValue);
}

class PokemonInfoBox implements HiveBox {
  PokemonInfoBox(this.box);

  final Box<String> box;

  @override
  Future<void> put(dynamic key, String data) => box.put(key, data);

  @override
  String get(key, {String defaultValue}) =>
      box.get(key, defaultValue: defaultValue);
}

class EvolutionChainBox implements HiveBox {
  EvolutionChainBox(this.box);

  final Box<String> box;

  @override
  Future<void> put(dynamic key, String data) => box.put(key, data);

  @override
  String get(key, {String defaultValue}) =>
      box.get(key, defaultValue: defaultValue);
}
