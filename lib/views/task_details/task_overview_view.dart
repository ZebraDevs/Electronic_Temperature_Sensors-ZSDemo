import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/utils/sensor.dart';
import 'package:zsdemo_app/common/utils/task.dart';
import 'package:zsdemo_app/components/alarm_tile.dart';
import 'package:zsdemo_app/components/details_item.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/sensor.dart';
import 'package:zsdemo_app/models/task.dart';
import 'package:zsdemo_app/pages/task/alarms_page.dart';
import 'package:zsdemo_app/states/task/alarms_state.dart';
import 'package:zsdemo_app/states/task/task_details_state.dart';
import 'package:zsdemo_app/states/task/task_sensors_state.dart';
import 'package:provider/provider.dart';

class TaskOverviewView extends StatelessWidget {
  const TaskOverviewView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final TaskDetailsState state = context.watch<TaskDetailsState>();
    final Task? task = state.task;
    final Sensor sensor = state.sensor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: RefreshIndicator(
        onRefresh: () async {
          Future.wait([
            state.getTaskData(context),
            context.read<TaskSensorsState>().getTaskSensors(),
            context.read<TaskAlarmState>().refreshData(),
          ]);
        },
        child: task != null
            ? ListView(
                children: [
                  const SizedBox(height: 16),
                  TaskDetailsItem(
                      title: Loco.of(context).taskStatus,
                      child: Text(
                        TaskLabel.fromTask(task.status!).long,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: task.status!.statusColor(),
                              fontSize: 16,
                            ),
                      )),
                  const SizedBox(height: 16),
                  TaskDetailsItem(
                    title: Loco.of(context).taskStart,
                    child: startDate(task.started, context),
                  ),
                  const SizedBox(height: 16),
                  TaskDetailsItem(
                    title: Loco.of(context).taskEnd,
                    child: endDate(task.started, task.ended, context),
                  ),
                  const SizedBox(height: 16),
                  if (task.sensorTaskStatusOverview?.activeWithAlarm != null)
                    ZSAlarmTile(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(AlarmsPage.routeName, arguments: context.read<TaskAlarmState>());
                      },
                    ),
                  const SizedBox(height: 16),
                  TaskDetailsItem(
                    title: Loco.of(context).numberOfSensors,
                    child: Text(
                      task.sensorCount.toString(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ZSColors.secondaryDark,
                            fontSize: 16,
                          ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TaskDetailsItem(
                    title: Loco.of(context).sensorTaskStatus,
                    child: sensor.mostRecent?.sensorTaskStatus != null
                        ? Text(
                            SensorLabel.fromSensorTask(sensor.mostRecent!.sensorTaskStatus!).long,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: sensor.mostRecent!.sensorTaskStatus!.statusColor(),
                                  fontSize: 16,
                                ),
                          )
                        : const SizedBox(),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
