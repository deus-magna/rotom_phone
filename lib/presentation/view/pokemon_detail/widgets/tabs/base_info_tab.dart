import 'package:flutter/material.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_specie.dart';
import 'package:rotom_phone/presentation/widgets/pokemon_type_button.dart';

class BaseInfoTab extends StatelessWidget {
  final Pokemon pokemon;

  const BaseInfoTab({
    Key key,
    @required this.pokemon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final types =
        pokemon.pokemonInfo.types.map((element) => element.type).toList();
    final pokemonTypes = types
        .map((type) => PokemonTypeButton(
              type: type,
              onPressed: () => print(type.url),
              form: ButtonForm.Stadium,
            ))
        .toList();
    return Container(
      child: Column(
        children: [
          PokedexEntry(entries: pokemon.pokemonSpecie.flavorTextEntries),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pokemonTypes),
        ],
      ),
    );
  }
}

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
  String version = '';
  @override
  Widget build(BuildContext context) {
    final entriesString =
        widget.entries.where((entry) => entry.language.name == 'en').toList();

    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(version),
          ),
          Container(
            height: 70,
            child: PageView.builder(
              itemCount: entriesString.length,
              itemBuilder: (context, index) {
                version = entriesString[index]?.version?.name ?? 'unknown';
                return Center(
                  child: Text(
                    entriesString[index]?.flavorText?.replaceAll('\n', ' ') ??
                        'unknown',
                    maxLines: 4,
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
