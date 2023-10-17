import 'package:flutter/material.dart';
import 'package:zsdemo_app/models/sensor.dart';
import 'package:zsdemo_app/services/bluetooth_service.dart';
import 'package:zsdemo_app/services/zsdemo_api_service.dart';
import 'package:zsdemo_app/states/task/task_details_state.dart';
import 'package:provider/provider.dart';

class TaskDetailsProvider extends ChangeNotifierProxyProvider2<ZSDemoAPIService, BluetoothService, TaskDetailsState> {
  TaskDetailsProvider({super.key, required String taskId, required Sensor sensor, Widget? child})
      : super(
          child: child,
          create: (_) => TaskDetailsState(
            taskId: taskId,
            sensor: sensor,
          ),
          update: (_, apiService, bluetoothService, createTaskState) {
            return createTaskState!
              ..apiService = apiService
              ..bluetoothService = bluetoothService;
          },
        );
}
