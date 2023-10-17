import 'dart:async';

import 'package:camera/camera.dart';
import 'package:either_option/either_option.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:zsdemo_app/common/extensions/error.dart';
import 'package:zsdemo_app/common/utils/list.dart';
import 'package:zsdemo_app/components/view_widgets/empty_view.dart';
import 'package:zsdemo_app/components/zoom_bar.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/error.dart';
import 'package:zsdemo_app/models/scan_sensors.dart';
import 'package:rxdart/rxdart.dart';

enum CameraState {
  detectedNothing,
  pointAtBarcode,
  cantTakePicture,
  done,
  wrongQRcode,
}

class CameraView extends StatefulWidget {
  final void Function(ScannedData) onDataScanned;
  final FlashMode flashMode;
  final bool enabled;

  const CameraView({
    Key? key,
    required this.onDataScanned,
    this.flashMode = FlashMode.off,
    required this.enabled,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool detectedCamera = false;
  bool minScaleInitialized = false;
  Timer? _detectTimer;
  CameraState cameraState = CameraState.pointAtBarcode;
  final barcodeOutlineKey = GlobalKey();
  late AnimationController zoomController;
  late Tween<double> zoomTween;
  late Animation<double> zoomAnimation;
  bool isDisposed = false;

  @override
  void initState() {
    super.initState();
    debugPrint('initializing camera widget');
    zoomController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    zoomController.addListener(onSlowZoom);
    zoomTween = Tween(begin: _scaleFactor);
    zoomAnimation = zoomTween.animate(zoomController);
    subject.throttleTime(const Duration(milliseconds: 15)).listen((zoom) {
      updateCameraZoom();
    });
    initCamera();
  }

  @override
  void didUpdateWidget(CameraView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      if (widget.enabled) {
        Future.delayed(const Duration(milliseconds: 100), () => updateCameraZoom());
        runContinuousImageStream();
      } else {
        updateFlashMode();
        stopContinuousImageStream();
      }
    }
    if (oldWidget.flashMode != widget.flashMode) {
      if (widget.enabled) {
        updateFlashMode();
      }
    }
  }

  void onSlowZoom() {
    setState(() {
      scaleFactor = zoomAnimation.value;
    });
  }

  void slowAnimateZoom(double zoom) {
    _baseScaleFactor = zoom;
    zoomTween = Tween<double>(begin: _scaleFactor, end: zoom);
    zoomAnimation = zoomTween.animate(zoomController);
    zoomController.forward(from: 0);
  }

  void updateFlashMode() {
    try {
      _controller?.setFlashMode(widget.flashMode);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  double _scaleFactor = 1.0;

  double get scaleFactor => _scaleFactor;
  bool isAnimatingFromGestureDetector = false;
  double userSelectedZoom = 1.0;

  BehaviorSubject<double> subject = BehaviorSubject<double>();

  set scaleFactor(double scaleFactor) {
    if (scaleFactor == _scaleFactor) return;
    _scaleFactor = scaleFactor.clamp(minScale, maxScale);
    subject.add(_scaleFactor);
  }

  double _baseScaleFactor = 1.0;
  Offset focusOffset = const Offset(0.5, 0.5);
  Future<void> updateCameraZoom() async {
    if (!isDisposed) await _controller!.setZoomLevel(scaleFactor.clamp(minScale, maxScale));
  }

  late final double maxScale;
  late final double minScale;
  late CameraDescription camera;
  final BarcodeScanner barcodeScanner = BarcodeScanner(formats: [BarcodeFormat.qrCode]);

  initCamera() async {
    _cameras = await availableCameras();

    camera = _cameras![0];
    onNewCameraSelected(camera);

    setState(() {
      detectedCamera = true;
    });
  }

  bool isRunning = false;

  Future<void> stopContinuousImageStream() async {
    if (_controller!.value.isStreamingImages && !isDisposed) {
      _controller!.stopImageStream();
      setState(() {
        cameraState = CameraState.done;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.setFlashMode(FlashMode.off).then((_) => cameraController.dispose());
    } else if (state == AppLifecycleState.resumed) {
      debugPrint('reinit camera');
      onNewCameraSelected(cameraController.description);
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (_controller != null) {
      setState(() {
        minScaleInitialized = false;
      });
      debugPrint('on new camera dispose');
      if (!isDisposed) await _controller!.dispose();
    }
    final CameraController cameraController = CameraController(
      camera,
      ResolutionPreset.ultraHigh,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    _controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) setState(() {});
      if (cameraController.value.hasError) {
        Some(GenericUserError(message: cameraController.value.errorDescription.toString()))
            .handleOptionError(onErrorTitle: Loco.current.errorCamera);
      }
    });

    try {
      debugPrint('disposed: $isDisposed');
      await cameraController.initialize();

      maxScale = await _controller!.getMaxZoomLevel();
      minScale = await _controller!.getMinZoomLevel();
      setState(() {
        minScaleInitialized = true;
      });
      runContinuousImageStream();
    } on CameraException catch (e) {
      if (e.toString().contains('permission not granted')) {
        if (mounted) {
          Some(
            GenericUserError(title: Loco.current.permissionsNotGranted, message: Loco.current.permissionCamera),
          ).handleOptionError(
            onErrorTitle: Loco.current.permissionCamera,
            onCameraPermissionsErrorTryAgain: (ctx) {
              onNewCameraSelected(cameraDescription);
              Navigator.of(ctx).pop();
            },
          );
        }
      } else {
        if (mounted) {
          Some(GenericUserError(message: e.toString())).handleOptionError(onErrorTitle: Loco.current.exceptionCamera);
        }
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> runContinuousImageStream() async {
    if (isRunning) {
      return;
    }
    if (isDisposed) return;
    setState(() {
      cameraState = CameraState.pointAtBarcode;
    });
    if (isDisposed) return;

    try {
      _controller!.startImageStream((cameraImage) async {
        if (isRunning || isDisposed) return;
        isRunning = true;
        final WriteBuffer allBytes = WriteBuffer();
        for (Plane plane in cameraImage.planes) {
          allBytes.putUint8List(plane.bytes);
        }
        final bytes = allBytes.done().buffer.asUint8List();

        final Size imageSize = Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());
        final InputImageRotation imageRotation =
            InputImageRotationValue.fromRawValue(camera.sensorOrientation) ?? InputImageRotation.rotation0deg;

        final InputImageFormat inputImageFormat =
            InputImageFormatValue.fromRawValue(cameraImage.format.raw) ?? InputImageFormat.yuv420;

        final planeData = cameraImage.planes.map(
          (Plane plane) {
            return InputImagePlaneMetadata(
              bytesPerRow: plane.bytesPerRow,
              height: plane.height,
              width: plane.width,
            );
          },
        ).toList();

        final inputImageData = InputImageData(
          size: imageSize,
          imageRotation: imageRotation,
          inputImageFormat: inputImageFormat,
          planeData: planeData,
        );

        final inputImage = InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

        final List<Barcode> barcodes = await barcodeScanner.processImage(inputImage);

        debugPrint(barcodes.toString());
        if (barcodes.isEmpty) {
          if (isDisposed) return;
          return setState(() {
            cameraState = CameraState.detectedNothing;
            isRunning = false;
          });
        }
        final value = barcodes[0].rawValue;
        if (value == null) {
          if (isDisposed) return;
          return setState(() {
            cameraState = CameraState.detectedNothing;
            isRunning = false;
          });
        }
        final Uri uri = Uri.dataFromString(value);
        if (uri.queryParameters['n'] == null) {
          if (isDisposed) return;
          _controller!.stopImageStream();
          return setState(() {
            cameraState = CameraState.wrongQRcode;
            isRunning = false;
          });
        }
        final ScannedData result = ScannedData.fromMap(uri.queryParameters);
        debugPrint('value: $value done');
        widget.onDataScanned(result);
        if (isDisposed) return;
        return setState(() {
          cameraState = CameraState.done;
          isRunning = false;
        });
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    _controller?.setFlashMode(FlashMode.off);
    if (_controller?.value.isStreamingImages ?? false) {
      _controller?.stopImageStream();
    }
    _controller?.dispose();

    debugPrint('disposing camera');
    barcodeScanner.close();
    _detectTimer?.cancel();
    isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || _controller!.value.previewSize == null) {
      return Center(child: Text(detectedCamera ? Loco.current.qrScanCouldNotDetect : Loco.current.qrScanDetecting));
    }
    return AspectRatio(
      aspectRatio: 1 / _controller!.value.aspectRatio,
      child: GestureDetector(
        onTapUp: (tapUpDetails) {
          final wholeCameraObject = this.context.findRenderObject() as RenderBox;
          setState(() {
            focusOffset = Offset(
              tapUpDetails.localPosition.dx / wholeCameraObject.size.width,
              tapUpDetails.localPosition.dy / wholeCameraObject.size.height,
            );

            debugPrint('focus: ${focusOffset.toString()}');
            _controller?.setFocusPoint(focusOffset);
          });
          tapUpDetails.localPosition;
          debugPrint('tap up');
        },
        onScaleStart: (scale) {
          setState(() {
            scaleFactor = _baseScaleFactor;
            isAnimatingFromGestureDetector = true;
          });
        },
        onScaleUpdate: (details) {
          setState(() {
            scaleFactor = _baseScaleFactor * details.scale;
            isAnimatingFromGestureDetector = true;
          });
        },
        onScaleEnd: (details) {
          setState(() {
            _baseScaleFactor = scaleFactor.clamp(minScale, maxScale);
          });
        },
        child: !_controller!.value.isInitialized
            ? const SizedBox.expand()
            : SizedBox.expand(
                child: Stack(
                  children: [
                    SizedBox.expand(
                      child: LayoutBuilder(
                        builder: (context, c) {
                          return FittedBox(
                            clipBehavior: Clip.hardEdge,
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: c.maxWidth,
                              child: CameraPreview(
                                _controller!,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    LayoutBuilder(builder: (context, constraints) {
                      final width = (constraints.maxWidth * 0.8).clamp(0.0, 600.0);
                      final height = (constraints.maxHeight * 0.6).clamp(0.0, 600.0);
                      return Container(
                        decoration: ShapeDecoration(
                          shape: CameraOverlayShape(width, height),
                        ),
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        // child: Center(
                        child: Container(
                          key: barcodeOutlineKey,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 4),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: width,
                          height: height,
                          // ),
                        ),
                      );
                    }),
                    Align(
                      alignment: const Alignment(0.0, 0.83),
                      child: getZoomLevels().isEmpty
                          ? const SizedBox()
                          : ZSZoomBar(
                              onZoomSelected: (zoom) {
                                userSelectedZoom = zoom;
                                isAnimatingFromGestureDetector = false;
                                slowAnimateZoom(zoom.toDouble());
                              },
                              selectedZoom: indexFromValue(),
                              zooms: getZoomLevels(),
                            ),
                    ),
                    Align(
                      alignment: const Alignment(0.0, -0.83),
                      child: Text(
                        () {
                          switch (cameraState) {
                            case CameraState.cantTakePicture:
                              return Loco.current.qrScanCantTakePicture;
                            case CameraState.pointAtBarcode:
                            case CameraState.wrongQRcode:
                              return Loco.current.qrScanPointAtQrcode;
                            case CameraState.detectedNothing:
                              return Loco.current.searching;
                            case CameraState.done:
                              return Loco.current.done;
                          }
                        }(),
                        style: Theme.of(context).primaryTextTheme.bodyLarge,
                      ),
                    ),
                    if (cameraState == CameraState.wrongQRcode) ...[
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: double.infinity,
                        child: ZSEmptyView(
                          title: Text(Loco.current.errorInvalidQrCode),
                          subtitle: Text(Loco.current.errorInvalidQrCodeDescription),
                          button: ElevatedButton(
                            child: Text(Loco.current.tryAgain),
                            onPressed: () async {
                              setState(() {
                                cameraState = CameraState.pointAtBarcode;
                              });
                              runContinuousImageStream();
                            },
                          ),
                        ),
                      )
                    ]
                  ],
                ),
              ),
      ),
    );
  }

  List<double> getZoomLevels() {
    if (!minScaleInitialized) return [];
    final values = {minScale, 2.0, 4.0, 6.0, 8.0};
    values.removeWhere((element) => element < minScale || element > maxScale);
    return values.toList();
  }

  int indexFromValue() {
    final zoom = isAnimatingFromGestureDetector ? scaleFactor : userSelectedZoom;
    if (!minScaleInitialized) return 0;
    final values = getZoomLevels();
    final closestZoom = closest(zoom, values);
    debugPrint(values.indexOf(closestZoom).toString());
    return values.indexOf(closestZoom);
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
