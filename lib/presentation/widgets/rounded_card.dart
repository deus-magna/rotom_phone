import 'package:flutter/material.dart';
import 'package:rotom_phone/core/framework/decorations.dart';

class RoundedCard extends StatelessWidget {
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double borderRadius;
  final Widget child;

  const RoundedCard({
    Key key,
    this.margin = const EdgeInsets.all(20),
    this.padding = const EdgeInsets.all(10),
    this.borderRadius = 10,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final CardTheme cardTheme = CardTheme.of(context);

    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: boxSahdow,
        color: cardTheme.color ?? theme.cardColor,
      ),
      child: child ?? SizedBox.shrink(),
    );
  }
}
