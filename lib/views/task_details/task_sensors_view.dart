import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/enums/enums.dart';
import 'package:zsdemo_app/common/utils/date.dart';
import 'package:zsdemo_app/components/details_item.dart';
import 'package:zsdemo_app/components/error_widget.dart';
import 'package:zsdemo_app/components/is_loading_widget.dart';
import 'package:zsdemo_app/components/view_widgets/empty_view.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/models.dart';
import 'package:zsdemo_app/states/task/task_sensors_state.dart';
import 'package:zsdemo_app/views/base_view.dart';
import 'package:provider/provider.dart';

class TaskSensorsView extends StatelessWidget {
  const TaskSensorsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TaskSensorsState>(
      state: context.watch<TaskSensorsState>(),
      onStateReady: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          state.getTaskSensors();
        });
      },
      builder: (context, state, child) {
        switch (state.taskSensorsState) {
          case ResponseState.isLoading:
            return IsLoadingView(
              message: Loco.of(context).checkingForTaskSensors,
            );
          case ResponseState.error:
            return ErrorView(
              error: state.error,
              onTryAgain: state.getTaskSensors,
            );
          default:
            if (state.sensors.isEmpty) {
              return Center(
                child: ZSEmptyView(
                  title: Text(Loco.of(context).taskDetailsNoSensors),
                  subtitle: Text(Loco.of(context).taskDetailsNoSensorsDesc),
                  button: OutlinedButton(
                    onPressed: () => state.getTaskSensors(),
                    child: Text(Loco.of(context).tryAgain),
                  ),
                ),
              );
            }
            return const SensorsFoundView();
        }
      },
    );
  }
}

class SensorsFoundView extends StatelessWidget {
  const SensorsFoundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TaskSensorsState>();
    final sensors = state.sensors;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: RefreshIndicator(
        onRefresh: state.getTaskSensors,
        child: ListView.separated(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: sensors.length,
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Divider(
              height: 40,
              thickness: 2,
            ),
          ),
          itemBuilder: (context, index) {
            final sensor = sensors[index];
            return _SensorItem(sensor: sensor);
          },
        ),
      ),
    );
  }
}

class _SensorItem extends StatelessWidget {
  const _SensorItem({required this.sensor});
  final Sensor sensor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sensor.name ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 20),
          TaskDetailsItem(title: Loco.of(context).sensorStatus, subTitle: sensor.status?.asLabel()),
          const SizedBox(height: 16),
          TaskDetailsItem(title: Loco.of(context).serialNumber, subTitle: sensor.serialNumber),
          const SizedBox(height: 16),
          TaskDetailsItem(title: Loco.of(context).macAddress, subTitle: sensor.macAddress),
          const SizedBox(height: 16),
          TaskDetailsItem(
            title: Loco.of(context).batteryLevel,
            subTitle: '${sensor.batteryLevel.toString()}%',
          ),
          const SizedBox(height: 16),
          TaskDetailsItem(
            title: Loco.of(context).firmwareVersion,
            subTitle: sensor.firmwareRevision?.toString() ?? '-',
          ),
          const SizedBox(height: 16),
          TaskDetailsItem(
            title: Loco.of(context).lastUpdated,
            subTitle: "${sensor.lastUpdated == null ? null : formatDetailed.format(sensor.lastUpdated!.toLocal())}",
          ),
          if (sensor.unverifiedData != null) ...[
            const SizedBox(height: 16),
            TaskDetailsItem(
              title: Loco.of(context).unverifiedData,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  '${Loco.of(context).dateTitle}: ${sensor.unverifiedData?.lastDateTime != null ? formatDetailed.format(sensor.unverifiedData!.lastDateTime!.toLocal()) : Loco.of(context).notSpecified}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  '${Loco.of(context).alarmTemperature}: ${sensor.unverifiedData?.lastTemperature != null ? Loco.of(context).taskDetailInfoDegree(sensor.unverifiedData!.lastTemperature!) : Loco.of(context).notSpecified}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  '${Loco.of(context).alarm}: ${sensor.unverifiedData?.lastAlarm != null ? sensor.unverifiedData?.lastAlarm == true ? Loco.of(context).yes : Loco.of(context).no : Loco.of(context).notSpecified}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ]),
            ),
          ]
        ],
      ),
    );
  }
}
