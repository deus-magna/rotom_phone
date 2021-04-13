import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotom_phone/core/framework/colors.dart';

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

class PokemonMenuBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ClipPath(
          clipper: BackMenuClipper(),
          child: Container(
            width: size.width * 0.84,
            height: size.height * 0.058,
            color: secondary,
          ),
        ),
        ClipPath(
          clipper: FrontMenuClipper(),
          child: Container(
            width: size.width * 0.63,
            height: size.height * 0.058,
            color: primary,
          ),
        ),
      ],
    );
  }
}

class FrontMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 235;
    final double _yScaling = size.height / 48;
    path.lineTo(218.823 * _xScaling, 48 * _yScaling);
    path.cubicTo(
      218.823 * _xScaling,
      48 * _yScaling,
      24 * _xScaling,
      48 * _yScaling,
      24 * _xScaling,
      48 * _yScaling,
    );
    path.cubicTo(
      5.520175485111373 * _xScaling,
      47.98964469921821 * _yScaling,
      -6.018519597641028 * _xScaling,
      27.978175768780243 * _yScaling,
      3.2303606133441356 * _xScaling,
      11.979355931799141 * _yScaling,
    );
    path.cubicTo(
      5.841551644321641 * _xScaling,
      7.462487520536605 * _yScaling,
      9.853179921931025 * _xScaling,
      3.919254254220057 * _yScaling,
      14.658 * _xScaling,
      1.886 * _yScaling,
    );
    path.cubicTo(
      17.613406273553437 * _xScaling,
      0.6352478724074149 * _yScaling,
      20.790830574282808 * _xScaling,
      -0.006222819167828856 * _yScaling,
      24 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      24 * _xScaling,
      0 * _yScaling,
      234.62 * _xScaling,
      0 * _yScaling,
      234.62 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      234.62 * _xScaling,
      0 * _yScaling,
      218.82 * _xScaling,
      48 * _yScaling,
      218.82 * _xScaling,
      48 * _yScaling,
    );
    path.cubicTo(
      218.82 * _xScaling,
      48 * _yScaling,
      218.823 * _xScaling,
      48 * _yScaling,
      218.823 * _xScaling,
      48 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class BackMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 315;
    final double _yScaling = size.height / 48;
    path.lineTo(294.615 * _xScaling, 48 * _yScaling);
    path.cubicTo(
      294.615 * _xScaling,
      48 * _yScaling,
      24 * _xScaling,
      48 * _yScaling,
      24 * _xScaling,
      48 * _yScaling,
    );
    path.cubicTo(
      5.524791385931977 * _xScaling,
      48 * _yScaling,
      -6.022213997860538 * _xScaling,
      28.000000000000014 * _yScaling,
      3.2153903091734684 * _xScaling,
      12.000000000000005 * _yScaling,
    );
    path.cubicTo(
      7.50257738807143 * _xScaling,
      4.574374157795928 * _yScaling,
      15.425625842204072 * _xScaling,
      0 * _yScaling,
      24 * _xScaling,
      -1.7763568394002505e-15 * _yScaling,
    );
    path.cubicTo(
      24 * _xScaling,
      -1.7763568394002505e-15 * _yScaling,
      313.41 * _xScaling,
      -1.7763568394002505e-15 * _yScaling,
      313.41 * _xScaling,
      -1.7763568394002505e-15 * _yScaling,
    );
    path.cubicTo(
      313.932 * _xScaling,
      -1.7763568394002505e-15 * _yScaling,
      314.46000000000004 * _xScaling,
      0.016999999999997684 * _yScaling,
      314.97900000000004 * _xScaling,
      0.049999999999998934 * _yScaling,
    );
    path.cubicTo(
      314.97900000000004 * _xScaling,
      0.049999999999998934 * _yScaling,
      294.616 * _xScaling,
      47.999 * _yScaling,
      294.616 * _xScaling,
      47.999 * _yScaling,
    );
    path.cubicTo(
      294.616 * _xScaling,
      47.999 * _yScaling,
      294.615 * _xScaling,
      48 * _yScaling,
      294.615 * _xScaling,
      48 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
