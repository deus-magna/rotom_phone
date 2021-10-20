import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rotom_phone/core/utils/enums.dart';
import '../../../lib/core/utils/pokemon_utils.dart' as pokemon_utils;

void main() {
  group('learnMethodType', () {
    test('Should return null when string has an invalid value', () {
      final result = pokemon_utils.learnMethodType('invalid');
      expect(result, null);
    });

    test('Should return null when string is null', () {
      final result = pokemon_utils.learnMethodType(null);
      expect(result, null);
    });

    test('''Should return MoveLearnMethodType when the string from service 
        is valid''', () {
      final result = pokemon_utils.learnMethodType('form-change');
      expect(result, equals(MoveLearnMethodType.formChange));
    });
  });

  group('versionColor', () {
    test('Should return Color.gray when string is null', () {
      final result = pokemon_utils.versionColor(null);
      expect(result, isA<Color>());
      expect(result, equals(Colors.grey));
    });
    test('Should return Color.gray when string has an invalid value', () {
      final result = pokemon_utils.versionColor('other');
      expect(result, isA<Color>());
      expect(result, equals(Colors.grey));
    });

    test('Should return Color when string has valid pokemon version game', () {
      final result = pokemon_utils.versionColor('red');
      expect(result, isA<Color>());
    });
  });
}
