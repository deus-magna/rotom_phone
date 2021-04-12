import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

enum ButtonForm { Stadium, Circular }

abstract class TypeButton {
  factory TypeButton(Type type) {
    switch (type) {
      case Type.Water:
        return WaterBuuton();
      case Type.Grass:
        return GrassBuuton();
      case Type.Poison:
        return PoisonBuuton();
      default:
        return null;
    }
  }

  Widget build(
      {@required BuildContext context,
      @required VoidCallback onPressed,
      ButtonForm form = ButtonForm.Circular});
}

class WaterBuuton implements TypeButton {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Color(0xFF559EDF),
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: StadiumBorder(),
  );

  @override
  Widget build(
      {@required BuildContext context,
      ButtonForm form = ButtonForm.Circular,
      @required VoidCallback onPressed}) {
    final Widget svg = SvgPicture.asset(
      'assets/images/types/poison.svg',
      height: 16,
    );

    return form == ButtonForm.Circular
        ? _RoundedType(
            image: svg,
            color: Color(0xFF5DBE62),
          )
        : ElevatedButton(
            style: raisedButtonStyle,
            onPressed: onPressed,
            child: Row(
              children: [
                Icon(Icons.whatshot_rounded),
                SizedBox(width: 5),
                Text('Water'),
              ],
            ),
          );
  }
}

class GrassBuuton implements TypeButton {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Color(0xFF5DBE62),
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: StadiumBorder(),
  );

  @override
  Widget build(
      {@required BuildContext context,
      ButtonForm form = ButtonForm.Circular,
      @required VoidCallback onPressed}) {
    final Widget svg = SvgPicture.asset(
      'assets/images/types/poison.svg',
      height: 16,
    );
    return form == ButtonForm.Circular
        ? _RoundedType(
            image: svg,
            color: Color(0xFF5DBE62),
          )
        : ElevatedButton(
            style: raisedButtonStyle,
            onPressed: onPressed,
            child: Row(
              children: [
                Icon(Icons.whatshot_rounded),
                SizedBox(width: 5),
                Text('Grass'),
              ],
            ),
          );
  }
}

class PoisonBuuton implements TypeButton {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Color(0xFFB563CE),
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: StadiumBorder(),
  );

  @override
  Widget build(
      {@required BuildContext context,
      ButtonForm form = ButtonForm.Circular,
      @required VoidCallback onPressed}) {
    final Widget svg = SvgPicture.asset(
      'assets/images/types/poison.svg',
      height: 16,
    );

    return form == ButtonForm.Circular
        ? _RoundedType(
            image: svg,
            color: Color(0xFFB563CE),
          )
        : ElevatedButton(
            style: raisedButtonStyle,
            onPressed: onPressed,
            child: Row(
              children: [
                svg,
                SizedBox(width: 5),
                Text('Poison'),
              ],
            ),
          );
  }
}

class _RoundedType extends StatelessWidget {
  final Widget image;
  final Color color;

  const _RoundedType({Key key, @required this.image, @required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: image,
      decoration: new BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
