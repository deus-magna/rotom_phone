import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_specie.dart';
import 'package:rotom_phone/presentation/cubit/pokemon_detail/pokemon_detail_cubit.dart';
import 'package:rotom_phone/presentation/view/pokemon_detail/widgets/pokemon_menu/pokemon_menu.dart';
import 'package:rotom_phone/presentation/view/pokemon_detail/widgets/tabs/evolutions_tab.dart';
import 'package:rotom_phone/presentation/view/pokemon_detail/widgets/tabs/moves_tab.dart';
import 'package:rotom_phone/presentation/view/pokemon_detail/widgets/tabs/stats_tab.dart';

class PokemonDetailTabs extends StatelessWidget {
  const PokemonDetailTabs({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PokemonMenu(
          onItemChanged: (index) =>
              context.read<PokemonMenuCubit>().onItemChanged(index),
        ),
        BlocBuilder<PokemonMenuCubit, int>(
          builder: (context, state) {
            return IndexedStack(
              index: state,
              children: [
                Container(
                  height: 200,
                  child: PokedexEntry(
                    entries: pokemon.pokemonSpecie.flavorTextEntries,
                  ),
                ),
                StatsTab(),
                MovesTab(),
                EvolutionsTab(),
              ],
            );
          },
        ),
      ],
    );
  }
}

class PokedexEntry extends StatelessWidget {
  final List<FlavorTextEntry> entries;

  const PokedexEntry({Key key, @required this.entries}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final entriesString =
        entries.where((entry) => entry.language.name == 'en').toList();

    return Container(
      margin: EdgeInsets.all(20),
      child: PageView.builder(
        itemCount: entriesString.length,
        itemBuilder: (context, index) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(entriesString[index]?.version?.name ?? 'unknown'),
            SizedBox(height: 10),
            Text(
              entriesString[index]?.flavorText?.replaceAll('\n', ' ') ??
                  'unknown',
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }
}
