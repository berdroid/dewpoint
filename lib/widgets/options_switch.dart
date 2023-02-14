import 'package:flutter/material.dart';

class OptionSwitch extends StatelessWidget {
  const OptionSwitch({
    super.key,
    required this.captionOff,
    required this.captionOn,
    required this.state,
    this.onChanged,
  });

  final String captionOff;
  final String captionOn;
  final bool state;
  final void Function(bool state)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(
            captionOff,
            textAlign: TextAlign.end,
          ),
        ),
        Switch.adaptive(
          value: state,
          onChanged: onChanged,
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(
            captionOn,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
