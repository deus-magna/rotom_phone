import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotom_phone/injector/injection_container.dart';
import 'package:rotom_phone/presentation/cubit/pokemon_detail/pokemon_detail_cubit.dart';
import 'package:rotom_phone/presentation/view/pokemon_detail/widgets/header/pokemon_header.dart';
import 'package:rotom_phone/presentation/widgets/pokedex_header.dart';

import 'widgets/tabs/pokemon_tabs.dart';

class PokemonDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final entryNumber = ModalRoute.of(context).settings.arguments as int;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.favorite_border_rounded),
              onPressed: () => print('Add to favorite')),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
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
                context
                    .read<PokemonDetailCubit>()
                    .getPokemonDetails(entryNumber);
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PokemonDetailLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PokemonDetailLoaded) {
                final pokemonDetail = state.pokemonDetail;
                return Column(
                  children: [
                    PokedexHeader(
                      child: PokemonHeader(pokemon: pokemonDetail),
                      innerHeight: size.height * 0.29,
                      outerHeight: size.height * 0.33,
                      height: size.height * 0.25,
                      backgroundWidget: Positioned(
                        top: 120,
                        right: -10,
                        child: RotationTransition(
                          turns: const AlwaysStoppedAnimation(-30 / 365),
                          child: Image.asset(
                            'assets/images/pokeball_header.png',
                            height: size.height * 0.25,
                          ),
                        ),
                      ),
                    ),
                    PokemonTabs(pokemon: pokemonDetail),
                  ],
                );
              } else if (state is PokemonDetailError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text('Error'));
              }
            },
          ),
        ),
      ),
    );
  }
}
