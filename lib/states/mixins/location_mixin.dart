import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zsdemo_app/states/base_state.dart';

class LocationState extends BaseState with _LocationMixin {}

mixin LocationStateMixin {
  late LocationState locationState;
}

mixin _LocationMixin {
  bool _serviceEnabled = false;
  late LocationPermission _permissionGranted;
  Position? _locationData;

  Position? get locationData => _locationData;

  Stream<ServiceStatus> checkForLocationService() async* {
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      Geolocator.openLocationSettings();
    }
    yield* Geolocator.getServiceStatusStream();
  }

  Future<void> checkForPermissions() async {
    _permissionGranted = await Geolocator.checkPermission();
    if (_permissionGranted == LocationPermission.denied) {
      _permissionGranted = await Geolocator.requestPermission();
      if (_permissionGranted != LocationPermission.always && _permissionGranted != LocationPermission.whileInUse) {
        return;
      }
    }
  }

  Future<Position?> getLocation() async {
    try {
      final Position loc = await Geolocator.getCurrentPosition();
      return loc;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        await checkForPermissions();
      }
      debugPrint('getUserLocation $e');
      return null;
    }
  }
}
