import 'package:flutter/services.dart';

bool alarmsNotSet(String? low, String? high) {
  return (low == null || low.isEmpty) && (high == null || high.isEmpty);
}

// Custom input formatters for minutes and seconds fields
class TextInputFormatterWithLimit extends TextInputFormatter {
  final int limit;

  TextInputFormatterWithLimit(this.limit);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    } else {
      return int.parse(newValue.text) > limit ? const TextEditingValue().copyWith(text: limit.toString()) : newValue;
    }
  }
}
