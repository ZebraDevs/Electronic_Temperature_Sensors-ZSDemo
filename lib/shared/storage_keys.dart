import 'package:flutter/foundation.dart';

enum StorageKeys {
  countryCode,
  languageCode,
  eulaAccepted,
}

extension StorageKeysEx on StorageKeys {
  String get inString => describeEnum(this);
}

extension StorageKeysExt on StorageKeys {
  String get value {
    var packageName = "zsdemo";
    return "$packageName.$inString";
  }
}
