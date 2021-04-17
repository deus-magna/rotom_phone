import 'package:flutter_test/flutter_test.dart';
import '../../../lib/core/extensions/string_extension.dart';

main() {
  group('capitalize', () {
    test('Should return the first letter uppercased', () {
      final String tString = 'hello';
      final result = tString.capitalize();
      expect(result, 'Hello');
    });
  });
}
