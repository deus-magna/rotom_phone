import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rotom_phone/domain/entities/pokedex/move_learn_method.dart';
import '../../../lib/core/utils/pokemon_utils.dart' as pokemonUtils;

main() {
  group('learnMethodType', () {
    test('Should return null when string has an invalid value', () {
      final result = pokemonUtils.learnMethodType('invalid');
      expect(result, null);
    });

    test('Should return null when string is null', () {
      final result = pokemonUtils.learnMethodType(null);
      expect(result, null);
    });

    test(
        'Should return MoveLearnMethodType when the string from service is valid',
        () {
      final result = pokemonUtils.learnMethodType('form-change');
      expect(result, MoveLearnMethodType.FORM_CHANGE);
    });
  });

  group('versionColor', () {
    test('Should return Color.gray when string is null', () {
      final result = pokemonUtils.versionColor(null);
      expect(result, isA<Color>());
      expect(result, equals(Colors.grey));
    });
    test('Should return Color.gray when string has an invalid value', () {
      final result = pokemonUtils.versionColor('other');
      expect(result, isA<Color>());
      expect(result, equals(Colors.grey));
    });

    test('Should return Color when string has valid pokemon version game', () {
      final result = pokemonUtils.versionColor('red');
      expect(result, isA<Color>());
    });
  });
}
