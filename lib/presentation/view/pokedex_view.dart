import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotom_phone/data/model/pokedex/local_pokedex_entry_model.dart';
import 'package:rotom_phone/presentation/cubit/pokedex/pokedex_cubit.dart';
import 'package:rotom_phone/presentation/widgets/pokedex_header.dart';
import 'package:rotom_phone/presentation/widgets/pokedex_list.dart';
import '../../injector/injection_container.dart';

class PokedexView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => sl<PokedexCubit>(),
        child: BlocBuilder<PokedexCubit, PokedexState>(
          builder: (context, state) {
            if (state is PokedexInitial) {
              context.read<PokedexCubit>().getRegionalPokedex(1);
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PokedexLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PokedexLoaded) {
              final pokedexEntries = state.pokedexEntries;
              return _buildPokedexBody(context, pokedexEntries);
            } else if (state is PokedexError) {
              return Container(
                child: Center(
                  child: Text(state.message),
                ),
              );
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildPokedexBody(
      BuildContext context, List<LocalPokedexEntryModel> pokedexEntries) {
    return Column(
      children: [
        _pokedexHeader(context),
        Expanded(
          child: PokedexList(
            pokedexEntries: pokedexEntries,
            nextPage: (offset) {
              print('Nada que hacer aca');
            },
          ),
        ),
      ],
    );
  }

  Widget _pokedexHeader(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PokedexHeader(
      innerHeight: size.height * 0.29,
      outerHeight: size.height * 0.33,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.transparent,
        width: double.infinity,
        height: size.height * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pokédex',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.5),
                hintText: 'Search any Pokemon',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
