import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';
import 'package:rotom_phone/presentation/cubit/pokemon_detail/pokemon_detail_cubit.dart';
import 'package:rotom_phone/presentation/view/pokemon_detail/widgets/pokemon_menu/pokemon_menu.dart';
import 'package:rotom_phone/presentation/view/pokemon_detail/widgets/tabs/base_info_tab.dart';
import 'package:rotom_phone/presentation/view/pokemon_detail/widgets/tabs/evolutions_tab.dart';
import 'package:rotom_phone/presentation/view/pokemon_detail/widgets/tabs/moves_tab.dart';
import 'package:rotom_phone/presentation/view/pokemon_detail/widgets/tabs/stats_tab.dart';

class PokemonTabs extends StatelessWidget {
  const PokemonTabs({
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
                BaseInfoTab(pokemon: pokemon),
                StatsTab(pokemon: pokemon),
                MovesTab(pokemon: pokemon),
                EvolutionsTab(),
              ],
            );
          },
        ),
      ],
    );
  }
}
