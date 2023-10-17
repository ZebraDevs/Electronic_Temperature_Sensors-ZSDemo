import 'dart:developer';

import 'package:zsdemo_app/models/scan_sensors.dart';
import 'package:zsdemo_app/states/base_state.dart';
import 'package:uni_links/uni_links.dart';

class LinksState extends BaseState {
  LinksState() : super(busy: false) {
    _handleIncomingLinks();
    _handleInitialUri();
  }

  ScannedData? _scannedData;
  bool isInitialUrlChecked = false;
  bool isUrlUsed = false;

  set scannedData(ScannedData? scannedData) {
    _scannedData = scannedData;
    notifyListeners();
  }

  ScannedData? get scannedData => _scannedData;

  bool get isUrlAvailable => _scannedData != null && !isUrlUsed;

  SensorSerialNumberData? setSensorId() {
    if (isUrlAvailable) {
      final id = SensorSerialNumberData(serialNumber: scannedData!.serialNumber);
      isUrlUsed = true;
      return id;
    }
    return null;
  }

  void _handleIncomingLinks() {
    linkStream.listen((String? link) {
      if (link != null) {
        isUrlUsed = false;
        var uri = Uri.parse(link.replaceAll("%26", "&"));
        scannedData = ScannedData.fromMap(uri.queryParameters);
      }
    }, onError: (err) {
      log('ERROR IN INITIAL URL', error: err);
    });
  }

  Future<void> _handleInitialUri() async {
    try {
      if (!isInitialUrlChecked) {
        isInitialUrlChecked = true;
        final link = await getInitialLink();
        if (link != null) {
          isUrlUsed = false;
          var uri = Uri.parse(link.replaceAll("%26", "&"));
          scannedData = ScannedData.fromMap(uri.queryParameters);
        }
      }
    } catch (e) {
      log('ERROR IN INITIAL URL', error: e);
    }
  }
}
