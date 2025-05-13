// ignore_for_file: avoid_print

import 'dart:async';

import 'package:dewpoint/cubit/dewpoint_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DewPointCubit cubit;

  setUp(() {
    cubit = DewPointCubit(const DewPointState());
  });

  tearDown(() {
    return Future(() async {
      await cubit.close();
    });
  });

  group('Updates', () {
    test('emits update', () {
      unawaited(
        expectLater(
          cubit.stream,
          emitsThrough(
            predicate((DewPointState state) => 14.9 < state.dewPoint && state.dewPoint < 15.1),
          ),
        ),
      );
      cubit
        ..updateTemperature(37.0)
        ..updateHumidity(27.2);
    });

    test('emits update with locked==true', () {
      unawaited(expectLater(cubit.stream, emitsThrough(predicate((DewPointState state) => state.locked))));
      cubit.stream.listen(print);
      cubit
        ..updateTemperature(37.0)
        ..updateHumidity(27.2)
        ..updateLocked(locked: true);
    });

    test('emits updated humidity in locked state', () {
      unawaited(expectLater(
          cubit.stream,
          emitsThrough(predicate(
              (DewPointState state) => 14.9 < state.dewPoint && state.dewPoint < 15.1 && state.relHumidity == 55.5))));
      cubit.stream.listen(print);
      cubit
        ..updateTemperature(37.0)
        ..updateHumidity(27.2)
        ..updateLocked(locked: true)
        ..updateHumidity(55.5);
    });

    test('emits updated temperature in locked state', () {
      unawaited(expectLater(
          cubit.stream,
          emitsThrough(predicate(
              (DewPointState state) => 14.9 < state.dewPoint && state.dewPoint < 15.1 && state.temperature == 55.5))));
      cubit.stream.listen(print);
      cubit
        ..updateTemperature(37.0)
        ..updateHumidity(27.2)
        ..updateLocked(locked: true)
        ..updateTemperature(55.5);
    });
  });
}
