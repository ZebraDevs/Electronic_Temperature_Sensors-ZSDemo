import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:zsdemo_app/common/extensions/list.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/utils/app_utils.dart';
import 'package:zsdemo_app/components/view_widgets/empty_view.dart';
import 'package:zsdemo_app/components/zoom_bar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vibration/vibration.dart';

import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/common/utils/list.dart';

enum CameraState {
  pointAtBarcode,
  done,
  wrongQRcode,
}

class QrScanner extends StatefulWidget {
  const QrScanner({
    Key? key,
    this.onInit,
    this.onScan,
    this.onCancel,
    this.onStateChange,
    this.cameraIndex,
    this.scanMany = false,
  }) : super(key: key);

  final void Function([CameraController? cameraController])? onInit;
  final void Function(bool isActive)? onStateChange;
  final bool? Function(String qrCode)? onScan;
  final VoidCallback? onCancel;
  final int? cameraIndex;
  final bool scanMany;

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner>
    with WidgetsBindingObserver, WidgetsBindingObserver, SingleTickerProviderStateMixin {
  static const int serviceTimeout = 5; // seconds
  final QrScannerService service = QrScannerService();
  final BarcodeScanner barcodeScanner = BarcodeScanner(formats: [BarcodeFormat.qrCode]);
  final List<double> initZoomLevels = [2.0, 4.0, 6.0, 8.0];
  final cameraResolution = ResolutionPreset.ultraHigh;
  final KeyboardVisibilityController keyboardVisibilityController = KeyboardVisibilityController();
  late StreamSubscription<bool> keyboardSubscription;
  late AnimationController zoomController;
  late Tween<double> zoomTween;
  late Animation<double> zoomAnimation;
  bool isInitialized = false, initializing = false, detecting = false, disposing = false;
  bool isAnimatingFromGestureDetector = false;
  CameraController? camera;
  String? cameraError;
  CameraState cameraState = CameraState.pointAtBarcode;
  List<double> zoomLevels = [];
  double userSelectedZoom = 2.0, _scaleFactor = 2.0, _baseScaleFactor = 2.0;
  double? minScale, maxScale;
  int remainingTime = 0;
  QrScannerFrame qrScannerFrame = const QrScannerFrame();
  AppLifecycleState appLifecycleState = AppLifecycleState.resumed;
  BehaviorSubject<double> subject = BehaviorSubject<double>();
  Offset focusOffset = const Offset(0.5, 0.5);

  double get scaleFactor => _scaleFactor;
  set scaleFactor(double scaleFactor) {
    if (scaleFactor == _scaleFactor || minScale == null || maxScale == null) return;
    _scaleFactor = scaleFactor.clamp(minScale!, maxScale!);
    subject.add(_scaleFactor);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    zoomController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    zoomTween = Tween(begin: _scaleFactor);
    zoomAnimation = zoomTween.animate(zoomController);
    subject.throttleTime(const Duration(milliseconds: 15)).listen((zoom) {
      updateCameraZoom();
    });

    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) async {
      if (appLifecycleState != AppLifecycleState.resumed) return;
      if (visible) {
        if (mounted) setState(() => isInitialized = false);
        widget.onStateChange?.call(false);
        stopScan();
      } else {
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          initCamera();
          widget.onStateChange?.call(true);
        }
      }
    });
    initCamera();
  }

  void onSlowZoom() {
    if (mounted) setState(() => scaleFactor = zoomAnimation.value);
  }

  void slowAnimateZoom(double zoom) {
    _baseScaleFactor = zoom;
    zoomTween = Tween<double>(begin: _scaleFactor, end: zoom);
    zoomAnimation = zoomTween.animate(zoomController);
    zoomController.forward(from: 0);
  }

  void updateCameraZoom() {
    if (minScale == null || maxScale == null) return;
    camera?.setZoomLevel(scaleFactor.clamp(minScale!, maxScale!));
  }

  void initCamera() async {
    if (mounted) {
      setState(() {
        isInitialized = false;
        cameraState = CameraState.pointAtBarcode;
        remainingTime = serviceTimeout;
      });
    }
    while (disposing) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    initializing = true;
    int numRetries = 0;
    const int maxRetries = serviceTimeout * 10;
    while (service.scannerIsActive && numRetries < maxRetries) {
      await Future.delayed(const Duration(milliseconds: 100));
      numRetries++;
      if (mounted) setState(() => remainingTime = ((maxRetries - numRetries) / 10).truncate());
    }
    if (numRetries > 0) {
      debugPrint("Waited ${numRetries * 100} milliseconds to release the QR scanner.");
    }
    if (service.scannerIsActive) {
      cameraError = Loco.current.qrScanBusyTryAgain;
      if (mounted) setState(() => isInitialized = true);
    } else {
      widget.onInit?.call();
      service.scannerIsActive = true;
      await service.initialize();
      final CameraDescription? selectedCamera =
          widget.cameraIndex != null && widget.cameraIndex! > -1 && widget.cameraIndex! < service.deviceCameras.length
              ? service.deviceCameras[widget.cameraIndex!]
              : service.defaultCamera;
      if (selectedCamera != null) {
        camera = CameraController(
          selectedCamera,
          cameraResolution,
          imageFormatGroup: ImageFormatGroup.yuv420,
          enableAudio: false,
        );
        try {
          await camera!.initialize();
          await camera!.lockCaptureOrientation();
          minScale = await camera!.getMinZoomLevel();
          maxScale = await camera!.getMaxZoomLevel();
          zoomLevels = [minScale!, ...initZoomLevels];
          zoomLevels.removeWhere((element) => element < minScale! || element > maxScale!);
          zoomController.addListener(onSlowZoom);
          updateCameraZoom();
          widget.onInit?.call(camera);
        } on CameraException catch (e) {
          cameraError = e.description;
        }
      } else {
        cameraError = Loco.current.qrScanCouldNotDetect;
      }
      if (mounted) {
        setState(() {
          isInitialized = true;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (camera?.value.isInitialized == true) beginScan();
        });
      }
    }
    initializing = false;
  }

  void beginScan() {
    bool waiting = false;
    int imageNumber = 0;
    camera?.startImageStream((CameraImage image) {
      if (detecting || disposing) return;
      if (waiting) return;
      detecting = true;
      detect(image).then(
        (List<Barcode> scanResult) {
          if (imageNumber > 0 &&
              scanResult.length == 1 &&
              (scanResult[0].rawValue ?? '').isNotEmpty &&
              qrScannerFrame.hasBarcode(scanResult[0].boundingBox)) {
            if (widget.scanMany) {
              waiting = true;
              Timer(const Duration(milliseconds: 1000), () => waiting = false);
            }
            service.vibrate();
            final bool? validQR = widget.onScan?.call(scanResult[0].rawValue!);
            if (widget.scanMany) {
              if (validQR == false) {
                if (mounted) setState(() => cameraState = CameraState.wrongQRcode);
                stopScan(whileDetecting: true);
              }
            } else {
              if (mounted) {
                setState(() => cameraState = validQR != false ? CameraState.done : CameraState.wrongQRcode);
              }
              stopScan(whileDetecting: true);
            }
          }
          if (imageNumber == 0) imageNumber++;
        },
      ).whenComplete(() => detecting = false);
    });
  }

  Future<List<Barcode>> detect(CameraImage image) async {
    return await barcodeScanner.processImage(
      InputImage.fromBytes(
        bytes: concatenatePlanes(image.planes),
        inputImageData: InputImageData(
          inputImageFormat: InputImageFormatValue.fromRawValue(image.format.raw) ?? InputImageFormat.yuv420,
          size: Size(image.width.toDouble(), image.height.toDouble()),
          imageRotation: InputImageRotation.rotation90deg,
          planeData: image.planes.map(
            (Plane plane) {
              return InputImagePlaneMetadata(
                bytesPerRow: plane.bytesPerRow,
                height: plane.height,
                width: plane.width,
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  Uint8List concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  void stopScan({bool whileDetecting = false}) async {
    if (disposing) return;
    disposing = true;
    while (initializing) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    zoomController.removeListener(onSlowZoom);
    if (camera?.value.isInitialized == true && camera?.value.flashMode != FlashMode.off) {
      await camera?.setFlashMode(FlashMode.off);
    }
    if (camera?.value.isStreamingImages == true) await camera?.stopImageStream();
    if (!whileDetecting) {
      while (detecting) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
    await barcodeScanner.close();
    await camera?.dispose();
    camera = null;
    service.scannerIsActive = false;
    disposing = false;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    appLifecycleState = state;
    hideKeyboard(context);
    if (state == AppLifecycleState.paused && cameraState == CameraState.pointAtBarcode) {
      keyboardSubscription.cancel();
      if (mounted) setState(() => isInitialized = false);
      stopScan();
      widget.onCancel?.call();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    keyboardSubscription.cancel();
    stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / (camera?.value.isInitialized == true ? camera!.value.aspectRatio : (16 / 9)),
      child: GestureDetector(
        onTapUp: (tapUpDetails) {
          if (!mounted) return;
          final RenderBox wholeCameraObject = this.context.findRenderObject() as RenderBox;
          setState(() {
            focusOffset = Offset(
              tapUpDetails.localPosition.dx / wholeCameraObject.size.width,
              tapUpDetails.localPosition.dy / wholeCameraObject.size.height,
            );

            debugPrint('focus: ${focusOffset.toString()}');
            camera?.setFocusPoint(focusOffset);
          });
          tapUpDetails.localPosition;
          debugPrint('tap up');
        },
        onScaleStart: (scale) {
          if (!mounted) return;
          setState(() {
            scaleFactor = _baseScaleFactor;
            isAnimatingFromGestureDetector = true;
          });
        },
        onScaleUpdate: (details) {
          if (!mounted) return;
          setState(() {
            scaleFactor = _baseScaleFactor * details.scale;
            isAnimatingFromGestureDetector = true;
          });
        },
        onScaleEnd: (details) {
          if (!mounted || minScale == null || maxScale == null) return;
          setState(() {
            _baseScaleFactor = scaleFactor.clamp(minScale!, maxScale!);
          });
        },
        child: isInitialized && camera?.value.isInitialized == true && cameraState == CameraState.pointAtBarcode
            ? SizedBox.expand(
                child: Stack(
                  children: [
                    SizedBox.expand(
                      child: LayoutBuilder(builder: (context, constraints) {
                        return FittedBox(
                          clipBehavior: Clip.hardEdge,
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: constraints.maxWidth,
                            child: CameraPreview(camera!),
                          ),
                        );
                      }),
                    ),
                    LayoutBuilder(builder: (context, constraints) {
                      qrScannerFrame = QrScannerFrame(
                        constraints: constraints,
                        cameraValue: camera?.value,
                      );
                      return qrScannerFrame;
                    }),
                    Align(
                      alignment: const Alignment(0.0, 0.83),
                      child: zoomLevels.isEmpty
                          ? const SizedBox()
                          : ZSZoomBar(
                              onZoomSelected: (zoom) {
                                userSelectedZoom = zoom;
                                isAnimatingFromGestureDetector = false;
                                slowAnimateZoom(zoom.toDouble());
                              },
                              selectedZoom: getZoomIndex(userSelectedZoom),
                              zooms: zoomLevels,
                            ),
                    ),
                    Align(
                      alignment: const Alignment(0.0, -0.83),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              Loco.current.qrScanPointAtQrcode,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).primaryTextTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox.expand(
                child: Center(
                  child: () {
                    if (cameraState == CameraState.done) {
                      return ZSEmptyView(
                        title: Text(Loco.current.done),
                        subtitle: const SizedBox(),
                        button: ElevatedButton(
                          child: Text(Loco.current.qrScanAgain),
                          onPressed: () {
                            if (keyboardVisibilityController.isVisible) {
                              hideKeyboard(context);
                            } else {
                              initCamera();
                            }
                          },
                        ),
                      );
                    } else if (cameraState == CameraState.wrongQRcode) {
                      return ZSEmptyView(
                        title: Text(Loco.current.errorInvalidQrCode),
                        subtitle: Text(Loco.current.errorInvalidQrCodeDescription),
                        button: ElevatedButton(
                          onPressed: initCamera,
                          child: Text(Loco.current.tryAgain),
                        ),
                      );
                    } else {
                      if (isInitialized) {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Icon(
                              Icons.no_photography,
                              size: MediaQuery.of(context).size.width * .2,
                              color: ZSColors.error,
                            ),
                            if (cameraError != null)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                child: Text(cameraError!, textAlign: TextAlign.center),
                              ),
                          ],
                        );
                      } else if (!keyboardVisibilityController.isVisible) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            if (remainingTime > 0 && remainingTime < serviceTimeout - 1) Text("$remainingTime"),
                          ],
                        );
                      }
                    }
                  }(),
                ),
              ),
      ),
    );
  }

  int getZoomIndex(double zoom) {
    final zoom = isAnimatingFromGestureDetector ? scaleFactor : userSelectedZoom;
    if (minScale == null || maxScale == null) return 0;
    final closestZoom = closest(zoom, zoomLevels);
    return zoomLevels.indexOf(closestZoom);
  }
}

class QrScannerFrame extends StatefulWidget {
  final BoxConstraints? constraints;
  final CameraValue? cameraValue;

  const QrScannerFrame({
    this.constraints,
    this.cameraValue,
    Key? key,
  }) : super(key: key);

  @override
  State<QrScannerFrame> createState() => _QrScannerFrameState();

  bool hasBarcode(Rect? boundingBox) => boundingBox == null || _QrScannerFrameState.previewScale == null
      ? false
      : boundingBox.top / _QrScannerFrameState.previewScale! >=
              _QrScannerFrameState.frameTop! + _QrScannerFrameState.previewOffset! &&
          boundingBox.bottom / _QrScannerFrameState.previewScale! <=
              _QrScannerFrameState.frameTop! +
                  _QrScannerFrameState.frameHeight! +
                  _QrScannerFrameState.previewOffset! &&
          boundingBox.left / _QrScannerFrameState.previewScale! >= _QrScannerFrameState.frameLeft! &&
          boundingBox.right / _QrScannerFrameState.previewScale! <=
              _QrScannerFrameState.frameLeft! + _QrScannerFrameState.frameWidth!;
}

class _QrScannerFrameState extends State<QrScannerFrame> {
  static double? frameTop, frameLeft, frameWidth, frameHeight, previewScale, previewOffset;

  @override
  void initState() {
    super.initState();
    calculate();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    calculate();
  }

  void calculate() {
    if (widget.constraints == null || widget.cameraValue == null) {
      previewScale = null;
      return;
    }
    frameWidth = (widget.constraints!.maxWidth * 0.8).clamp(0.0, 600.0);
    frameHeight = (widget.constraints!.maxHeight * 0.6).clamp(0.0, 600.0);
    frameTop = (widget.constraints!.maxHeight - frameHeight!) / 2;
    frameLeft = (widget.constraints!.maxWidth - frameWidth!) / 2;
    previewScale = widget.cameraValue!.isInitialized == true
        ? (widget.cameraValue!.previewSize?.height ?? 0) / widget.constraints!.maxWidth
        : null;
    if (previewScale == 0) previewScale = null;
    previewOffset = previewScale == null
        ? null
        : ((widget.cameraValue!.previewSize?.width ?? 0) / previewScale! - widget.constraints!.maxHeight) / 2;
  }

  @override
  Widget build(BuildContext context) {
    return previewScale == null
        ? const SizedBox()
        : Container(
            decoration: ShapeDecoration(
              shape: CameraOverlayShape(frameWidth!, frameHeight!),
            ),
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 4),
                borderRadius: BorderRadius.circular(8),
              ),
              width: frameWidth,
              height: frameHeight,
            ),
          );
  }
}

