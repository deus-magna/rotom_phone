import 'package:flutter_test/flutter_test.dart';
import 'package:rotom_phone/data/model/pokedex/pokemon_specie_model.dart';
import 'package:rotom_phone/domain/entities/pokedex/pokemon_specie.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  /// Pokemon specie mock
  PokemonSpecie tPokemonSpecie =
      pokemonSpecieModelFromJson(fixture('pokemon_specie.json'));

  group('getPokemonId', () {
    test('Should return a String with 00+Id if pokemon Id < 10', () {
      // act
      final id = tPokemonSpecie.getPokemonId();
      expect(id, '#001');
    });

    test('Should return a String with 0+Id if pokemon Id < 100', () {
      tPokemonSpecie = PokemonSpecie(id: 18);
      // act
      final id = tPokemonSpecie.getPokemonId();
      expect(id, '#018');
    });

    test('Should return a String with 0+Id if pokemon Id = 100', () {
      tPokemonSpecie = PokemonSpecie(id: 100);
      // act
      final id = tPokemonSpecie.getPokemonId();
      expect(id, '#100');
    });

    test('Should return a String with 0+Id if pokemon Id > 100', () {
      tPokemonSpecie = PokemonSpecie(id: 150);
      // act
      final id = tPokemonSpecie.getPokemonId();
      expect(id, '#150');
    });
  });

  group('versionAcronym', () {
    test('Should return the acronym for pokemon versions', () {
      final versionAcronym = tPokemonSpecie.flavorTextEntries[0].versionAcronym;
      expect(versionAcronym, 'Wh');
    });
  });
}
