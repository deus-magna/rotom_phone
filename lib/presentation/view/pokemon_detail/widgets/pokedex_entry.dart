import 'package:flutter/material.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_specie.dart';

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
              itemCount: widget.entries.length,
              itemBuilder: (context, index) {
                version = widget.entries[index]?.version?.name ?? 'unknown';
                return Center(
                  child: Text(
                    widget.entries[index]?.flavorText?.replaceAll('\n', ' ') ??
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
