import 'package:flutter/material.dart';
import 'package:zsdemo_app/models/scan_sensors.dart';
import 'package:zsdemo_app/views/scan_code/scanned_sensor_view.dart';

class ScannedSensorPage extends MaterialPage {
  ScannedSensorPage({
    required SensorSerialNumberData sensorId,
    required RouteObserver<ModalRoute<dynamic>> observer,
    LocalKey? key,
  }) : super(
          key: key,
          child: ScannedSensorView(sensorId: sensorId),
        );
}
