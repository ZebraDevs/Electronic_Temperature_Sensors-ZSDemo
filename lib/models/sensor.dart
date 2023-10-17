import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/page_response.dart';

class Sensor extends Equatable {
  final String? id;
  final String? macAddress;
  final String? serialNumber;
  final String? model;
  final String? manufacturer;
  final String? hardwareRevision;
  final String? firmwareRevision;
  final int? batteryLevel;
  final String? name;
  final SensorStatus? status;
  final int? alarmCount;
  final DateTime? firstSeen;
  final DateTime? lastUpdated;
  final String? notes;
  final String? certificateUrl;
  final SensorTaskData? mostRecent;
  final SensorTaskData? requested;
  final String? certificateType;
  final UnverifiedData? unverifiedData;

  const Sensor({
    this.id,
    this.macAddress,
    this.serialNumber,
    this.model,
    this.manufacturer,
    this.hardwareRevision,
    this.firmwareRevision,
    this.batteryLevel,
    this.name,
    this.status,
    this.alarmCount,
    this.firstSeen,
    this.lastUpdated,
    this.notes,
    this.certificateUrl,
    this.mostRecent,
    this.requested,
    this.certificateType,
    this.unverifiedData,
  });

  Sensor copyWith({
    String? id,
    String? macAddress,
    String? serialNumber,
    String? model,
    String? manufacturer,
    String? hardwareRevision,
    String? firmwareRevision,
    int? batteryLevel,
    String? name,
    SensorStatus? status,
    int? alarmCount,
    DateTime? firstSeen,
    DateTime? lastUpdated,
    String? notes,
    String? certificateUrl,
    SensorTaskData? mostRecent,
    SensorTaskData? requested,
    String? certificateType,
    UnverifiedData? unverifiedData,
  }) {
    return Sensor(
      id: id ?? this.id,
      macAddress: macAddress ?? this.macAddress,
      serialNumber: serialNumber ?? this.serialNumber,
      model: model ?? this.model,
      manufacturer: manufacturer ?? this.manufacturer,
      hardwareRevision: hardwareRevision ?? this.hardwareRevision,
      firmwareRevision: firmwareRevision ?? this.firmwareRevision,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      name: name ?? this.name,
      status: status ?? this.status,
      alarmCount: alarmCount ?? this.alarmCount,
      firstSeen: firstSeen ?? this.firstSeen,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      notes: notes ?? this.notes,
      certificateUrl: certificateUrl ?? this.certificateUrl,
      mostRecent: mostRecent ?? this.mostRecent,
      requested: requested ?? this.requested,
      certificateType: certificateType ?? this.certificateType,
      unverifiedData: unverifiedData ?? this.unverifiedData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'macAddress': macAddress,
      'serialNumber': serialNumber,
      'model': model,
      'manufacturer': manufacturer,
      'hardwareRevision': hardwareRevision,
      'firmwareRevision': firmwareRevision,
      'batteryLevel': batteryLevel,
      'name': name,
      'status': status?.asString(),
      'alarmCount': alarmCount,
      'firstSeen': firstSeen?.millisecondsSinceEpoch,
      'lastUpdated': lastUpdated?.millisecondsSinceEpoch,
      'notes': notes,
      'certificateUrl': certificateUrl,
      'mostRecent': mostRecent?.toMap(),
      'requested': requested?.toMap(),
      'certificateType': certificateType,
      'unverifiedData': unverifiedData?.toMap()
    };
  }

