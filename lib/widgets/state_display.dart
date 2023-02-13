import 'package:dewpoint/widgets/big_num.dart';
import 'package:flutter/material.dart';

class StateDisplay extends StatelessWidget {
  const StateDisplay({
    super.key,
    required this.value,
    this.decimals = 0,
    required this.caption,
    this.iconData,
    this.iconColor = Colors.blueAccent,
  });

  final double value;
  final int decimals;
  final String caption;
  final IconData? iconData;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(caption),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            BigNum(value: value, decimals: decimals),
            if (iconData != null) ...[
              const SizedBox(width: 10),
              Icon(
                iconData,
                color: iconColor,
                size: 28,
              ),
            ],
          ],
        ),
      ],
    );
  }
}
