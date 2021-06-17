import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    this.color = Colors.red,
    this.backgroundColor = Colors.grey,
    this.enableAnimation = true,
    @required this.progress,
  });

  final Color backgroundColor;
  final Color color;
  final double progress;
  final bool enableAnimation;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: color,
      ),
    );

    return Container(
      clipBehavior: Clip.hardEdge,
      height: 8,
      alignment: Alignment.centerLeft,
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: Colors.grey[200],
      ),
      child: enableAnimation
          ? AnimatedAlign(
              duration: const Duration(milliseconds: 260),
              alignment: const Alignment(1, 0),
              widthFactor: progress,
              child: child,
            )
          : FractionallySizedBox(
              widthFactor: progress,
              child: child,
            ),
    );
  }
}
