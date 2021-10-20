import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotom_phone/core/utils/enums.dart';
import 'package:rotom_phone/domain/entities/resource_path.dart';
import '../../core/utils/pokemon_utils.dart' as pokemon_utils;

enum ButtonForm { stadium, circular }

class PokemonTypeButton extends StatelessWidget {
  const PokemonTypeButton({
    Key key,
    @required this.type,
    this.onPressed,
    this.form = ButtonForm.circular,
  }) : super(key: key);

  final ResourcePath type;
  final Function onPressed;
  final ButtonForm form;

  @override
  Widget build(BuildContext context) {
    final pokemonType = pokemon_utils.pokemonType(type.name);

    var color = const Color(0xFF000000);

    switch (pokemonType) {
      case PokemonType.grass:
        color = const Color(0xFF5DBE62);
        break;
      case PokemonType.poison:
        color = const Color(0xFFB563CE);
        break;
      case PokemonType.water:
        color = const Color(0xFF559EDF);
        break;
      case PokemonType.tBug:
        color = const Color(0xFF9DC130);
        break;
      case PokemonType.dark:
        color = const Color(0xFF5F606D);
        break;
      case PokemonType.dragon:
        color = const Color(0xFF0773C7);
        break;
      case PokemonType.electric:
        color = const Color(0xFFEDD53F);
        break;
      case PokemonType.fairy:
        color = const Color(0xFFEF97E6);
        break;
      case PokemonType.fighting:
        color = const Color(0xFFD94256);
        break;
      case PokemonType.fire:
        color = const Color(0xFFF8A54F);
        break;
      case PokemonType.flying:
        color = const Color(0xFF9BB4E8);
        break;
      case PokemonType.ghost:
        color = const Color(0xFF6970C5);
        break;
      case PokemonType.ground:
        color = const Color(0xFFD78555);
        break;
      case PokemonType.ice:
        color = const Color(0xFF7ED4C9);
        break;
      case PokemonType.normal:
        color = const Color(0xFF9A9DA1);
        break;
      case PokemonType.steel:
        color = const Color(0xFF5596A4);
        break;
      case PokemonType.psychic:
        color = const Color(0xFFF87C7A);
        break;
      case PokemonType.rock:
        color = const Color(0xFFCEC18C);
        break;
      default:
    }
    return _buildPokemonTypeButton(type.name, color, form);
  }

  Widget _buildPokemonTypeButton(String name, Color color, ButtonForm form) {
    return form == ButtonForm.circular
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
    final raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black87,
      primary: color,
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      shape: const StadiumBorder(),
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
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}

class _RoundedType extends StatelessWidget {
  const _RoundedType({
    Key key,
    @required this.color,
    @required this.name,
    this.margin = const EdgeInsets.only(right: 10),
  }) : super(key: key);

  final String name;
  final Color color;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final Widget svg = SvgPicture.asset('assets/images/types/$name.svg');
    return Container(
      margin: margin,
      child: svg,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
