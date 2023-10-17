import 'package:flutter/material.dart';

class ZSRadioTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String title;
  final void Function(T?)? onChanged;

  const ZSRadioTile({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.title,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      value: value,
      groupValue: groupValue,
      title: Text(title),
      onChanged: (value) {
        onChanged?.call(value);
      },
    );
  }
}
