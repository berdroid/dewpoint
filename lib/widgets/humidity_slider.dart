import 'package:dewpoint/cubit/dewpoint_cubit.dart';
import 'package:dewpoint/widgets/value_slider.dart';
import 'package:flutter/material.dart';

class HumiditySlider extends StatelessWidget {
  const HumiditySlider({
    super.key,
    required this.state,
    this.onChanged,
  });

  final DewPointState state;
  final void Function(double)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ValueSlider(
      value: state.relHumidity,
      valueMin: DewPointCubit.humidityMin,
      valueMax: DewPointCubit.humidityMax,
      decimals: 1,
      caption: 'Humidity [% rH]:',
      onChanged: onChanged,
    );
  }
}
