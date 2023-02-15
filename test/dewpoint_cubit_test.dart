import 'package:bloc_test/bloc_test.dart';
import 'package:dewpoint/cubit/dewpoint_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Values', () {
    blocTest<DewPointCubit, DewPointState>(
      'emits update',
      build: () => DewPointCubit(const DewPointState(temperature: 37.0)),
      act: (cubit) => cubit.updateHumidity(27.2),
      expect: () => [predicate((DewPointState state) => 14.9 < state.dewPoint && state.dewPoint < 15.1)],
    );
  });

  group('Updates', () {
    blocTest<DewPointCubit, DewPointState>(
      'emits update with locked==true',
      build: () => DewPointCubit(const DewPointState()),
      act: (cubit) => cubit.updateLocked(locked: true),
      expect: () => [predicate((DewPointState state) => state.locked)],
    );
  });
}
