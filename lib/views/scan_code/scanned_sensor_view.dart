import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/icons.dart';
import 'package:zsdemo_app/components/status_message.dart';
import 'package:zsdemo_app/components/view_widgets/sensor_info.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/models.dart';
import 'package:zsdemo_app/models/scan_sensors.dart';
import 'package:zsdemo_app/states/sensor/sensor_state.dart';
import 'package:zsdemo_app/views/base_view.dart';
import 'package:provider/provider.dart';

class ScannedSensorView extends StatelessWidget {
  final SensorSerialNumberData sensorId;

  const ScannedSensorView({
    super.key,
    required this.sensorId,
  });

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SensorState>(
      state: context.watch<SensorState>(),
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(sensorId.serialNumber),
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
                            OutlinedButton(
                                child: Text(Loco.of(context).exit),
                                onPressed: () => state.sensorPageState = SensorPageState.scanCode),
                            ElevatedButton(
                              child: Text(Loco.of(context).tryAgain),
                              onPressed: () {
                                state.tryAgain();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (state.busy) {
                return LoadingStatus(label: Loco.of(context).validateSN);
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}
