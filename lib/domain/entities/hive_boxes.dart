import 'package:hive/hive.dart';

abstract class HiveBox {
  Future<void> put(dynamic key, String data);
  String get(dynamic key, {String defaultValue});
}

class PokedexBox implements HiveBox {
  final Box<String> box;
  PokedexBox(this.box);

  @override
  Future<void> put(dynamic key, String data) => box.put(key, data);

  @override
  String get(key, {String defaultValue}) =>
      box.get(key, defaultValue: defaultValue);
}

class PokemonDetailBox implements HiveBox {
  final Box<String> box;
  PokemonDetailBox(this.box);

  @override
  Future<void> put(dynamic key, String data) => box.put(key, data);

  @override
  String get(key, {String defaultValue}) =>
      box.get(key, defaultValue: defaultValue);
}
