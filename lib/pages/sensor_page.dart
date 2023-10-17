import 'package:flutter/material.dart';
import 'package:zsdemo_app/providers/sensor_provider.dart';
import 'package:zsdemo_app/views/sensor_view.dart';

class SensorPage extends StatelessWidget {
  static const String routeName = '/sensor';

  const SensorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SensorProvider(
      child: const SensorView(),
    );
  }
}
