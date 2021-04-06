import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotom_phone/presentation/cubit/pokedex/pokedex_cubit.dart';
import 'package:rotom_phone/presentation/widgets/pokedex_list.dart';
import '../../injection_container.dart';
import '../../core/extensions/string_extension.dart';

class PokedexView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => sl<PokedexCubit>(),
        child: BlocBuilder<PokedexCubit, PokedexState>(
          builder: (context, state) {
            if (state is PokedexInitial) {
              return Container(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      final pokedexCubit = context.read<PokedexCubit>();
                      pokedexCubit.getPokemonList(40, 0);
                    },
                    child: Text('Init Pokedex'),
                  ),
                ),
              );
            } else if (state is PokedexLoading) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is PokedexLoaded) {
              final pokedexEntries = state.pokedexEntries;
              return PokedexList(
                pokedexEntries: pokedexEntries,
                nextPage: () {
                  final pokedexCubit = context.read<PokedexCubit>();
                  pokedexCubit.getPokemonList(40, 40);
                },
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
