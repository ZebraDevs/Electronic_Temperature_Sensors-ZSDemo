import 'package:flutter/material.dart';
import 'package:zsdemo_app/services/bluetooth_service.dart';
import 'package:zsdemo_app/services/zsdemo_api_service.dart';
import 'package:zsdemo_app/states/sensor/sensor_state.dart';
import 'package:zsdemo_app/states/task/associate_sensor_state.dart';
import 'package:provider/provider.dart';

class AssociateSensorProvider
    extends ChangeNotifierProxyProvider3<ZSDemoAPIService, BluetoothService, SensorState, AssociateSensorState> {
  AssociateSensorProvider({
    Key? key,
    Widget? child,
  }) : super(
          key: key,
          child: child,
          create: (_) => AssociateSensorState(),
          update: (_, apiService, bluetoothService, sensorState, associateSensorState) {
            return associateSensorState!
              ..apiService = apiService
              ..bluetoothService = bluetoothService
              ..sensorState = sensorState;
          },
        );
}
