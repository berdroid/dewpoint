import 'dart:math';

import 'package:dewpoint/dewpoint.dart';
import 'package:dewpoint/widgets/options_switch.dart';
import 'package:dewpoint/widgets/state_display.dart';
import 'package:dewpoint/widgets/value_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dew Point',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Dew Point Calculator'),
    );
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  static const temperatureMin = -10.0;
  static const temperatureMax = 40.0;

  static const humidityMin = 10.0;
  static const humidityMax = 100.0;

  @override
  Widget build(BuildContext context) {
    final temperature = useState(20.0);
    final humidity = useState(50.0);
    final dewPoint = useState(9.0);
    final absHumidity = useState(8.7);
    final lockDewPoint = useState(false);

    void _updateTemperature(double t) {
      if (lockDewPoint.value) {
        final tMax = DewPoint.calcTemperature(humidityMin + 0.1, dewPoint.value);
        temperature.value = min(max(t, dewPoint.value), tMax);
        humidity.value = DewPoint.calcRelativeHumidity(temperature.value, dewPoint.value);
      } else {
        temperature.value = t;
        dewPoint.value = DewPoint.calcDewPoint(temperature.value, humidity.value);
        absHumidity.value = DewPoint.calcAbsoluteHumidity(temperature.value, humidity.value);
      }
    }

    void _updateHumidity(double h) {
      if (lockDewPoint.value) {
        final hMin = DewPoint.calcRelativeHumidity(temperatureMax - 0.1, dewPoint.value);
        final hMax = DewPoint.calcRelativeHumidity(temperatureMin + 0.1, dewPoint.value);
        humidity.value = min(max(h, hMin), hMax);
        temperature.value = DewPoint.calcTemperature(humidity.value, dewPoint.value);
      } else {
        humidity.value = h;
        dewPoint.value = DewPoint.calcDewPoint(temperature.value, humidity.value);
        absHumidity.value = DewPoint.calcAbsoluteHumidity(temperature.value, humidity.value);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StateDisplay(
                  value: dewPoint.value,
                  caption: 'Dew point [°C]:',
                  iconData: dewPoint.value > 0 ? Icons.water_drop : Icons.ac_unit,
                ),
                StateDisplay(
                  value: absHumidity.value,
                  decimals: 1,
                  caption: 'Abs. humidity [g/m³]:',
                  iconData: Icons.cloud_outlined,
                ),
              ],
            ),
            ValueSlider(
              value: temperature.value,
              valueMin: temperatureMin,
              valueMax: temperatureMax,
              decimals: 1,
              caption: 'Temperature [°C]:',
              onChanged: _updateTemperature,
            ),
            ValueSlider(
              value: humidity.value,
              valueMin: humidityMin,
              valueMax: humidityMax,
              caption: 'Humidity [% rH]:',
              onChanged: _updateHumidity,
            ),
            OptionSwitch(
              captionOff: 'Free',
              captionOn: 'Off',
              state: lockDewPoint.value,
              onChanged: (lock) => lockDewPoint.value = lock,
            ),
          ],
        ),
      ),
    );
  }
}
