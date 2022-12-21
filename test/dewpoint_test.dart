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

  group('Dew point', () {
    test('0°C', () {
      expect(calcAbsoluteHumidity(0.0, 25.0), closeTo(1.2, 0.15));
      expect(calcAbsoluteHumidity(0.0, 50.0), closeTo(2.4, 0.15));
      expect(calcAbsoluteHumidity(0.0, 100.0), closeTo(4.8, 0.15));
    });

    test('20°C', () {
      expect(calcAbsoluteHumidity(20.0, 25.0), closeTo(4.3, 0.15));
      expect(calcAbsoluteHumidity(20.0, 50.0), closeTo(8.6, 0.15));
      expect(calcAbsoluteHumidity(20.0, 100.0), closeTo(17.3, 0.15));
    });

    test('50%', () {
      expect(calcAbsoluteHumidity(-10.0, 50.0), closeTo(1.2, 0.15));
      expect(calcAbsoluteHumidity(5.0, 50.0), closeTo(3.4, 0.15));
      expect(calcAbsoluteHumidity(22.0, 50.0), closeTo(9.7, 0.15));
    });
  });
}
