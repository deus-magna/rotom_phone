import 'package:flutter/material.dart';
import 'package:rotom_phone/core/framework/decorations.dart';

class RoundedCard extends StatelessWidget {
  const RoundedCard({
    Key key,
    this.margin = const EdgeInsets.all(20),
    this.padding = const EdgeInsets.all(10),
    this.borderRadius = 10,
    this.child,
  }) : super(key: key);

  final EdgeInsets margin;
  final EdgeInsets padding;
  final double borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardTheme = CardTheme.of(context);

    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: boxSahdow,
        color: cardTheme.color ?? theme.cardColor,
      ),
      child: child ?? const SizedBox.shrink(),
    );
  }
}

class RoundedCardTitle extends StatelessWidget {
  const RoundedCardTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
    );
  }
}
