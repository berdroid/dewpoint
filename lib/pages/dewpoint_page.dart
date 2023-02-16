import 'package:dewpoint/cubit/dewpoint_cubit.dart';
import 'package:dewpoint/widgets/options_switch.dart';
import 'package:dewpoint/widgets/state_display.dart';
import 'package:dewpoint/widgets/value_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DewPointPage extends HookWidget {
  const DewPointPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DewPointCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: BlocBuilder<DewPointCubit, DewPointState>(
          builder: (context, state) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
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
              ),
              ValueSlider(
                value: state.temperature,
                valueMin: DewPointCubit.temperatureMin,
                valueMax: DewPointCubit.temperatureMax,
                decimals: 1,
                caption: 'Temperature [°C]:',
                onChanged: cubit.updateTemperature,
              ),
              ValueSlider(
                value: state.relHumidity,
                valueMin: DewPointCubit.humidityMin,
                valueMax: DewPointCubit.humidityMax,
                caption: 'Humidity [% rH]:',
                onChanged: cubit.updateHumidity,
              ),
              OptionSwitch(
                captionOff: 'Free',
                captionOn: 'Fixed',
                state: state.locked,
                onChanged: (locked) => cubit.updateLocked(locked: locked),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
