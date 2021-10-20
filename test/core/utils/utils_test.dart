import 'package:flutter_test/flutter_test.dart';
import 'package:rotom_phone/core/utils/enums.dart';
import '../../../lib/core/utils/utils.dart' as utils;

void main() {
  group('enumFromString', () {
    test('Should return null if type doesn`t exist', () {
      final result = utils.enumFromString(MoveLearnMethodType.values, '');
      expect(result, null);
    });

    test('Should return MoveLearnMethodType if type String match', () {
      final result = utils.enumFromString(MoveLearnMethodType.values, 'EGG');
      expect(result, MoveLearnMethodType.egg);
    });
  });
}
