import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotom_phone/injector/injection_container.dart';
import 'package:rotom_phone/presentation/cubit/pokemon_detail/pokemon_detail_cubit.dart';

class PokemonDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int entryNumber = ModalRoute.of(context).settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (_) => sl<PokemonDetailCubit>()..init(entryNumber),
        child: BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
          builder: (context, state) {
            if (state is PokemonDetailInitial) {
              final pokemonDetailCubit = context.read<PokemonDetailCubit>();
              pokemonDetailCubit.getPokemonDetal(entryNumber);
              return Container();
            } else if (state is PokemonDetailLoading) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is PokemonDetailLoaded) {
              final pokemon = state.pokemonDetail;
              return Container(
                color: Colors.red,
                width: double.infinity,
                child: ListView(
                  children: [
                    Text(pokemon.name),
                    Container(
                        color: Colors.green,
                        width: double.infinity,
                        child: Text(pokemon.flavorTextEntries.first.flavorText
                            .replaceAll('\n', ''))),
                  ],
                ),
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
    );
  }
}
