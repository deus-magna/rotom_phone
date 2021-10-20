import 'package:flutter/material.dart';
import 'package:rotom_phone/core/framework/colors.dart';
import 'package:rotom_phone/presentation/view/pokemon_detail/widgets/pokemon_menu/menu_clippers.dart';

class GalarButton extends StatelessWidget {
  const GalarButton({
    Key key,
    @required this.title,
    @required this.subtitle,
    this.icon,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const style = TextStyle(
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontSize: 14,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          _buildButtonBack(style),
          _buildButtonFront(size, style),
        ],
      ),
    );
  }

  ButtonTheme _buildButtonBack(TextStyle style) {
    final raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: secondary,
      minimumSize: const Size(88, 44),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: const StadiumBorder(),
    );

    return ButtonTheme(
      height: 44,
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () => print('Show ability'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(subtitle, style: style),
            SizedBox(width: 10),
            icon != null ? icon : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Positioned _buildButtonFront(Size size, TextStyle style) {
    return Positioned(
      top: 2,
      child: ClipPath(
        clipper: FrontMenuClipper(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 44,
          width: size.width * 0.62,
          color: primary,
          alignment: Alignment.centerLeft,
          child: Text(title, style: style),
        ),
      ),
    );
  }
}
