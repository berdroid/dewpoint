import 'package:dewpoint/dewpoint.dart';
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

class BigNum extends StatelessWidget {
  final double value;
  final int decimals;

  const BigNum({super.key, required this.value, required this.decimals});

  @override
  Widget build(BuildContext context) {
    return Text(
      value.toStringAsFixed(decimals),
      style: Theme.of(context).textTheme.headline4,
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

    final dewPoint = calcDewPoint(temperature.value, humidity.value);
    final absHumidity = calcAbsoluteHumidity(temperature.value, humidity.value);

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
                Column(
                  children: [
                    const Text('Dew point [°C]:'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        BigNum(value: dewPoint, decimals: 0),
                        const SizedBox(width: 10),
                        Icon(
                          dewPoint > 0 ? Icons.water_drop : Icons.ac_unit,
                          color: Colors.blueAccent,
                          size: 28,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('Abs. humidity [g/m³]:'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        BigNum(value: absHumidity, decimals: 1),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.cloud_outlined,
                          color: Colors.blueAccent,
                          size: 28,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                const Text('Temperature [°C]:'),
                BigNum(value: temperature.value, decimals: 1),
                Slider(
                  min: -10.0,
                  max: 40.0,
                  value: temperature.value,
                  onChanged: (t) => temperature.value = t,
                ),
              ],
            ),
            Column(
              children: [
                const Text('Humidity [% rH]:'),
                BigNum(value: humidity.value, decimals: 0),
                Slider(
                  min: 10.0,
                  max: 100.0,
                  value: humidity.value,
                  onChanged: (h) => humidity.value = h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