class CameraOverlayShape extends ShapeBorder {
  final double width;
  final double height;

  const CameraOverlayShape(this.width, this.height);

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path _getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return _getLeftTopPath(rect)
      ..lineTo(
        rect.right,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.top,
      );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final width = rect.width;
    final height = rect.height;
    const borderOffset = 4 / 2;
    final cutOutWidth = this.width;
    final cutOutHeight = this.height;

    final backgroundPaint = Paint()
      ..color = const Color.fromRGBO(0, 0, 0, 80)
      ..style = PaintingStyle.fill;

    final boxPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final cutOutRect = Rect.fromLTWH(
      rect.left + width / 2 - cutOutWidth / 2 + borderOffset,
      -0 + rect.top + height / 2 - cutOutHeight / 2 + borderOffset,
      cutOutWidth - borderOffset * 2,
      cutOutHeight - borderOffset * 2,
    );

    canvas
      ..saveLayer(
        rect,
        backgroundPaint,
      )
      ..drawRect(
        rect,
        backgroundPaint,
      )
      ..drawRRect(
        RRect.fromRectAndRadius(
          cutOutRect,
          const Radius.circular(8),
        ),
        boxPaint,
      )
      ..restore();
  }

  @override
  ShapeBorder scale(double t) {
    return CameraOverlayShape(width, height);
  }
}

