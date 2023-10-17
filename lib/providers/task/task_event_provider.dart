import 'package:flutter/material.dart';
import 'package:zsdemo_app/models/task.dart';
import 'package:zsdemo_app/services/zsdemo_api_service.dart';
import 'package:zsdemo_app/states/task/task_events_state.dart';
import 'package:provider/provider.dart';

class TaskEventProvider extends ChangeNotifierProxyProvider<ZSDemoAPIService, TaskEventState> {
  TaskEventProvider({Key? key, required Task task, Widget? child})
      : super(
          create: (_) => TaskEventState(task),
          update: (_, apiService, state) => state!..apiService = apiService,
          key: key,
          child: child,
        );
}
