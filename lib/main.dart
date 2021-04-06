import 'package:flutter/material.dart';
import 'package:rotom_phone/presentation/view/pokedex_view.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rotom Phone',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: PokedexView(),
    );
  }
}
