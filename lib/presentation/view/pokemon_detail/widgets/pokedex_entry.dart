import 'package:flutter/material.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_specie.dart';
import 'package:rotom_phone/presentation/widgets/rounded_card.dart';
import '../../../../core/utils/pokemon_utils.dart' as pokemonUtils;

class EntryVersion extends StatelessWidget {
  final Color color;
  final String name;

  const EntryVersion({
    Key key,
    this.color = Colors.grey,
    @required this.name,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: Text(name)),
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

  List<FlavorTextEntry> get entries => widget.entries;

  @override
  Widget build(BuildContext context) {
    final versions = entries
        .map(
          (entry) => EntryVersion(
            name: entry.versionAcronym,
            color: pokemonUtils.versionColor(entry.version.name),
          ),
        )
        .toList();

    return RoundedCard(
      child: Column(
        children: [
          Container(
            height: 50,
            child: ListView(
              children: versions,
              scrollDirection: Axis.horizontal,
            ),
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
