import 'package:flutter/material.dart';
import 'package:zsdemo_app/app.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/components/status_message.dart';
import 'package:zsdemo_app/components/view_widgets/sensor_info.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/scan_sensors.dart';
import 'package:zsdemo_app/states/task/associate_sensor_state.dart';
import 'package:zsdemo_app/views/base_view.dart';
import 'package:provider/provider.dart';

class AssociateSensorView extends StatelessWidget {
  const AssociateSensorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Loco.current.createTaskLblCreateTask),
      ),
      body: BaseWidget<AssociateSensorState>(
        state: context.watch<AssociateSensorState>(),
        onStateReady: (state) {
          state.assignSensorToTask();
        },
        builder: (context, state, child) {
          if (state.error != null) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AddSensorStatusBox(
                    status: AddSensorStatus.error,
                    title: Text(Loco.of(context).associateSensorErrorGeneralTitle),
                    subtitle: Text(state.error!.toErrorData().errorDescription),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          child: Text(Loco.of(context).exit),
                          onPressed: () => navigatorKey.currentState!.maybePop(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          if (state.status == AssignSensorState.assignedSensor) {
            return StatusMessage(
              key: const ValueKey('SensorEnrollSuccessPage'),
              icon: const Icon(
                Icons.check_circle,
                color: ZSColors.success,
              ),
              title: Loco.of(context).associateSensorTaskCreated,
              description: Loco.current.associateSensorPendingDescription,
              confirmButton: ElevatedButton(
                child: Text(Loco.current.continueLabel),
                onPressed: () => state.sensorState.sensorPageState = SensorPageState.taskDetails,
              ),
            );
          }
          if (state.status == AssignSensorState.associatingSensor) {
            return const LoadingStatus();
          }

          return Center(
            child: Column(
              children: [
                const Text('Associate sensor'),
                ElevatedButton(
                  onPressed: () => state.sensorState.sensorPageState = SensorPageState.scanCode,
                  child: Text(Loco.of(context).exit),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