class QrScannerService {
  static final QrScannerService _instance = QrScannerService._();
  factory QrScannerService() => _instance;
  QrScannerService._();

  late final List<CameraDescription> deviceCameras;
  late final CameraDescription? defaultCamera;
  late final bool _hasVibrator, _hasCustomVibrationsSupport;
  bool isInitialized = false, scannerIsActive = false;

  Future<void> initialize() async {
    if (isInitialized) return;

    deviceCameras = await availableCameras();
    defaultCamera = deviceCameras.isEmpty
        ? null
        : deviceCameras
            .firstWhereOrNull((CameraDescription camera) => camera.lensDirection == CameraLensDirection.back);
    if (defaultCamera == null && deviceCameras.isNotEmpty) defaultCamera = deviceCameras[0];

    _hasVibrator = await Vibration.hasVibrator() ?? false;
    if (_hasVibrator) {
      _hasCustomVibrationsSupport = await Vibration.hasCustomVibrationsSupport() ?? false;
    }

    isInitialized = true;
  }

  void vibrate() async {
    if (_hasVibrator) {
      if (_hasCustomVibrationsSupport) {
        Vibration.vibrate(duration: 100);
      } else {
        Vibration.vibrate();
        await Future.delayed(const Duration(milliseconds: 100));
        Vibration.cancel();
      }
    }
  }
}
