import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotom_phone/core/framework/colors.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_specie.dart';
import 'package:rotom_phone/domain/entities/resource_path.dart';
import 'package:rotom_phone/injector/injection_container.dart';
import 'package:rotom_phone/presentation/cubit/pokemon_detail/pokemon_detail_cubit.dart';
import 'package:rotom_phone/presentation/widgets/pokedex_header.dart';
import 'package:rotom_phone/presentation/widgets/type_indicator.dart';
import '../../core/extensions/string_extension.dart';

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
              return Column(
                children: [
                  PokedexHeader(
                    child: PokemonDetailHeader(pokemon: state.pokemonDetail),
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
                  PokedexEntry(
                    entries:
                        state.pokemonDetail.pokemonSpecie.flavorTextEntries,
                  ),
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
    );
  }
}

class PokemonDetailHeader extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailHeader({
    Key key,
    @required this.pokemon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final String artwork =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.pokemonSpecie.id}.png";
    final types =
        pokemon.pokemonInfo.types.map((element) => element.type).toList();

    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.05),
            child: _OfficialArtwork(artwork: artwork, height: 150),
          ),
          Positioned(
            top: 0,
            left: 20,
            child: _PokemonHeadInfo(
              name: pokemon.pokemonSpecie.name,
              id: pokemon.pokemonSpecie.getPokemonId(),
              types: types,
            ),
          ),
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
    @required this.types,
  }) : super(key: key);

  final String name;
  final String id;
  final List<ResourcePath> types;

  @override
  Widget build(BuildContext context) {
    final typeIndicator =
        types.map((type) => TypeIndicator(name: type.name)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(id),
        Text(
          name.capitalize(),
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        ...typeIndicator
      ],
    );
  }
}

class PokedexEntry extends StatelessWidget {
  final List<FlavorTextEntry> entries;

  const PokedexEntry({Key key, @required this.entries}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final entriesString =
        entries.where((entry) => entry.language.name == 'en').toList();

    return Expanded(
      child: Container(
        margin: EdgeInsets.all(20),
        child: PageView.builder(
          itemCount: entriesString.length,
          itemBuilder: (context, index) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(entriesString[index]?.version?.name ?? 'unknown'),
              SizedBox(height: 10),
              Text(
                entriesString[index]?.flavorText?.replaceAll('\n', ' ') ??
                    'unknown',
                maxLines: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
