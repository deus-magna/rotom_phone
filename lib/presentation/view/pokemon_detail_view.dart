import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_specie.dart';
import 'package:rotom_phone/injector/injection_container.dart';
import 'package:rotom_phone/presentation/cubit/pokemon_detail/pokemon_detail_cubit.dart';
import '../../core/extensions/string_extension.dart';

class PokemonDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int entryNumber = ModalRoute.of(context).settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.favorite_border_rounded),
              onPressed: () => print('Add to favorite')),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (_) => sl<PokemonDetailCubit>()..init(entryNumber),
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
              return PokemonDetalHeader(
                  pokemon: state.pokemonDetail.pokemonSpecie);
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

class PokemonDetalHeader extends StatelessWidget {
  final PokemonSpecie pokemon;

  const PokemonDetalHeader({
    Key key,
    @required this.pokemon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final pokedexDescriptionEntries = pokemon.flavorTextEntries;
    final descriptionEntry = pokedexDescriptionEntries
            .where((entry) {
              return entry.language.name == 'en'
                  // ? entry.version.name == 'sword'
                  ? true
                  // : false
                  : false;
            })
            .first
            .flavorText ??
        '';

    final String artwork =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.id}.png";
    return Container(
      width: double.infinity,
      color: Colors.red.withOpacity(0.2),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.05),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _OfficialArtwork(artwork: artwork, height: 150),
                Text(descriptionEntry),
              ],
            ),
          ),
          Positioned(
              top: 20,
              left: 20,
              child: _PokemonHeadInfo(
                  name: pokemon.name, id: pokemon.getPokemonId())),
        ],
      ),
    );
  }
}

class _OfficialArtwork extends StatelessWidget {
  const _OfficialArtwork({
    Key key,
    @required this.artwork,
    this.height = 60,
  }) : super(key: key);

  final String artwork;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: FadeInImage(
          placeholder: AssetImage('assets/images/white_pokeball.png'),
          height: height,
          image: CachedNetworkImageProvider(artwork)),
    );
  }
}

class _PokemonHeadInfo extends StatelessWidget {
  const _PokemonHeadInfo({
    Key key,
    @required this.name,
    @required this.id,
  }) : super(key: key);

  final String name;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(id),
        Text(
          name.capitalize(),
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
