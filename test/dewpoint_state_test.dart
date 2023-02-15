// ignore_for_file: avoid_print

import 'package:dewpoint/cubit/dewpoint_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Constructor', () {
    test('Default values', () {
      const state = DewPointState();
      print(state);
      expect(state.temperature, closeTo(20.0, 0.001));
      expect(state.relHumidity, closeTo(50.0, 0.001));
      expect(state.locked, isFalse);
    });

    test('Constructor argument: temperature', () {
      const state = DewPointState(temperature: 4.0);
      print(state);
      expect(state.temperature, closeTo(4.0, 0.001));
      expect(state.relHumidity, closeTo(50.0, 0.001));
      expect(state.locked, isFalse);
    });

    test('Constructor argument: humidity', () {
      const state = DewPointState(relHumidity: 74.0);
      print(state);
      expect(state.temperature, closeTo(20.0, 0.001));
      expect(state.relHumidity, closeTo(74.0, 0.001));
      expect(state.locked, isFalse);
    });
  });

  group('copyWith', () {
    test('copyWith argument: locked', () {
      final state = const DewPointState().copyWith(locked: true);
      print(state);
      expect(state.temperature, closeTo(20.0, 0.001));
      expect(state.relHumidity, closeTo(50.0, 0.001));
      expect(state.locked, isTrue);
    });

    test('copyWith argument: temperature', () {
      final state = const DewPointState().copyWith(temperature: 4.0);
      print(state);
      expect(state.temperature, closeTo(4.0, 0.001));
      expect(state.relHumidity, closeTo(50.0, 0.001));
      expect(state.locked, isFalse);
    });

    test('Constructor argument: humidity', () {
      final state = const DewPointState().copyWith(relHumidity: 74.0);
      print(state);
      expect(state.temperature, closeTo(20.0, 0.001));
      expect(state.relHumidity, closeTo(74.0, 0.001));
      expect(state.locked, isFalse);
    });
  });

  group('Equatable', () {
    test('equal', () {
      const stateA = DewPointState(relHumidity: 74.0);
      const stateB = DewPointState(relHumidity: 74.0);
      print(stateB);
      expect(stateA, equals(stateB));
    });

    test('not equal', () {
      const stateA = DewPointState();
      const stateB = DewPointState(relHumidity: 74.0);
      print(stateB);
      expect(stateA, isNot(equals(stateB)));
    });

    test('locked not equal', () {
      const stateA = DewPointState();
      const stateB = DewPointState(locked: true);
      print(stateB);
      expect(stateA, isNot(equals(stateB)));
    });
  });
}
