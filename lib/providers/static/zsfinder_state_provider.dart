import 'package:flutter/material.dart';
import 'package:zsdemo_app/services/bluetooth_service.dart';
import 'package:zsdemo_app/states/static/zsfinder_state.dart';
import 'package:provider/provider.dart';
import '../../services/zsdemo_api_service.dart';

class ZsfinderStateProvider extends ChangeNotifierProxyProvider2<BluetoothService, ZSDemoAPIService, ZSFinderState> {
  ZsfinderStateProvider({Key? key, Widget? child})
      : super(
          key: key,
          create: (_) => ZSFinderState(),
          child: child,
           update: (context, bluetoothService, apiService, zsFinderState) {
              return zsFinderState!
                ..bluetoothService = bluetoothService
                ..apiService = apiService;
              },
      );
}
