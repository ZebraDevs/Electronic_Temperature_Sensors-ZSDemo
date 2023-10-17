import 'package:flutter/material.dart';
import 'package:zsdemo_app/providers/task/associate_sensor_provider.dart';
import 'package:zsdemo_app/views/scan_code/associate_sensor_view.dart';

class AssociateSensorPage extends MaterialPage {
  AssociateSensorPage({
    LocalKey? key,
  }) : super(
          key: key,
          child: AssociateSensorProvider(
            child: const AssociateSensorView(),
          ),
        );
}
