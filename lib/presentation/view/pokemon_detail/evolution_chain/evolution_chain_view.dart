import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';
import 'package:rotom_phone/injector/injection_container.dart';
import 'package:rotom_phone/presentation/cubit/evolution_chain/evolution_chain_cubit.dart';
import 'package:rotom_phone/presentation/widgets/rounded_card.dart';

class EvolutionChainView extends StatelessWidget {
  final Pokemon pokemon;

  const EvolutionChainView({
    Key key,
    @required this.pokemon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedCard(
          child: BlocProvider(
            create: (context) => sl<EvolutionchainCubit>(),
            child: BlocBuilder<EvolutionchainCubit, EvolutionchainState>(
                builder: (context, state) {
              if (state is EvolutionchainInitial) {
                final evolutionChainCubit = context.read<EvolutionchainCubit>();
                evolutionChainCubit
                    .getPokemonEvolutions(pokemon.specie.evolutionChain.url);
                return buildProgressIndicator();
              } else if (state is EvolutionChainLoading) {
                return buildProgressIndicator();
              } else if (state is EvolutionChainLoaded) {
                return Column(
                  children: [
                    Text(state.evolutionChain.chain.species.name),
                  ],
                );
              } else {
                return Container();
              }
            }),
          ),
        )
      ],
    );
  }

  Widget buildProgressIndicator() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
