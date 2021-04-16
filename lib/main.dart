import 'package:flutter/material.dart';
import 'package:rotom_phone/core/framework/colors.dart';
import 'core/router/routing.dart';
import 'injector/injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rotom Phone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: primary,
        accentColor: primary,
      ),
      darkTheme: ThemeData.dark(),
      initialRoute: '/pokedex',
      routes: getApplicationRoutes(),
    );
  }
}
