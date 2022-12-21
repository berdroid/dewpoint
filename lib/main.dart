import 'package:dewpoint/dewpoint.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double temperature = 20.0;
  double humidity = 50.0;

  double dewPoint = 13.0;

  void _updateDewPoint() {
    dewPoint = calcDewPoint(temperature, humidity);
  }

  void _updateTemperature(double t) {
    setState(() {
      temperature = t;
      _updateDewPoint();
    });
  }

  void _updateHumidity(double h) {
    setState(() {
      humidity = h;
      _updateDewPoint();
    });
  }

  Widget _bigNum(double value, int decimals) {
    return Text(
      value.toStringAsFixed(decimals),
      style: Theme.of(context).textTheme.headline4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: [
                const Text('Dew point [°C]:'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    _bigNum(dewPoint, 0),
                    const SizedBox(width: 10),
                    Icon(
                      dewPoint > 0 ? Icons.water_drop : Icons.severe_cold,
                      color: Colors.blueAccent,
                      size: 28,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                const Text('Temperature [°C]:'),
                _bigNum(temperature, 1),
                Slider(
                  min: -10.0,
                  max: 40.0,
                  value: temperature,
                  onChanged: _updateTemperature,
                ),
              ],
            ),
            Column(
              children: [
                const Text('Humidity [% rH]:'),
                _bigNum(humidity, 0),
                Slider(
                  min: 10.0,
                  max: 100.0,
                  value: humidity,
                  onChanged: _updateHumidity,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
