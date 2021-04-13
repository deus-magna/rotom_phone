import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'pokemon_menu_background.dart';

class PokemonMenu extends StatefulWidget {
  final int initialIndex;
  final Function(int) onItemChanged;

  const PokemonMenu({
    Key key,
    this.initialIndex = 0,
    this.onItemChanged,
  }) : super(key: key);

  @override
  _PokemonMenuState createState() => _PokemonMenuState();
}

class _PokemonMenuState extends State<PokemonMenu> {
  int _currentIndex;
  final List<String> _items = [
    'assets/images/about_menu.svg',
    'assets/images/stats_menu.svg',
    'assets/images/about_menu.svg',
    'assets/images/about_menu.svg'
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25),
      child: Stack(
        children: [
          PokemonMenuBackground(),
          _buildPokemonMenuItems(MediaQuery.of(context).size),
        ],
      ),
    );
  }

  Widget _buildPokemonMenuItems(Size size) {
    return Container(
      width: size.width * 0.63,
      height: size.height * 0.058,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
            _items.length,
            (index) => index == _currentIndex
                ? _buildSelectedButton(index)
                : _buildButton(index)),
      ),
    );
  }

  Widget _buildButton(int index) => GestureDetector(
        onTap: () => _changeIndex(index),
        child: SvgPicture.asset(
          _items[index],
        ),
      );

  Widget _buildSelectedButton(int index) => SvgPicture.asset(
        _items[index],
        height: 30,
        color: Colors.black,
      );

  _changeIndex(int index) {
    setState(() => _currentIndex = index);
    widget.onItemChanged(index);
  }
}
