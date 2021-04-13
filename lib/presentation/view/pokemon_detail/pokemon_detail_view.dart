import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotom_phone/core/framework/colors.dart';
import 'package:rotom_phone/injector/injection_container.dart';
import 'package:rotom_phone/presentation/cubit/pokemon_detail/pokemon_detail_cubit.dart';
import 'package:rotom_phone/presentation/view/pokemon_detail/widgets/header/pokemon_header.dart';
import 'package:rotom_phone/presentation/widgets/pokedex_header.dart';

import 'widgets/tabs/pokemon_tabs.dart';

class PokemonDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int entryNumber = ModalRoute.of(context).settings.arguments as int;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.favorite_border_rounded),
              onPressed: () => print('Add to favorite')),
        ],
        backgroundColor: primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<PokemonDetailCubit>()..init(entryNumber),
            ),
            BlocProvider(create: (_) => PokemonMenuCubit()),
          ],
          child: BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
            builder: (context, state) {
              if (state is PokemonDetailInitial) {
                final pokemonDetailCubit = context.read<PokemonDetailCubit>();
                pokemonDetailCubit.getPokemonDetals(entryNumber);
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is PokemonDetailLoading) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is PokemonDetailLoaded) {
                final pokemonDetail = state.pokemonDetail;
                return Column(
                  children: [
                    PokedexHeader(
                      child: PokemonHeader(pokemon: pokemonDetail),
                      height: size.height * 0.25,
                      backgroundWidget: Positioned(
                        top: -40,
                        right: -20,
                        child: Image.asset(
                          'assets/images/pokeball_header.png',
                          height: 300,
                        ),
                      ),
                    ),
                    PokemonTabs(pokemon: pokemonDetail),
                  ],
                );
              } else if (state is PokemonDetailError) {
                return Container(
                  child: Center(
                    child: Text(state.message),
                  ),
                );
              } else {
                return Container(
                  child: Center(
                    child: Text('Error'),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
