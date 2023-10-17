import 'package:flutter/material.dart';
import 'package:zsdemo_app/views/task_details/alarms_view.dart';

class AlarmsPage extends StatelessWidget {
  static const String routeName = '/alarms';

  const AlarmsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlarmsView();
  }
}
