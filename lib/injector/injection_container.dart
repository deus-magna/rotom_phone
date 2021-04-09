import 'package:get_it/get_it.dart';
import 'init_pokedex.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await initPokedex();
}
