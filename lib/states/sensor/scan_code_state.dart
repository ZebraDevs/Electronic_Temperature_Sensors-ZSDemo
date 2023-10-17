import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:zsdemo_app/models/scan_sensors.dart';
import 'package:zsdemo_app/states/base_state.dart';

class ScanCodeState extends BaseState {
  TextEditingController sensorIdController = TextEditingController();

  CameraController? camera;
  bool get torchOn => camera?.value.flashMode == FlashMode.torch;

  void initCamera([CameraController? cameraController]) {
    if (cameraController != null) {
      camera = cameraController;
      notifyListeners();
    }
  }

  Future<void> setTorch() async {
    if (camera?.value.isInitialized == true) {
      await camera!.setFlashMode(torchOn ? FlashMode.off : FlashMode.torch);
      notifyListeners();
    }
  }

  SensorSerialNumberData? _sensorId;
  SensorSerialNumberData? get sensorId => _sensorId;
  set sensorId(SensorSerialNumberData? sensorId) {
    _sensorId = sensorId;
    notifyListeners();
  }

  bool validateScanForm() {
    return sensorId != null && (sensorId?.serialNumber.isNotEmpty ?? false);
  }

  @override
  void dispose() {
    sensorIdController.dispose();
    super.dispose();
  }
}
