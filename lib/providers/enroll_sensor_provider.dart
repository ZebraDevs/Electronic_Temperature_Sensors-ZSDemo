import 'package:flutter/material.dart';
import 'package:zsdemo_app/services/bluetooth_service.dart';
import 'package:zsdemo_app/services/zsdemo_api_service.dart';
import 'package:zsdemo_app/states/sensor/enroll_sensor_state.dart';
import 'package:zsdemo_app/states/sensor/sensor_state.dart';
import 'package:provider/provider.dart';

class EnrollSensorProvider
    extends ChangeNotifierProxyProvider3<ZSDemoAPIService, BluetoothService, SensorState, EnrollSensorState> {
  EnrollSensorProvider({
    Key? key,
    Widget? child,
  }) : super(
          key: key,
          child: child,
          create: (_) => EnrollSensorState(),
          update: (_, apiService, bleService, sensorState, enrollSensorState) {
            return enrollSensorState!
              ..apiService = apiService
              ..bluetoothService = bleService
              ..sensorState = sensorState;
          },
        );
}
