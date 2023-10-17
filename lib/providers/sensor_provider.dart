import 'package:flutter/widgets.dart';
import 'package:zsdemo_app/services/bluetooth_service.dart';
import 'package:zsdemo_app/services/zsdemo_api_service.dart';
import 'package:zsdemo_app/states/links_state.dart';
import 'package:zsdemo_app/states/mixins/location_mixin.dart';
import 'package:zsdemo_app/states/sensor/sensor_state.dart';
import 'package:provider/provider.dart';

class SensorProvider
    extends ChangeNotifierProxyProvider4<LocationState, LinksState, BluetoothService, ZSDemoAPIService, SensorState> {
  SensorProvider({super.key, Widget? child})
      : super(
          create: (_) => SensorState(),
          child: child,
          update: (context, locationState, linksState, bluetoothService, apiService, sensorState) {
            return sensorState!
              ..locationState = locationState
              ..bluetoothService = bluetoothService
              ..apiService = apiService
              ..sensorId = linksState.setSensorId();
          },
        );
}
