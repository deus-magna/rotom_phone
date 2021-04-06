import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotom_phone/presentation/cubit/pokedex/pokedex_cubit.dart';
import 'package:rotom_phone/presentation/widgets/pokedex_list.dart';
import '../../injection_container.dart';

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
                      pokedexCubit.getFirstPokedexPage();
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
                nextPage: (offset) {
                  final pokedexCubit = context.read<PokedexCubit>();
                  pokedexCubit.getNextPokedexPage(40, offset);
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
