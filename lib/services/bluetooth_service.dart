import 'dart:async';
import 'dart:convert';
import 'package:either_option/either_option.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:zsdemo_app/models/ble_sensor.dart';
import 'package:zsdemo_app/models/error.dart';

const CORE_METHOD_CHANNEL = "zebra.com/core";
const SENSOR_EVENT_CHANNEL = 'zebra.com/sensor';

mixin BluetoothServiceMixin {
  late BluetoothService bluetoothService;
}

class BluetoothService {
  static const MethodChannel _channel = MethodChannel(CORE_METHOD_CHANNEL);
  static const EventChannel _sensorDiscoveryChannel = EventChannel(SENSOR_EVENT_CHANNEL);

  Stream<BLESensor> get discoveredSensor {
    return _sensorDiscoveryChannel.receiveBroadcastStream().map((sensor) => BLESensor.fromJson(sensor));
  }

  Future<Either<BluetoothUserError, bool?>> bindToService() async {
    try {
      final result = await _channel.invokeMethod('bindToService');
      debugPrint("bindToService: $result");
      return Right(result);
    } catch (e) {
      debugPrint("bindToService:error: $e");
      return Left(BluetoothUserError(description: e.toString()));
    }
  }

  Future<Either<BluetoothUserError, BLESensor>> getSensor(String serialNumber) async {
    try {
      final value = await _channel.invokeMethod<String?>('getSensor', {"serialNumber": serialNumber});

      if (value != null) {
        return Right(BLESensor.fromMap(jsonDecode(value)));
      } else {
        return Left(const BluetoothUserError(description: 'Couldn\' fetch sensor information'));
      }
    } catch (e) {
      debugPrint("getSensor:error: $e");
      return Left(BluetoothUserError(description: e.toString()));
    }
  }

  Future<Either<BluetoothUserError, bool?>> connectToSensor(BLESensor sensor) async {
    try {
      final result = await _channel.invokeMethod<bool>("connectToSensor", {"address": sensor.macAddress});
      debugPrint("connectToSensor: $result");
      return Right(result);
    } catch (e) {
      debugPrint("connectToSensor:error: $e");
      return Left(BluetoothUserError(description: e.toString()));
    }
  }

  Future<Either<BluetoothUserError, bool?>> disconnectCurrentSensor(BLESensor sensor) async {
    try {
      final result = await _channel.invokeMethod<bool>(
        "disconnectCurrentSensor",
        {"address": sensor.macAddress},
      );
      debugPrint("disconnectCurrentSensor: $result");
      return Right(result);
    } catch (e) {
      debugPrint("disconnectCurrentSensor:error: $e");
      return Left(BluetoothUserError(description: e.toString()));
    }
  }

  //TODO refactor aidl related calls into own "AIDL service?" - seems most of this doesn't belong here..
  Future<Either<BluetoothUserError, bool?>> areZSFinderPermissionsGranted() async {
    try {
      final result = await _channel.invokeMethod<bool>("getPermissionsGrantedStatus");
      debugPrint("areZSFinderPermissionsGranted: $result");
      return Right(result);
    } catch (e) {
      debugPrint("areZSFinderPermissionsGranted:error: $e");
      return Left(BluetoothUserError(description: e.toString()));
    }
  }

  Future<Either<BluetoothUserError, bool?>> isClientCompatible(int clientVersion, int clientRevision) async {
    try {
      final result = await _channel.invokeMethod<bool>(
        "isClientCompatibleWithService",
        {"clientVersion": clientVersion, "clientRevision": clientRevision},
      );
      debugPrint("isClientCompatible: $result Demo AIDL v$clientVersion.$clientRevision");
      return Right(result);
    } catch (e) {
      debugPrint("isClientCompatible:error: $e");
      return Left(BluetoothUserError(description: e.toString()));
    }
  }

  Future<Either<BluetoothUserError, bool?>> clientHasAuthToken() async {
    try {
      final result = await _channel.invokeMethod<bool>("clientHasAuthToken");
      debugPrint("clientHasAuthToken: $result");
      return Right(result);
    } catch (e) {
      debugPrint("clientHasAuthToken:error: $e");
      return Left(BluetoothUserError(description: e.toString()));
    }
  }

  Future<void> setClientAuthToken(String token) async {
    try {
      final result = await _channel.invokeMethod(
        "setAuthToken",
        {"authToken": token},
      );
      debugPrint("setAuthToken: $result");
    } catch (e) {
      debugPrint("setAuthToken:error: $e");
    }
  }

  Future<bool> isServiceBound() async {
    final bool result;
    try {
      result = await _channel.invokeMethod("getServiceBound");
      debugPrint("getServiceBound: $result");
      return result;
    } catch (e) {
      debugPrint("getServiceBound:error: $e");
      return false;
    }
  }

  Future<void> prioritizeSensor(String sensorId) async {
    try {
      await _channel.invokeMethod('prioritizeSensor', {"sensorId": sensorId});
    } catch (e) {
      debugPrint("prioritizeSensor:error: $e");
    }
  }
}
