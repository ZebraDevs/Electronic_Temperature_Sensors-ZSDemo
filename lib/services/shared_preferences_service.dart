import 'package:flutter/material.dart';
import 'package:zsdemo_app/shared/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin SharedPreferencesServiceMixin {
  late SharedPreferencesService sharedPreferencesService;
}

class SharedPreferencesService {
  static late SharedPreferences preferences;
  static initialize() async {
    preferences = await SharedPreferences.getInstance();
  }

  Locale? getLocale() {
    final String langKey = StorageKeys.languageCode.value;
    final String countryKey = StorageKeys.countryCode.value;

    final String? langCode = preferences.getString(langKey);
    final String? countryCode = preferences.getString(countryKey);

    return langCode != null ? Locale(langCode, countryCode) : null;
  }

  Future<bool> setLocale(Locale locale) async {
    final String langKey = StorageKeys.languageCode.value;
    final String countryKey = StorageKeys.countryCode.value;

    await preferences.setString(countryKey, locale.countryCode ?? 'en');

    return await preferences.setString(langKey, locale.languageCode);
  }

  bool getEulaAccepted() {
    final String eulaKey = StorageKeys.eulaAccepted.value;

    final bool? eulaAccepted = preferences.getBool(eulaKey);

    return eulaAccepted ?? false;
  }

  Future<bool> setEulaAccepted() async {
    final String eulaKey = StorageKeys.eulaAccepted.value;

    return await preferences.setBool(eulaKey, true);
  }

  @visibleForTesting
  Future<bool> resetEulaAccepted() async {
    final String eulaKey = StorageKeys.eulaAccepted.value;

    return await preferences.setBool(eulaKey, false);
  }
}
