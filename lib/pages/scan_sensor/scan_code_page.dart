import 'package:flutter/material.dart';
import 'package:zsdemo_app/models/scan_sensors.dart';
import 'package:zsdemo_app/providers/scan_code_provider.dart';
import 'package:zsdemo_app/views/scan_code/scan_code_view.dart';

class ScanCodePage extends MaterialPage {
  ScanCodePage({
    required void Function(SensorSerialNumberData?) onSensorId,
    required RouteObserver<ModalRoute<dynamic>> observer,
    LocalKey? key,
  }) : super(
          child: ScanCodeScreen(onSensorId: onSensorId, observer: observer),
          key: key,
        );
}

class ScanCodeScreen extends StatelessWidget {
  final void Function(SensorSerialNumberData?) onSensorId;
  static const String routeName = "/scan-code";
  final RouteObserver<ModalRoute<dynamic>> observer;

  const ScanCodeScreen({Key? key, required this.onSensorId, required this.observer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScanCodeProvider(
      child: ScanCodeView(onSensorId: onSensorId, observer: observer),
    );
  }
}
