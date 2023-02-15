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
  });
}
