import 'dart:convert';

import 'package:zsdemo_app/generated/l10n.dart';

class AssociateSensorResponse {
  final List<AssociateSensor> associatedSensors;
  final List<FailedSensor> failedSensors;

  AssociateSensorResponse(
    this.associatedSensors,
    this.failedSensors,
  );

  AssociateSensorResponse copyWith({
    List<AssociateSensor>? associatedSensors,
    List<FailedSensor>? failedSensors,
  }) {
    return AssociateSensorResponse(
      associatedSensors ?? this.associatedSensors,
      failedSensors ?? this.failedSensors,
    );
  }

  factory AssociateSensorResponse.fromMap(Map<String, dynamic> map) {
    return AssociateSensorResponse(
      List<AssociateSensor>.from(
        (map['associated_sensors'] as List<dynamic>).map<AssociateSensor>(
          (as) => AssociateSensor.fromMap(as),
        ),
      ),
      List<FailedSensor>.from(
        (map['failed_sensors'] as List<dynamic>).map<FailedSensor>(
          (fs) => FailedSensor.fromMap(fs),
        ),
      ),
    );
  }

  factory AssociateSensorResponse.fromJson(String source) =>
      AssociateSensorResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AssociateSensorResponse(associatedSensors: $associatedSensors, failedSensors: $failedSensors)';
}

class AssociateSensor {
  final String sensorId;
  final String sensorTaskId;

  AssociateSensor({
    required this.sensorId,
    required this.sensorTaskId,
  });

  AssociateSensor copyWith({
    String? sensorId,
    String? sensorTaskId,
  }) {
    return AssociateSensor(
      sensorId: sensorId ?? this.sensorId,
      sensorTaskId: sensorTaskId ?? this.sensorTaskId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sensor_id': sensorId,
      'sensor_task_id': sensorTaskId,
    };
  }

  factory AssociateSensor.fromMap(Map<String, dynamic> map) {
    return AssociateSensor(
      sensorId: map['sensor_id'] as String,
      sensorTaskId: map['sensor_task_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssociateSensor.fromJson(String source) =>
      AssociateSensor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AssociateSensor(sensorId: $sensorId, sensorTaskId: $sensorTaskId)';

  @override
  bool operator ==(covariant AssociateSensor other) {
    if (identical(this, other)) return true;

    return other.sensorId == sensorId && other.sensorTaskId == sensorTaskId;
  }

  @override
  int get hashCode => sensorId.hashCode ^ sensorTaskId.hashCode;
}

class FailedSensor {
  final String sensorId;
  final FailedSensorError? error;

  FailedSensor({
    required this.sensorId,
    required this.error,
  });

  FailedSensor copyWith({
    String? sensorId,
    FailedSensorError? error,
  }) {
    return FailedSensor(
      sensorId: sensorId ?? this.sensorId,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sensor_id': sensorId,
      'failed_sensor_error': error?.asString(),
    };
  }

  factory FailedSensor.fromMap(Map<String, dynamic> map) {
    return FailedSensor(
      sensorId: map['sensor_id'] as String,
      error: toFailedSensorError(map['failed_sensor_error'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory FailedSensor.fromJson(String source) => FailedSensor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FailedSensor(sensorId: $sensorId, error: $error)';

  @override
  bool operator ==(covariant FailedSensor other) {
    if (identical(this, other)) return true;

    return other.sensorId == sensorId && other.error == error;
  }

  @override
  int get hashCode => sensorId.hashCode ^ error.hashCode;
}

enum FailedSensorError {
  FAILED_SENSOR_ERROR_UNSPECIFIED,
  FAILED_SENSOR_ERROR_SENSOR_LOW_BATTERY,
  FAILED_SENSOR_ERROR_SENSOR_ACTIVE,
  FAILED_SENSOR_ERROR_PENDING_UNENROLLMENT,
}

extension FailedSensorErrorExt on FailedSensorError {
  String asString() {
    switch (this) {
      case FailedSensorError.FAILED_SENSOR_ERROR_UNSPECIFIED:
        return Loco.current.associateSensorErrorUnspecified;
      case FailedSensorError.FAILED_SENSOR_ERROR_SENSOR_LOW_BATTERY:
        return Loco.current.associateSensorErrorLowBattery;
      case FailedSensorError.FAILED_SENSOR_ERROR_SENSOR_ACTIVE:
        return Loco.current.associateSensorErrorActive;
      case FailedSensorError.FAILED_SENSOR_ERROR_PENDING_UNENROLLMENT:
        return Loco.current.associateSensorErrorPendingUnenrollment;
    }
  }
}

FailedSensorError? toFailedSensorError(String status) {
  switch (status) {
    case 'FAILED_SENSOR_ERROR_UNSPECIFIED':
      return FailedSensorError.FAILED_SENSOR_ERROR_UNSPECIFIED;
    case 'FAILED_SENSOR_ERROR_SENSOR_LOW_BATTERY':
      return FailedSensorError.FAILED_SENSOR_ERROR_SENSOR_LOW_BATTERY;
    case 'FAILED_SENSOR_ERROR_SENSOR_ACTIVE':
      return FailedSensorError.FAILED_SENSOR_ERROR_SENSOR_ACTIVE;
    case 'FAILED_SENSOR_ERROR_PENDING_UNENROLLMENT':
      return FailedSensorError.FAILED_SENSOR_ERROR_PENDING_UNENROLLMENT;
    default:
      return FailedSensorError.FAILED_SENSOR_ERROR_UNSPECIFIED;
  }
}
