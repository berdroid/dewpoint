import 'package:dewpoint/cubit/dewpoint_cubit.dart';
import 'package:dewpoint/widgets/dewpoint_display.dart';
import 'package:dewpoint/widgets/humidity_slider.dart';
import 'package:dewpoint/widgets/options_switch.dart';
import 'package:dewpoint/widgets/temperature_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DewPointPage extends StatelessWidget {
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
              DewPointDisplay(state: state),
              TemperatureSlider(state: state, onChanged: cubit.updateTemperature),
              HumiditySlider(state: state, onChanged: cubit.updateHumidity),
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
