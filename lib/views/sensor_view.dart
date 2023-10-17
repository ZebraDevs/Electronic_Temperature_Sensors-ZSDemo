import 'package:flutter/material.dart';
import 'package:zsdemo_app/models/scan_sensors.dart';
import 'package:zsdemo_app/pages/scan_sensor/associate_sensor_page.dart';
import 'package:zsdemo_app/pages/scan_sensor/enroll_sensor_page.dart';
import 'package:zsdemo_app/pages/scan_sensor/scan_code_page.dart';
import 'package:zsdemo_app/pages/scan_sensor/scanned_sensor_page.dart';
import 'package:zsdemo_app/pages/task/create_task_page.dart';
import 'package:zsdemo_app/pages/task/task_details_page.dart';
import 'package:zsdemo_app/states/sensor/sensor_state.dart';
import 'package:zsdemo_app/views/base_view.dart';
import 'package:provider/provider.dart';

RouteObserver<ModalRoute<dynamic>> _routeObserver = RouteObserver<ModalRoute<dynamic>>();

class SensorView extends StatelessWidget {
  const SensorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      state: context.watch<SensorState>(),
      builder: (context, state, _) {
        return Navigator(
          observers: [_routeObserver],
          onPopPage: (route, result) {
            route.popped.then((value) {
              Navigator.of(context).pop();
            });
            return route.didPop(result);
          },
          pages: [
            if (state.sensorPageState == SensorPageState.scanCode)
              ScanCodePage(
                key: const ValueKey('ScanCodePage'),
                observer: _routeObserver,
                onSensorId: (sensorId) async {
                  state.sensorId = sensorId;
                },
              ),
            if (state.sensorPageState == SensorPageState.validateSN)
              ScannedSensorPage(
                key: const ValueKey('ValidateSN'),
                observer: _routeObserver,
                sensorId: state.sensorId!,
              ),
            if (state.sensorPageState == SensorPageState.enrollSensor)
              EnrollSensorPage(
                key: const ValueKey('ScannedCodePage'),
                observer: _routeObserver,
                sensorId: state.sensorId!,
              ),
            if (state.sensorPageState == SensorPageState.createTask)
              CreateTaskPage(
                key: const ValueKey('CreateTaskPage'),
                observer: _routeObserver,
              ),
            if (state.sensorPageState == SensorPageState.taskDetails)
              TaskDetailsPage(
                sensor: state.sensor!,
                key: const ValueKey('TaskDetailsPage'),
                observer: _routeObserver,
              ),
            if (state.sensorPageState == SensorPageState.associateSensor)
              AssociateSensorPage(
                key: const ValueKey('AssociateSensorPage'),
              ),
          ],
        );
      },
    );
  }
}
