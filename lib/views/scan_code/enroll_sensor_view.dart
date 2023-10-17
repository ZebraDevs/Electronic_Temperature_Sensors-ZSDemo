import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/styles/icons.dart';
import 'package:zsdemo_app/components/status_message.dart';
import 'package:zsdemo_app/components/view_widgets/sensor_info.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/scan_sensors.dart';
import 'package:zsdemo_app/states/sensor/enroll_sensor_state.dart';
import 'package:zsdemo_app/views/base_view.dart';
import 'package:provider/provider.dart';

class EnrollSensorView extends StatelessWidget {
  final SensorSerialNumberData sensorId;

  const EnrollSensorView({
    super.key,
    required this.sensorId,
  });

  @override
  Widget build(BuildContext context) {
    return BaseWidget<EnrollSensorState>(
      state: context.watch<EnrollSensorState>(),
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Loco.of(context).enrollSensorLabel),
            leading: IconButton(
              icon: const Icon(ZSIcons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Builder(
            builder: (_) {
              if (state.error != null) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AddSensorStatusBox(
                        status: AddSensorStatus.error,
                        title: Text(state.error!.toErrorData().errorTitle),
                        subtitle: Text(state.error!.toErrorData().errorDescription),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(child: Text(Loco.of(context).exit), onPressed: () => state.scanAgain()),
                            OutlinedButton(
                              child: Text(Loco.of(context).tryAgain),
                              onPressed: () => state.tryAgain(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (state.enrollmentStatus == EnrollmentStatus.enrollSensor) {
                return StatusMessage(
                  key: const ValueKey('SensorEnrollPage'),
                  title: Loco.of(context).enrollSensorTitle(state.sensorState.sensorId!.serialNumber),
                  description: Loco.of(context).enrollSensolText,
                  dismissButton: OutlinedButton(
                    child: Text(Loco.of(context).exit),
                    onPressed: () => state.scanAgain(),
                  ),
                  confirmButton: ElevatedButton(
                    child: Text(Loco.of(context).continueLabel),
                    onPressed: () async {
                      await state.enrollSensor();
                    },
                  ),
                );
              }
              if (state.enrollmentStatus == EnrollmentStatus.verifyingSensorEnrollment) {
                return LoadingStatus(
                  label: Loco.of(context).enrollSensorVerify,
                  description: Loco.of(context).enrollSensorVerifyDesc,
                );
              }
              if (state.enrollmentStatus == EnrollmentStatus.sensorEnrolledOtherTenant) {
                return StatusMessage(
                  key: const ValueKey('SensorEnrolledOtherTenantPage'),
                  icon: const Icon(
                    ZSIcons.warning,
                    color: ZSColors.warning,
                    size: 35,
                  ),
                  title: Loco.of(context).enrolledSensorTitle(state.sensorState.sensorId!.serialNumber),
                  description: Loco.of(context).enrolledSensorText,
                  confirmButton: ElevatedButton(
                    child: Text(Loco.of(context).scanAnotherSensorLabel),
                    onPressed: () => state.scanAgain(),
                  ),
                );
              }
              if (state.enrollmentStatus == EnrollmentStatus.pendingEnrollment) {
                return StatusMessage(
                  key: const ValueKey('SensorEnrollPendingPage'),
                  icon: const Icon(
                    ZSIcons.warning,
                    color: ZSColors.warning,
                    size: 35,
                  ),
                  title: Loco.of(context).enrollSensorPendingTitle(state.sensorState.sensorId!.serialNumber),
                  description: Loco.of(context).enrollSensorPendingText,
                  dismissButton: OutlinedButton(
                    child: Text(Loco.of(context).exit),
                    onPressed: () => state.scanAgain(),
                  ),
                  confirmButton: ElevatedButton(
                    child: Text(Loco.of(context).continueLabel),
                    onPressed: () async {
                      await state.verifyEnrollment();
                    },
                  ),
                );
              }
              if (state.enrollmentStatus == EnrollmentStatus.notVerifiedEnrollment) {
                return StatusMessage(
                  key: const ValueKey('SensorEnrollNotVerifiedPage'),
                  icon: const Icon(
                    ZSIcons.warning,
                    color: ZSColors.warning,
                    size: 35,
                  ),
                  title: Loco.of(context).enrollSensorNotVerifiedTitle(state.sensorState.sensorId!.serialNumber),
                  description: Loco.of(context).enrollSensorNotVerifiedText,
                  dismissButton: OutlinedButton(
                    child: Text(Loco.of(context).exit),
                    onPressed: () => state.scanAgain(),
                  ),
                  confirmButton: ElevatedButton(
                    child: Text(Loco.of(context).continueLabel),
                    onPressed: () async {
                      await state.verifyEnrollment();
                    },
                  ),
                );
              }
              if (state.enrollmentStatus == EnrollmentStatus.enrollSensorSuccess) {
                return StatusMessage(
                  key: const ValueKey('SensorEnrollSuccessPage'),
                  icon: const Icon(
                    ZSIcons.check_circle,
                    color: ZSColors.success,
                    size: 35,
                  ),
                  title: Loco.of(context).enrollSensorSuccessTitle(state.sensorState.sensorId!.serialNumber),
                  description: Loco.of(context).enrollSensorSuccessText,
                  dismissButton: OutlinedButton(
                    child: Text(Loco.of(context).exit),
                    onPressed: () => state.scanAgain(),
                  ),
                  confirmButton: ElevatedButton(
                    child: Text(Loco.of(context).createTaskLabel),
                    onPressed: () => state.sensorState.populateSensor(state.sensor!),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}
