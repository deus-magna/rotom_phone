import 'package:equatable/equatable.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokedex_page_response.dart';

PokedexEntryModel pokedexEntryFromResult(Result pokemonData) =>
    PokedexEntryModel.fromResult(pokemonData);

class PokedexEntryModel extends Equatable {
  PokedexEntryModel({
    this.name,
    this.url,
    this.id,
    this.officialArtwork,
  });

  final String name;
  final String url;
  final int id;
  final String officialArtwork;

  factory PokedexEntryModel.fromResult(Result pokemonData) {
    final urlParts = pokemonData.url.split('/');
    final id = urlParts[urlParts.length - 2];
    final officialArtwork =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
    return PokedexEntryModel(
      name: pokemonData.name,
      url: pokemonData.url,
      id: int.parse(id),
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
