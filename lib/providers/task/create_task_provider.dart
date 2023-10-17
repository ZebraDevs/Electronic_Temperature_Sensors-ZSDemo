import 'package:flutter/material.dart';
import 'package:zsdemo_app/services/zsdemo_api_service.dart';
import 'package:zsdemo_app/states/sensor/sensor_state.dart';
import 'package:zsdemo_app/states/task/create_task_state.dart';
import 'package:provider/provider.dart';

class CreateTaskProvider extends ChangeNotifierProxyProvider2<ZSDemoAPIService, SensorState, CreateTaskState> {
  CreateTaskProvider({
    Key? key,
    Widget? child,
  }) : super(
          key: key,
          child: child,
          create: (_) => CreateTaskState(),
          update: (_, apiService, sensorState, createTaskState) {
            return createTaskState!
              ..apiService = apiService
              ..sensorState = sensorState;
          },
        );
}
