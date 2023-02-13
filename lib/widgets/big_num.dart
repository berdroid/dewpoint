import 'package:flutter/material.dart';

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
