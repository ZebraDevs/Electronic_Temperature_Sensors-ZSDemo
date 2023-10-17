import 'package:flutter/material.dart';
import 'package:zsdemo_app/states/sensor/scan_code_state.dart';
import 'package:provider/provider.dart';

class ScanCodeProvider extends ChangeNotifierProvider<ScanCodeState> {
  ScanCodeProvider({super.key, Widget? child})
      : super(
          child: child,
          create: (_) => ScanCodeState(),
        );
}
