import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zsdemo_app/app.dart';
import 'package:zsdemo_app/services/shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SharedPreferencesService.initialize();
  runApp(const App());
}
