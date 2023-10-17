import 'package:flutter/material.dart';
import 'package:zsdemo_app/services/zsdemo_api_service.dart';
import 'package:zsdemo_app/states/task/task_sensors_state.dart';
import 'package:provider/provider.dart';

class TaskSensorsProvider extends ChangeNotifierProxyProvider<ZSDemoAPIService, TaskSensorsState> {
  TaskSensorsProvider({Key? key, required String taskId, Widget? child})
      : super(
          create: (_) => TaskSensorsState(taskId),
          update: (_, apiService, state) => state!..apiService = apiService,
          key: key,
          child: child,
        );
}
