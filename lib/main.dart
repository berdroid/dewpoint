import 'package:dewpoint/dewpoint.dart';
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

  @override
  Widget build(BuildContext context) {
    final temperature = useState(20.0);
    final humidity = useState(50.0);

    final dewPoint = DewPoint.calcDewPoint(temperature.value, humidity.value);
    final absHumidity = DewPoint.calcAbsoluteHumidity(temperature.value, humidity.value);

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
                  value: dewPoint,
                  caption: 'Dew point [°C]:',
                  iconData: dewPoint > 0 ? Icons.water_drop : Icons.ac_unit,
                ),
                StateDisplay(
                  value: absHumidity,
                  decimals: 1,
                  caption: 'Abs. humidity [g/m³]:',
                  iconData: Icons.cloud_outlined,
                ),
              ],
            ),
            ValueSlider(
              value: temperature.value,
              valueMin: -10,
              valueMax: 40,
              decimals: 1,
              caption: 'Temperature [°C]:',
              onChanged: (t) => temperature.value = t,
            ),
            ValueSlider(
              value: humidity.value,
              valueMin: 10,
              valueMax: 100,
              caption: 'Humidity [% rH]:',
              onChanged: (h) => humidity.value = h,
            ),
          ],
        ),
      ),
    );
  }
}
