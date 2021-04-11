import 'package:flutter/material.dart';

enum Type {
  Bug,
  Dark,
  Dragon,
  Electric,
  Fairy,
  Fight,
  Fire,
  Flying,
  Ghost,
  Grass,
  Ground,
  Ice,
  Normal,
  Poison,
  Psychic,
  Rock,
  Steel,
  Water,
}

class TypeIndicator extends StatelessWidget {
  final String name;

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: StadiumBorder(),
  );

  TypeIndicator({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () => 'show type data',
        child: Row(
          children: [
            Icon(Icons.whatshot_rounded),
            SizedBox(width: 5),
            Text(name),
          ],
        ));
  }
}
