import 'package:flutter/material.dart';
import 'package:rotom_phone/data/model/pokemon/pokedex_entry_model.dart';
import '../../core/extensions/string_extension.dart';

class PokedexList extends StatefulWidget {
  final List<PokedexEntryModel> pokedexEntries;
  final Function nextPage;

  const PokedexList({Key key, this.pokedexEntries, this.nextPage})
      : super(key: key);

  @override
  _PokedexListState createState() => _PokedexListState();
}

class _PokedexListState extends State<PokedexList> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('Debemos agregar mas pokes');
        widget.nextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.pokedexEntries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            margin: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.red[400]),
            child: Stack(
              children: [
                Positioned(
                  right: 5,
                  bottom: -5,
                  child: Text(
                    widget.pokedexEntries[index].getPokemonId(),
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.3),
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FadeInImage(
                          placeholder:
                              AssetImage('assets/images/white_pokeball.png'),
                          height: 75,
                          image: NetworkImage(
                              widget.pokedexEntries[index].officialArtwork)),
                    ),
                    Text(
                      widget.pokedexEntries[index].name.capitalize(),
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ));
      },
    );
  }
}
