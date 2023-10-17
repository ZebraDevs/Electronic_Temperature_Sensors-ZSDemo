import 'dart:math';

import 'package:either_option/either_option.dart';

extension StringUtils on String {
  String toCamelCase() {
    String s = replaceAllMapped(RegExp(r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'),
            (Match m) => "${m[0]![0].toUpperCase()}${m[0]!.substring(1).toLowerCase()}")
        .replaceAll(RegExp(r'(_|-|\s)+'), '');
    return s[0].toLowerCase() + s.substring(1);
  }

  String toFirstLetterCapital() {
    return this[0].toUpperCase() + substring(1);
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) =>
    String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

extension OptionalStringExt on Option<String> {
  int get getDefaultZero {
    return int.tryParse(getOrElse(() => '0') ?? '0') ?? 0;
  }
}
