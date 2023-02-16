import 'package:dewpoint/cubit/dewpoint_cubit.dart';
import 'package:dewpoint/pages/dewpoint_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider<DewPointCubit>(
      create: (_) => DewPointCubit(const DewPointState()),
      child: const MyApp(),
    ),
  );
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
      home: const DewPointPage(title: 'Dew Point Calculator'),
    );
  }
}
