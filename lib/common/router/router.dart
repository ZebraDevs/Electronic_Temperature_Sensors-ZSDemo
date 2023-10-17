import 'package:flutter/material.dart';
import 'package:zsdemo_app/pages/pages.dart';
import 'package:zsdemo_app/states/task/alarms_state.dart';
import 'package:provider/provider.dart';

class ZSRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AboutPage.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const AboutPage(),
        );
      case SensorPage.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SensorPage(),
        );
      case AlarmsPage.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            final TaskAlarmState alarmsState = settings.arguments as TaskAlarmState;
            return ChangeNotifierProvider<TaskAlarmState>.value(
              value: alarmsState,
              builder: (context, child) {
                return const AlarmsPage();
              },
            );
          },
          fullscreenDialog: true,
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const LandingPage(),
        );
    }
  }
}
