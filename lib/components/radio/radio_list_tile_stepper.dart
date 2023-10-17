import 'package:flutter/material.dart';
import 'package:zsdemo_app/components/radio/radio_tile.dart';

class ZSRadioListTileStepper<T> extends StatelessWidget {
  final String label;
  final void Function(T?)? onChanged;
  final T value;
  final T groupValue;
  final Widget child;

  const ZSRadioListTileStepper({
    Key? key,
    required this.label,
    required this.onChanged,
    required this.value,
    required this.groupValue,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ZSRadioTile<T>(
          title: label,
          groupValue: groupValue,
          value: value,
          onChanged: onChanged,
        ),
        child,
      ],
    );
  }
}
