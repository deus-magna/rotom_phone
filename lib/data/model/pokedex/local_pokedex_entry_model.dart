import 'package:equatable/equatable.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokedex.dart';

LocalPokedexEntryModel localPokedexEntryFromPokedexEntry(
        PokemonEntry pokemonData) =>
    LocalPokedexEntryModel.fromPokedexEntry(pokemonData);

class LocalPokedexEntryModel extends Equatable {
  LocalPokedexEntryModel({
    this.name,
    this.url,
    this.id,
    this.officialArtwork,
  });

  final String name;
  final String url;
  final int id;
  final String officialArtwork;

  factory LocalPokedexEntryModel.fromPokedexEntry(PokemonEntry pokemonData) {
    final officialArtwork =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemonData.entryNumber}.png';
    return LocalPokedexEntryModel(
      name: pokemonData.pokemonSpecies.name,
      url: pokemonData.pokemonSpecies.url,
      id: pokemonData.entryNumber,
      officialArtwork: officialArtwork,
    );
  }

  String getPokemonId() {
    return (this.id < 10)
        ? '#00${this.id}'
        : (this.id < 100)
            ? '#0${this.id}'
            : '#${this.id}';
  }

  @override
  List<Object> get props => [name, url, id, officialArtwork];
}
