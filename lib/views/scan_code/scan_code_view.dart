import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:zsdemo_app/components/qr_scanner.dart';
import 'package:zsdemo_app/common/styles/icons.dart';
import 'package:zsdemo_app/common/utils/app_utils.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/scan_sensors.dart';
import 'package:zsdemo_app/states/sensor/scan_code_state.dart';
import 'package:zsdemo_app/views/base_view.dart';
import 'package:zsdemo_app/views/scan_code/qr_view.dart';
import 'package:zsdemo_app/views/scan_code/scan_code_input_view.dart';
import 'package:provider/provider.dart';

class ScanCodeView extends StatefulWidget {
  final void Function(SensorSerialNumberData?) onSensorId;
  final RouteObserver observer;

  const ScanCodeView({Key? key, required this.onSensorId, required this.observer}) : super(key: key);

  @override
  State<ScanCodeView> createState() => _ScanCodeViewState();
}

class _ScanCodeViewState extends State<ScanCodeView> with RouteAware {
  late ScanCodeState state;

  @override
  void initState() {
    debugPrint('init scan code');
    state = context.read<ScanCodeState>();
    super.initState();
  }

  bool flashButtonVisible = true, flashButtonEnabled = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.observer.subscribe(this, ModalRoute.of(context) as PageRoute);
    state = context.read<ScanCodeState>();
  }

  bool _cameraEnabled = true;
  bool get cameraEnabled => _cameraEnabled;

  /// the following code is in the [CameraView] in didChange
  /// ```dart
  /// if (!enabled) {
  ///   updateFlash();
  ///   stopCamera();
  /// }
  /// if (enabled) updateFlash();
  /// ```
  ///
  /// We propage it first by disabling the flash, so that the [CameraView] reacts.
  ///
  /// Then we disable the camera. If we did the reverse, it would not turn the flash off because of the second if
  set cameraEnabled(bool cameraEnabled) {
    Future.microtask(() {
      if (!cameraEnabled) {
        // state.flashState = FlashState.off;
      }
      // this comes sometime after that, so that the state gets receives no flash first and then it receives
      // stop camera
      Future.microtask(() {
        _cameraEnabled = cameraEnabled;
      });
    });
  }

  @override
  void dispose() {
    debugPrint('dispose scan code');
    widget.observer.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    debugPrint('SCAN CODE PUSH');
    super.didPush();
  }

  @override
  void didPopNext() {
    debugPrint('SCAN CODE POP NEXT');
    cameraEnabled = true;
    state = context.read<ScanCodeState>();
    state.sensorId = null;
    state.sensorIdController.text = '';
  }

  @override
  void didPushNext() {
    debugPrint('SCAN CODE PUSH NEXT');
    cameraEnabled = false;
  }

  @override
  void didPop() {
    debugPrint('SCAN CODE POP');
    super.didPop();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      state: context.watch<ScanCodeState>(),
      builder: (BuildContext context, ScanCodeState state, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                hideKeyboard(context);
                Navigator.of(context).pop();
              },
              icon: const Icon(ZSIcons.close),
            ),
            title: Text(Loco.current.scanSensorLabel),
            actions: [
              if (flashButtonVisible)
                IconButton(
                  onPressed: !flashButtonEnabled
                      ? null
                      : () async {
                          setState(() => flashButtonEnabled = false);
                          hideKeyboard(context);
                          await state.setTorch();
                          Future.delayed(const Duration(milliseconds: 500), () {
                            setState(() => flashButtonEnabled = true);
                          });
                        },
                  icon: torchIcon(state.torchOn),
                ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: SizedBox.expand(
                  child: QrScanner(
                    onInit: ([CameraController? camera]) {
                      flashButtonVisible = true;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        state.initCamera(camera);
                      });
                    },
                    onStateChange: (bool isActive) => setState(() => flashButtonVisible = isActive),
                    onScan: (String qrCode) {
                      setState(() => flashButtonVisible = false);
                      hideKeyboard(context);
                      final Uri uri = Uri.dataFromString(qrCode);
                      if ((uri.queryParameters['n'] ?? '').isNotEmpty) {
                        final ScannedData data = ScannedData.fromMap(uri.queryParameters);
                        state.sensorIdController.text = data.serialNumber;
                        state.sensorId = data;
                        return true;
                      }
                      return false;
                    },
                    onCancel: () {
                      hideKeyboard(context);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              ScanCodeInputView(
                onSensorId: widget.onSensorId,
              ),
            ],
          ),
        );
      },
    );
  }

  Icon torchIcon(bool torchOn) {
    return torchOn ? const Icon(ZSIcons.flashlight_on) : const Icon(ZSIcons.flashlight_off);
  }
}
