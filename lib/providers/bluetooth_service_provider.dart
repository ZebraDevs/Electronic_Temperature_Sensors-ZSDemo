import 'package:flutter/material.dart';
import 'package:zsdemo_app/services/bluetooth_service.dart';
import 'package:provider/provider.dart';

class BluetoothServiceProvider extends Provider<BluetoothService> {
  BluetoothServiceProvider({Key? key, Widget? child})
      : super(
          key: key,
          create: (_) => BluetoothService(),
          child: child,
        );
}
