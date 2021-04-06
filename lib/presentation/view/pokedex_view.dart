import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotom_phone/presentation/cubit/pokedex/pokedex_cubit.dart';
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
              return ListView.builder(
                itemCount: pokedexEntries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red[400]),
                      child: Stack(
                        children: [
                          Positioned(
                            right: 5,
                            bottom: -5,
                            child: Text(
                              pokedexEntries[index].getPokemonId(),
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.3),
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FadeInImage(
                                    placeholder: AssetImage(
                                        'assets/images/white_pokeball.png'),
                                    height: 75,
                                    image: NetworkImage(
                                        pokedexEntries[index].officialArtwork)),
                              ),
                              Text(
                                pokedexEntries[index].name.capitalize(),
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ));
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
