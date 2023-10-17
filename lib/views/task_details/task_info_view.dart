import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/utils/task.dart';
import 'package:zsdemo_app/components/details_item.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/states/task/task_details_state.dart';
import 'package:provider/provider.dart';

class TaskInfoView extends StatelessWidget {
  const TaskInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final task = context.watch<TaskDetailsState>().task;
    final taskDetails = task?.taskDetails;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            TaskDetailsItem(
              title: Loco.of(context).taskName,
              subTitle: taskDetails?.name,
            ),
            const SizedBox(height: 16),
            TaskDetailsItem(
              title: Loco.of(context).readingInterval,
              subTitle: taskDetails != null && taskDetails.intervalSeconds != null
                  ? Loco.of(context).minutesSeconds(taskDetails.intervalMinutes ?? 0, taskDetails.intervalSeconds ?? 0)
                  : '-',
            ),
            const SizedBox(height: 16),
            TaskDetailsItem(
              title: Loco.of(context).startMode,
              subTitle: taskInfoStartMode(taskDetails),
            ),
            const SizedBox(height: 16),
            TaskDetailsItem(
              title: Loco.of(context).taskDetailInfoStartDelay,
              subTitle: taskStartDelay(taskDetails),
            ),
            const SizedBox(height: 16),
            TaskDetailsItem(
              title: Loco.of(context).alarmSettings,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${Loco.of(context).alarmLowLimit}${taskDetails != null && taskDetails.alarmLowTemp != null ? temperatureWithSuffix(celcius: taskDetails.alarmLowTemp!) : Loco.of(context).notSpecified}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '${Loco.of(context).taskDetailInfoLowDelay} ${taskDetails != null && (taskDetails.lowDurationMinutes != null || taskDetails.lowDurationSeconds != null) ? Loco.of(context).minutesSeconds(taskDetails.lowDurationMinutes ?? 0, taskDetails.lowDurationSeconds ?? 0) : Loco.of(context).notSpecified}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '${Loco.of(context).alarmHighLimit}${taskDetails != null && taskDetails.alarmHighTemp != null ? temperatureWithSuffix(celcius: taskDetails.alarmHighTemp!) : Loco.of(context).notSpecified}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '${Loco.of(context).taskDetailInfoHighDelay} ${taskDetails != null && (taskDetails.highDurationMinutes != null || taskDetails.highDurationSeconds != null) ? Loco.of(context).minutesSeconds(taskDetails.highDurationMinutes ?? 0, taskDetails.highDurationSeconds ?? 0) : Loco.of(context).notSpecified}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
