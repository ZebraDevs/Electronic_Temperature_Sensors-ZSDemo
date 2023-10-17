import 'package:flutter/material.dart';
import 'package:zsdemo_app/services/zsdemo_api_service.dart';
import 'package:zsdemo_app/states/task/alarms_state.dart';
import 'package:provider/provider.dart';

class AlarmsProvider extends ChangeNotifierProxyProvider<ZSDemoAPIService, TaskAlarmState> {
  AlarmsProvider({super.key, required String taskId, Widget? child})
      : super(
          child: child,
          create: (_) => TaskAlarmState(taskId),
          update: (_, apiService, alarmsState) {
            return alarmsState!..apiService = apiService;
          },
        );
}