  factory Sensor.fromMap(Map<String, dynamic> map) {
    final SensorStatus? status = toSensorStatus(map['status'] as String);
    return Sensor(
      id: map['id'] != null ? map['id'] as String : null,
      macAddress: map['mac_address'] != null ? map['mac_address'] as String : null,
      serialNumber: map['serial_number'] != null ? map['serial_number'] as String : null,
      model: map['model'] != null ? map['model'] as String : null,
      manufacturer: map['manufacturer'] != null ? map['manufacturer'] as String : null,
      hardwareRevision: map['hardware_revision'] != null ? map['hardware_revision'] as String : null,
      firmwareRevision: map['firmware_revision'] != null ? map['firmware_revision'] as String : null,
      batteryLevel: map['battery_level'] != null ? map['battery_level'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      status: status,
      alarmCount: map['alarm_count'] != null ? map['alarm_count'] as int : null,
      firstSeen: map['first_seen'] != null ? DateTime.parse(map['first_seen'] as String) : null,
      lastUpdated: map['last_updated'] != null ? DateTime.parse(map['last_updated'] as String) : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      certificateUrl: map['certificate_url'] != null ? map['certificate_url'] as String : null,
      mostRecent:
          map['most_recent'] != null ? SensorTaskData.fromMap(map['most_recent'] as Map<String, dynamic>) : null,
      requested: map['requested'] != null ? SensorTaskData.fromMap(map['requested'] as Map<String, dynamic>) : null,
      certificateType: map['certificate_type'] != null ? map['certificate_type'] as String : null,
      unverifiedData:
          map['unverified'] != null ? UnverifiedData.fromMap(map['unverified'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Sensor.fromJson(String source) => Sensor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      macAddress,
      serialNumber,
      model,
      manufacturer,
      hardwareRevision,
      firmwareRevision,
      batteryLevel,
      name,
      status,
      alarmCount,
      firstSeen,
      lastUpdated,
      notes,
      certificateUrl,
      mostRecent,
      requested,
      certificateType,
      unverifiedData,
    ];
  }
}

class SensorTaskData {
  final String? taskId;
  final String? sensorTaskId;
  final SensorTaskStatus? sensorTaskStatus;
  final int? alarmCount;

  SensorTaskData({
    this.taskId,
    this.sensorTaskId,
    this.sensorTaskStatus,
    this.alarmCount,
  });

  SensorTaskData copyWith({
    String? taskId,
    String? sensorTaskId,
    SensorTaskStatus? sensorTaskStatus,
    int? alarmCount,
  }) {
    return SensorTaskData(
      taskId: taskId ?? this.taskId,
      sensorTaskId: sensorTaskId ?? this.sensorTaskId,
      sensorTaskStatus: sensorTaskStatus ?? this.sensorTaskStatus,
      alarmCount: alarmCount ?? this.alarmCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task_id': taskId,
      'sensor_task_id': sensorTaskId,
      'sensor_task_status': sensorTaskStatus?.asString(),
      'alarm_count': alarmCount,
    };
  }

  factory SensorTaskData.fromMap(Map<String, dynamic> map) {
    final SensorTaskStatus? status = toSensorTaskStatus(map['sensor_task_status'] as String);
    return SensorTaskData(
      taskId: map['task_id'] != null ? map['task_id'] as String : null,
      sensorTaskId: map['sensor_task_id'] != null ? map['sensor_task_id'] as String : null,
      sensorTaskStatus: map['sensor_task_status'] != null ? status : null,
      alarmCount: map['alarm_count'] != null ? map['alarm_count'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SensorTaskData.fromJson(String source) => SensorTaskData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SensorTaskData(taskId: $taskId, sensorTaskId: $sensorTaskId, sensorTaskStatus: $sensorTaskStatus, alarmCount: $alarmCount)';
  }

  @override
  bool operator ==(covariant SensorTaskData other) {
    if (identical(this, other)) return true;

    return other.taskId == taskId &&
        other.sensorTaskId == sensorTaskId &&
        other.sensorTaskStatus == sensorTaskStatus &&
        other.alarmCount == alarmCount;
  }

  @override
  int get hashCode {
    return taskId.hashCode ^ sensorTaskId.hashCode ^ sensorTaskStatus.hashCode ^ alarmCount.hashCode;
  }
}

class UnverifiedData {
  final DateTime? lastDateTime;
  final num? lastTemperature;
  final bool? lastAlarm;

  UnverifiedData({
    this.lastAlarm,
    this.lastDateTime,
    this.lastTemperature,
  });

  UnverifiedData copyWith({
    DateTime? lastDateTime,
    num? lastTemperature,
    bool? lastAlarm,
  }) {
    return UnverifiedData(
      lastDateTime: lastDateTime ?? this.lastDateTime,
      lastTemperature: lastTemperature ?? this.lastTemperature,
      lastAlarm: lastAlarm ?? this.lastAlarm,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'last_date_time': lastDateTime.toString(),
      'last_temperature': lastTemperature,
      'last_alarm': lastAlarm
    };
  }

  factory UnverifiedData.fromMap(Map<String, dynamic> map) {
    return UnverifiedData(
      lastDateTime: map['last_date_time'] != null ? DateTime.parse(map['last_date_time'] as String) : null,
      lastAlarm: map['last_alarm'] != null ? map['last_alarm'] as bool : null,
      lastTemperature: map['last_temperature'] != null ? map['last_temperature'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UnverifiedData.fromJson(String source) => UnverifiedData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SensorTaskData(lastDateTime: $lastDateTime, lastTemperature: $lastTemperature, lastAlarm: $lastAlarm)';
  }

  @override
  bool operator ==(covariant UnverifiedData other) {
    if (identical(this, other)) return true;

    return other.lastDateTime == lastDateTime &&
        other.lastAlarm == lastAlarm &&
        other.lastTemperature == lastTemperature;
  }

  @override
  int get hashCode {
    return lastAlarm.hashCode ^ lastDateTime.hashCode ^ lastTemperature.hashCode;
  }
}

enum SensorStatus {
  SENSOR_STATUS_ACTIVE,
  SENSOR_STATUS_ACTIVE_WITH_ALARM,
  SENSOR_STATUS_STOPPED,
  SENSOR_STATUS_UNSPECIFIED,
}

enum SensorTaskStatus {
  SENSOR_TASK_STATUS_START_PENDING,
  SENSOR_TASK_STATUS_ACTIVE,
  SENSOR_TASK_STATUS_ACTIVE_WITH_ALARM,
  SENSOR_TASK_STATUS_COMPLETED,
  SENSOR_TASK_STATUS_STOP_PENDING,
  SENSOR_TASK_STATUS_ACTIVE_WITH_TECH_ALARM,
  SENSOR_TASK_STATUS_PENDING,
  SENSOR_TASK_STATUS_UNSPECIFIED,
  SENSOR_TASK_STATUS_STOP_PENDING_COLD,
}

extension SensorStatusExt on SensorStatus {
  String asString() {
    switch (this) {
      case SensorStatus.SENSOR_STATUS_ACTIVE:
        return 'SENSOR_STATUS_ACTIVE';
      case SensorStatus.SENSOR_STATUS_ACTIVE_WITH_ALARM:
        return 'SENSOR_STATUS_ACTIVE_WITH_ALARM';
      case SensorStatus.SENSOR_STATUS_STOPPED:
        return 'SENSOR_STATUS_STOPPED';
      case SensorStatus.SENSOR_STATUS_UNSPECIFIED:
        return 'SENSOR_STATUS_UNSPECIFIED';
    }
  }

  String asLabel() {
    switch (this) {
      case SensorStatus.SENSOR_STATUS_ACTIVE:
        return Loco.current.taskDetailSensorActiveLongVariant;
      case SensorStatus.SENSOR_STATUS_ACTIVE_WITH_ALARM:
        return Loco.current.taskDetailSensorActiveWithAlarmLong;
      case SensorStatus.SENSOR_STATUS_STOPPED:
        return Loco.current.taskDetailStatusSensorsStoppedLong;
      case SensorStatus.SENSOR_STATUS_UNSPECIFIED:
        return Loco.current.alarmTypeUnspecified;
    }
  }
}

extension SensorTaskStatusExt on SensorTaskStatus {
  String asString() {
    switch (this) {
      case SensorTaskStatus.SENSOR_TASK_STATUS_START_PENDING:
        return 'SENSOR_TASK_STATUS_START_PENDING';
      case SensorTaskStatus.SENSOR_TASK_STATUS_ACTIVE:
        return 'SENSOR_TASK_STATUS_ACTIVE';
      case SensorTaskStatus.SENSOR_TASK_STATUS_ACTIVE_WITH_ALARM:
        return 'SENSOR_TASK_STATUS_ACTIVE_WITH_ALARM';
      case SensorTaskStatus.SENSOR_TASK_STATUS_COMPLETED:
        return 'SENSOR_TASK_STATUS_COMPLETED';
      case SensorTaskStatus.SENSOR_TASK_STATUS_STOP_PENDING:
        return 'SENSOR_TASK_STATUS_STOP_PENDING';
      case SensorTaskStatus.SENSOR_TASK_STATUS_ACTIVE_WITH_TECH_ALARM:
        return 'SENSOR_TASK_STATUS_ACTIVE_WITH_TECH_ALARM';
      case SensorTaskStatus.SENSOR_TASK_STATUS_PENDING:
        return 'SENSOR_TASK_STATUS_PENDING';
      case SensorTaskStatus.SENSOR_TASK_STATUS_UNSPECIFIED:
        return 'SENSOR_TASK_STATUS_UNSPECIFIED';
      case SensorTaskStatus.SENSOR_TASK_STATUS_STOP_PENDING_COLD:
        return 'SENSOR_TASK_STATUS_STOP_PENDING_COLD';
    }
  }

  Color statusColor() {
    switch (this) {
      case SensorTaskStatus.SENSOR_TASK_STATUS_START_PENDING:
      case SensorTaskStatus.SENSOR_TASK_STATUS_STOP_PENDING:
      case SensorTaskStatus.SENSOR_TASK_STATUS_PENDING:
      case SensorTaskStatus.SENSOR_TASK_STATUS_STOP_PENDING_COLD:
        return ZSColors.orange400;
      case SensorTaskStatus.SENSOR_TASK_STATUS_ACTIVE:
        return ZSColors.success;
      case SensorTaskStatus.SENSOR_TASK_STATUS_ACTIVE_WITH_ALARM:
      case SensorTaskStatus.SENSOR_TASK_STATUS_ACTIVE_WITH_TECH_ALARM:
        return ZSColors.error;
      case SensorTaskStatus.SENSOR_TASK_STATUS_COMPLETED:
      case SensorTaskStatus.SENSOR_TASK_STATUS_UNSPECIFIED:
        return ZSColors.secondaryDark;
    }
  }
}

SensorStatus? toSensorStatus(String status) {
  switch (status) {
    case 'SENSOR_STATUS_ACTIVE':
      return SensorStatus.SENSOR_STATUS_ACTIVE;
    case 'SENSOR_STATUS_ACTIVE_WITH_ALARM':
      return SensorStatus.SENSOR_STATUS_ACTIVE_WITH_ALARM;
    case 'SENSOR_STATUS_STOPPED':
      return SensorStatus.SENSOR_STATUS_STOPPED;
    case 'SENSOR_STATUS_UNSPECIFIED':
      return SensorStatus.SENSOR_STATUS_UNSPECIFIED;
    default:
      return null;
  }
}

SensorTaskStatus? toSensorTaskStatus(String status) {
  switch (status) {
    case 'SENSOR_TASK_STATUS_START_PENDING':
      return SensorTaskStatus.SENSOR_TASK_STATUS_START_PENDING;
    case 'SENSOR_TASK_STATUS_ACTIVE':
      return SensorTaskStatus.SENSOR_TASK_STATUS_ACTIVE;
    case 'SENSOR_TASK_STATUS_ACTIVE_WITH_ALARM':
      return SensorTaskStatus.SENSOR_TASK_STATUS_ACTIVE_WITH_ALARM;
    case 'SENSOR_TASK_STATUS_ACTIVE_WITH_TECH_ALARM':
      return SensorTaskStatus.SENSOR_TASK_STATUS_ACTIVE_WITH_TECH_ALARM;
    case 'SENSOR_TASK_STATUS_COMPLETED':
      return SensorTaskStatus.SENSOR_TASK_STATUS_COMPLETED;
    case 'SENSOR_TASK_STATUS_STOP_PENDING':
      return SensorTaskStatus.SENSOR_TASK_STATUS_STOP_PENDING;
    case 'SENSOR_TASK_STATUS_PENDING':
      return SensorTaskStatus.SENSOR_TASK_STATUS_PENDING;
    case 'SENSOR_TASK_STATUS_UNSPECIFIED':
      return SensorTaskStatus.SENSOR_TASK_STATUS_UNSPECIFIED;
    case 'SENSOR_TASK_STATUS_STOP_PENDING_COLD':
      return SensorTaskStatus.SENSOR_TASK_STATUS_STOP_PENDING_COLD;
    default:
      return null;
  }
}

class ListSensorsResponse {
  final List<Sensor> sensors;
  final PageResponse pageResponse;

  ListSensorsResponse(this.sensors, this.pageResponse);
}
