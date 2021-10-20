import 'package:flutter/material.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';
import 'package:rotom_phone/presentation/widgets/progress_bar.dart';

class StatsTab extends StatefulWidget {
  const StatsTab({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  _StatsTabState createState() => _StatsTabState();
}

class _StatsTabState extends State<StatsTab>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  Pokemon get pokemon => widget.pokemon;

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _controller,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);

    _controller.forward();
  }

  List<Widget> generateStatWidget() {
    return [
      Stat(
          animation: _animation,
          label: 'HP',
          value: pokemon.info.stats[0].baseStat),
      const SizedBox(height: 14),
      Stat(
          animation: _animation,
          label: 'ATK',
          value: pokemon.info.stats[1].baseStat),
      const SizedBox(height: 14),
      Stat(
          animation: _animation,
          label: 'DEF',
          value: pokemon.info.stats[2].baseStat),
      const SizedBox(height: 14),
      Stat(
          animation: _animation,
          label: 'SATK',
          value: pokemon.info.stats[3].baseStat),
      const SizedBox(height: 14),
      Stat(
          animation: _animation,
          label: 'SDEF',
          value: pokemon.info.stats[4].baseStat),
      const SizedBox(height: 14),
      Stat(
          animation: _animation,
          label: 'SPD',
          value: pokemon.info.stats[5].baseStat),
      const SizedBox(height: 14),
      Stat(
        animation: _animation,
        label: 'TOT',
        value: 100,
        progress: 100 / 600,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ...generateStatWidget(),
        ],
      ),
    );
  }
}

class Stat extends StatelessWidget {
  const Stat({
    @required this.animation,
    @required this.label,
    @required this.value,
    this.progress,
  });

  final Animation animation;
  final String label;
  final double progress;
  final num value;

  Color getStatColor(int value) {
    if (value <= 40) return Colors.red;
    if (value <= 60) return Colors.orange;
    if (value <= 80) return Colors.orange[200];
    if (value <= 100) return Colors.yellow;
    if (value <= 140) return Colors.lightGreen;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final currentProgress = progress ?? value / 200;

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text('$value',
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              )),
        ),
        Expanded(
          flex: 5,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, widget) => ProgressBar(
              progress: animation.value * currentProgress,
              color: getStatColor(value),
              enableAnimation: animation.value == 1,
            ),
          ),
        ),
      ],
    );
  }
}
