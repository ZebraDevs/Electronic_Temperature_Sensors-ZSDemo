import 'package:flutter/material.dart';
import 'package:zsdemo_app/models/scan_sensors.dart';
import 'package:zsdemo_app/providers/enroll_sensor_provider.dart';
import 'package:zsdemo_app/views/scan_code/enroll_sensor_view.dart';

class EnrollSensorPage extends MaterialPage {
  EnrollSensorPage({
    required SensorSerialNumberData sensorId,
    required RouteObserver<ModalRoute<dynamic>> observer,
    LocalKey? key,
  }) : super(
          key: key,
          child: EnrollSensorProvider(
            child: EnrollSensorView(sensorId: sensorId),
          ),
        );
}
