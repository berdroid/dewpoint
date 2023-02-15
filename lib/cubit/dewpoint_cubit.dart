import 'dart:math';

import 'package:dewpoint/dewpoint.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dewpoint_state.dart';

class DewPointCubit extends Cubit<DewPointState> {
  DewPointCubit(super.initialState);

  static const temperatureMin = -10.0;
  static const temperatureMax = 40.0;

  static const humidityMin = 10.0;
  static const humidityMax = 100.0;

  bool get _isLocked => state.locked;

  void updateLocked({required bool locked}) => emit(state.copyWith(locked: locked));

  void updateDewPoint(double temperature, double humidity) {
    final dewPoint = DewPoint.calcDewPoint(temperature, humidity);
    final absHumidity = DewPoint.calcAbsoluteHumidity(temperature, humidity);

    emit(state.copyWith(
      temperature: temperature,
      relHumidity: humidity,
      dewPoint: dewPoint,
      absHumidity: absHumidity,
    ));
  }

  void updateTemperature(double t) {
    if (_isLocked) {
      final tMax = DewPoint.calcTemperature(humidityMin + 0.1, state.dewPoint);
      final temperature = min(max(t, state.dewPoint), tMax);
      final humidity = DewPoint.calcRelativeHumidity(temperature, state.dewPoint);

      emit(state.copyWith(temperature: temperature, relHumidity: humidity));
    } else {
      updateDewPoint(t, state.relHumidity);
    }
  }

  void updateHumidity(double h) {
    if (_isLocked) {
      final hMin = DewPoint.calcRelativeHumidity(temperatureMax - 0.1, state.dewPoint);
      final hMax = DewPoint.calcRelativeHumidity(temperatureMin + 0.1, state.dewPoint);
      final humidity = min(max(h, hMin), hMax);
      final temperature = DewPoint.calcTemperature(humidity, state.dewPoint);

      emit(state.copyWith(temperature: temperature, relHumidity: humidity));
    } else {
      updateDewPoint(state.temperature, h);
    }
  }
}
