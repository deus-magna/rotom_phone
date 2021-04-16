import 'package:flutter/material.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_specie.dart';
import 'package:rotom_phone/presentation/widgets/rounded_card.dart';
import '../../../../core/utils/pokemon_utils.dart' as pokemonUtils;

class PokedexEntry extends StatefulWidget {
  final List<FlavorTextEntry> entries;

  const PokedexEntry({
    Key key,
    @required this.entries,
  }) : super(key: key);

  @override
  _PokedexEntryState createState() => _PokedexEntryState();
}

class _PokedexEntryState extends State<PokedexEntry> {
  PageController _controller;
  int _selectedPage;
  List<FlavorTextEntry> get entries => widget.entries;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _selectedPage = 0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _animateToPage(index) {
    setState(() => _selectedPage = index);
    _controller.animateToPage(index,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  _nextPage() {
    _controller.nextPage(
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    if (_selectedPage < entries.length - 1) {
      setState(() => _selectedPage = _selectedPage + 1);
    }
  }

  _prevPage() {
    _controller.previousPage(
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    if (_selectedPage > 0) {
      setState(() => _selectedPage = _selectedPage - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RoundedCard(
      child: Column(
        children: [
          EntryVersionList(
            entries: entries,
            onItemSelected: _animateToPage,
            selectedIndex: _selectedPage,
          ),
          SizedBox(height: 10),
          Container(
            height: size.height * 0.117,
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: IconButton(
                        icon: Icon(Icons.arrow_left), onPressed: _prevPage)),
                Expanded(
                  flex: 6,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: widget.entries.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Text(
                          widget.entries[index]?.flavorText
                                  ?.replaceAll('\n', ' ') ??
                              'unknown',
                          maxLines: 5,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: IconButton(
                        icon: Icon(Icons.arrow_right), onPressed: _nextPage)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EntryVersionList extends StatelessWidget {
  const EntryVersionList({
    Key key,
    @required this.entries,
    this.onItemSelected,
    this.selectedIndex = 0,
  }) : super(key: key);

  final List<FlavorTextEntry> entries;
  final Function(int) onItemSelected;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      child: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) => EntryVersion(
          name: entries[index].versionAcronym,
          color: pokemonUtils.versionColor(entries[index].version.name),
          isSelected: selectedIndex == index,
          onTap: () => onItemSelected(index),
        ),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class EntryVersion extends StatelessWidget {
  final Color color;
  final String name;
  final Function onTap;
  final bool isSelected;

  const EntryVersion({
    Key key,
    this.color = Colors.grey,
    @required this.name,
    this.onTap,
    this.isSelected = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isSelected ? 1 : 0.5,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: nameColor(name),
            ),
          )),
        ),
      ),
    );
  }

  Color nameColor(String name) {
    switch (name) {
      case 'Wh':
      case 'W2':
      case 'Lgp':
        return Colors.black;
      default:
        return Colors.white;
    }
  }
}
