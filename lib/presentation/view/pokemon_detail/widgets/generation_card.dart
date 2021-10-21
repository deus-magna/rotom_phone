import 'package:flutter/material.dart';
import 'package:rotom_phone/core/framework/colors.dart';
import 'package:rotom_phone/presentation/widgets/rounded_card.dart';

class GenerationsCard extends StatefulWidget {
  const GenerationsCard({
    Key key,
    @required this.onItemSelected,
    this.initialIndex = 6,
  }) : super(key: key);

  final Function(int) onItemSelected;
  final int initialIndex;

  @override
  _GenerationsCardState createState() => _GenerationsCardState();
}

class _GenerationsCardState extends State<GenerationsCard> {
  int _currentIndex;
  @override
  void initState() {
    _currentIndex = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const RoundedCardTitle(title: 'Generation'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GenerationButton(
                onPressed: () => changeSelectedItem(0),
                isSelected: _currentIndex == 0,
              ),
              GenerationButton(
                generation: 'II',
                onPressed: () => changeSelectedItem(1),
                isSelected: _currentIndex == 1,
              ),
              GenerationButton(
                generation: 'III',
                onPressed: () => changeSelectedItem(2),
                isSelected: _currentIndex == 2,
              ),
              GenerationButton(
                generation: 'IV',
                onPressed: () => changeSelectedItem(3),
                isSelected: _currentIndex == 3,
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GenerationButton(
                generation: 'V',
                onPressed: () => changeSelectedItem(4),
                isSelected: _currentIndex == 4,
              ),
              GenerationButton(
                generation: 'VI',
                onPressed: () => changeSelectedItem(5),
                isSelected: _currentIndex == 5,
              ),
              GenerationButton(
                generation: 'VII',
                onPressed: () => changeSelectedItem(6),
                isSelected: _currentIndex == 6,
              ),
              GenerationButton(
                generation: 'VIII',
                onPressed: () => changeSelectedItem(7),
                isSelected: _currentIndex == 7,
              )
            ],
          ),
        ],
      ),
    );
  }

  void changeSelectedItem(int index) {
    setState(() => _currentIndex = index);
    widget.onItemSelected(index);
  }
}

class GenerationButton extends StatelessWidget {
  const GenerationButton({
    Key key,
    this.generation = 'I',
    this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  final String generation;
  final Function onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? primary : Colors.grey[100],
        ),
        child: Center(
          child: Text(
            generation,
            style: TextStyle(
              fontSize: 22,
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
