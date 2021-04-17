import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotom_phone/core/utils/enums.dart';
import 'package:rotom_phone/domain/entities/resource_path.dart';
import '../../core/utils/pokemon_utils.dart' as pokemonUtils;

enum ButtonForm { Stadium, Circular }

class PokemonTypeButton extends StatelessWidget {
  final ResourcePath type;
  final Function onPressed;
  final ButtonForm form;

  const PokemonTypeButton({
    Key key,
    @required this.type,
    this.onPressed,
    this.form = ButtonForm.Circular,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pokemonType = pokemonUtils.pokemonType(type.name);

    Color color = Color(0xFF000000);

    switch (pokemonType) {
      case PokemonType.Grass:
        color = Color(0xFF5DBE62);
        break;
      case PokemonType.Poison:
        color = Color(0xFFB563CE);
        break;
      case PokemonType.Water:
        color = Color(0xFF559EDF);
        break;
      case PokemonType.Bug:
        color = Color(0xFF9DC130);
        break;
      case PokemonType.Dark:
        color = Color(0xFF5F606D);
        break;
      case PokemonType.Dragon:
        color = Color(0xFF0773C7);
        break;
      case PokemonType.Electric:
        color = Color(0xFFEDD53F);
        break;
      case PokemonType.Fairy:
        color = Color(0xFFEF97E6);
        break;
      case PokemonType.Fighting:
        color = Color(0xFFD94256);
        break;
      case PokemonType.Fire:
        color = Color(0xFFF8A54F);
        break;
      case PokemonType.Flying:
        color = Color(0xFF9BB4E8);
        break;
      case PokemonType.Ghost:
        color = Color(0xFF6970C5);
        break;
      case PokemonType.Ground:
        color = Color(0xFFD78555);
        break;
      case PokemonType.Ice:
        color = Color(0xFF7ED4C9);
        break;
      case PokemonType.Normal:
        color = Color(0xFF9A9DA1);
        break;
      case PokemonType.Steel:
        color = Color(0xFF5596A4);
        break;
      case PokemonType.Psychic:
        color = Color(0xFFF87C7A);
        break;
      case PokemonType.Rock:
        color = Color(0xFFCEC18C);
        break;
      default:
    }
    return _buildPokemonTypeButton(type.name, color, form);
  }

  Widget _buildPokemonTypeButton(String name, Color color, ButtonForm form) {
    return form == ButtonForm.Circular
        ? _RoundedType(name: name, color: color)
        : _StadiumType(name: name, color: color, onPressed: onPressed);
  }
}

class _StadiumType extends StatelessWidget {
  final String name;
  final Color color;
  final Function onPressed;

  const _StadiumType({
    Key key,
    @required this.name,
    @required this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black87,
      primary: color,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 10),
      shape: StadiumBorder(),
    );
    final Widget svg = SvgPicture.asset('assets/images/types/$name.svg');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: onPressed,
        child: Row(
          children: [
            svg,
            Text(
              name.toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}

class _RoundedType extends StatelessWidget {
  final String name;
  final Color color;

  final EdgeInsets margin;

  const _RoundedType({
    Key key,
    @required this.color,
    @required this.name,
    this.margin = const EdgeInsets.only(right: 10),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Widget svg = SvgPicture.asset('assets/images/types/$name.svg');
    return Container(
      margin: margin,
      child: svg,
      decoration: new BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
