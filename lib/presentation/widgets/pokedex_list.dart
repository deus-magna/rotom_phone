import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rotom_phone/core/framework/colors.dart';
import 'package:rotom_phone/data/model/pokedex/pokedex_entry_model.dart';
import '../../core/extensions/string_extension.dart';

class PokedexList extends StatefulWidget {
  final List<PokedexEntryModel> pokedexEntries;
  final Function(int) nextPage;

  const PokedexList({
    Key key,
    @required this.pokedexEntries,
    @required this.nextPage,
  }) : super(key: key);

  @override
  _PokedexListState createState() => _PokedexListState();
}

class _PokedexListState extends State<PokedexList> {
  ScrollController _scrollController = ScrollController();
  List<PokedexEntryModel> _localPokedexEntries = [];
  int offset = 0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        widget.nextPage(offset += 40);
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
    _localPokedexEntries.addAll(widget.pokedexEntries);

    return ListView.builder(
      controller: _scrollController,
      itemCount: _localPokedexEntries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: primary),
          child: Stack(
            children: [
              _PokemonEntryActions(),
              _BackgroundPokeball(),
              _PokemonId(id: _localPokedexEntries[index].getPokemonId()),
              Row(
                children: [
                  _OfficialArtwork(
                    artwork: _localPokedexEntries[index].officialArtwork,
                  ),
                  _PokemonName(name: _localPokedexEntries[index].name),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PokemonEntryActions extends StatelessWidget {
  const _PokemonEntryActions({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      child: IconButton(
          icon: Icon(Icons.favorite_border_rounded),
          onPressed: () => print('add to favorite')),
    );
  }
}

class _BackgroundPokeball extends StatelessWidget {
  const _BackgroundPokeball({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.15,
      child: Image.asset(
        'assets/images/pokeball_filled.png',
        height: 90,
      ),
    );
  }
}

class _OfficialArtwork extends StatelessWidget {
  const _OfficialArtwork({
    Key key,
    @required this.artwork,
  }) : super(key: key);

  final String artwork;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: FadeInImage(
          placeholder: AssetImage('assets/images/white_pokeball.png'),
          height: 60,
          image: CachedNetworkImageProvider(artwork)),
    );
  }
}

class _PokemonName extends StatelessWidget {
  const _PokemonName({
    Key key,
    @required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name.capitalize(),
      style: TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

class _PokemonId extends StatelessWidget {
  const _PokemonId({
    Key key,
    @required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: -10,
      child: Text(
        id,
        style: TextStyle(
            color: Colors.white.withOpacity(0.3),
            fontSize: 50,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
