import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zsdemo_app/services/shared_preferences_service.dart';
import 'package:zsdemo_app/states/base_state.dart';

class EulaState extends BaseState {
  EulaState() : super(busy: true);

  final SharedPreferencesService _sharedPrefService = SharedPreferencesService();

  bool _accepted = false;
  bool _read = false;
  ScrollController controller = ScrollController();

  bool get accepted => _accepted;
  bool get read => _read;

  String _eulaData = '';
  String get eulaData => _eulaData;

  set accepted(bool value) {
    _accepted = value;
    notifyListeners();
  }

  set read(bool value) {
    _read = value;
    notifyListeners();
  }

  Future<void> checkEulaAccepted() async {
    return whileBusy(() async {
      _accepted = _sharedPrefService.getEulaAccepted();
      if (!_accepted) {
        _eulaData = await loadEula();
      }
    });
  }

  Future<void> acceptEula() async {
    accepted = await _sharedPrefService.setEulaAccepted();
  }

  Future<String> loadEula() async {
    return await rootBundle.loadString('assets/files/eula.md');
  }
}
