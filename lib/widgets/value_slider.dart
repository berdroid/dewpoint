import 'package:dewpoint/widgets/state_display.dart';
import 'package:flutter/material.dart';

class ValueSlider extends StatelessWidget {
  const ValueSlider({
    super.key,
    required this.value,
    required this.valueMin,
    required this.valueMax,
    this.decimals = 0,
    required this.caption,
    this.onChanged,
  });

  final double value;
  final double valueMin;
  final double valueMax;
  final int decimals;
  final String caption;
  final void Function(double)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StateDisplay(
          value: value,
          decimals: decimals,
          caption: caption,
        ),
        Slider.adaptive(
          min: valueMin,
          max: valueMax,
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
