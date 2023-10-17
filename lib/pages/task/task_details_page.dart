import 'package:flutter/material.dart';
import 'package:zsdemo_app/models/models.dart';
import 'package:zsdemo_app/models/sensor.dart';
import 'package:zsdemo_app/providers/task/alarms_provider.dart';
import 'package:zsdemo_app/providers/task/task_details_provider.dart';
import 'package:zsdemo_app/providers/task/task_sensors_provider.dart';
import 'package:zsdemo_app/views/task_details/task_details_view.dart';
import 'package:provider/provider.dart';

class TaskDetailsPage extends MaterialPage {
  static const String routeName = "/task-details";

  TaskDetailsPage({
    LocalKey? key,
    required RouteObserver<ModalRoute<dynamic>> observer,
    required Sensor sensor,
  }) : super(
          key: key,
          child: TaskDetailsScreen(
            sensor: sensor,
          ),
        );
}

class TaskDetailsScreen extends StatelessWidget {
  final Sensor sensor;

  const TaskDetailsScreen({super.key, required this.sensor});

  @override
  Widget build(BuildContext context) {
    final taskId = sensor.mostRecent!.taskId!;
    return MultiProvider(
      providers: [
        TaskDetailsProvider(
          sensor: sensor,
          taskId: taskId,
        ),
        AlarmsProvider(taskId: taskId),
        TaskSensorsProvider(
          taskId: taskId,
        ),
      ],
      child: const TaskDetailsView(),
    );
  }
}
