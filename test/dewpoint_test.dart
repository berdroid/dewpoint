import 'package:dewpoint/dewpoint.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Dew point', () {
    test('near zero', () {
      expect(calcDewPoint(20.0, 26.2), closeTo(0, 0.1));
      expect(calcDewPoint(10.9, 47.0), closeTo(0, 0.1));
      expect(calcDewPoint(0.0, 100.0), closeTo(0, 0.1));
    });

    test('near 15', () {
      expect(calcDewPoint(20.0, 73.0), closeTo(15, 0.1));
      expect(calcDewPoint(37.0, 27.2), closeTo(15, 0.1));
      expect(calcDewPoint(15.0, 100.0), closeTo(15, 0.1));
    });

    test('near 30', () {
      expect(calcDewPoint(55.0, 27.0), closeTo(30, 0.1));
      expect(calcDewPoint(37.0, 67.6), closeTo(30, 0.1));
      expect(calcDewPoint(30.0, 100.0), closeTo(30, 0.1));
    });
  });
}
