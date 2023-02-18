import 'package:dewpoint/cubit/dewpoint_cubit.dart';
import 'package:dewpoint/widgets/value_slider.dart';
import 'package:flutter/material.dart';

class TemperatureSlider extends StatelessWidget {
  const TemperatureSlider({
    super.key,
    required this.state,
    this.onChanged,
  });

  final DewPointState state;
  final void Function(double)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ValueSlider(
      value: state.temperature,
      valueMin: DewPointCubit.temperatureMin,
      valueMax: DewPointCubit.temperatureMax,
      decimals: 1,
      caption: 'Temperature [°C]:',
      onChanged: onChanged,
    );
  }
}
