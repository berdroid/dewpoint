import 'package:dewpoint/cubit/dewpoint_cubit.dart';
import 'package:dewpoint/widgets/state_display.dart';
import 'package:flutter/material.dart';

class DewPointDisplay extends StatelessWidget {
  const DewPointDisplay({super.key, required this.state});

  final DewPointState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StateDisplay(
          value: state.dewPoint,
          caption: 'Dew point [°C]:',
          iconData: state.dewPoint > 0 ? Icons.water_drop : Icons.ac_unit,
        ),
        StateDisplay(
          value: state.absHumidity,
          decimals: 1,
          caption: 'Abs. humidity [g/m³]:',
          iconData: Icons.cloud_outlined,
        ),
      ],
    );
  }
}
