import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/models/page_response.dart';
import 'package:zsdemo_app/models/wrapped.dart';

class Task extends Equatable {
  final String? id;
  final int? sensorCount;
  final TaskStatus? status;
  final SensorTaskStatusOverview? sensorTaskStatusOverview;
  final DateTime? started;
  final DateTime? ended;
  final TaskDetails? taskDetails;
  final int? alarmCount;

  const Task({
    this.id,
    this.sensorCount,
    this.status,
    this.sensorTaskStatusOverview,
    this.started,
    this.ended,
    this.taskDetails,
    this.alarmCount,
  });

  Task copyWith({
    String? id,
    int? sensorCount,
    TaskStatus? status,
    SensorTaskStatusOverview? sensorTaskStatusOverview,
    DateTime? started,
    DateTime? ended,
    TaskDetails? taskDetails,
    int? alarmCount,
  }) {
    return Task(
      id: id ?? this.id,
      sensorCount: sensorCount ?? this.sensorCount,
      status: status ?? this.status,
      sensorTaskStatusOverview: sensorTaskStatusOverview ?? this.sensorTaskStatusOverview,
      started: started ?? this.started,
      ended: ended ?? this.ended,
      taskDetails: taskDetails ?? this.taskDetails,
      alarmCount: alarmCount ?? this.alarmCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sensorCount': sensorCount,
      'status': status?.asString(),
      'sensor_task_status_overview': sensorTaskStatusOverview?.toMap(),
      'started': started?.millisecondsSinceEpoch,
      'ended': ended?.millisecondsSinceEpoch,
      'taskDetails': taskDetails?.toMap(),
      'alarmCount': alarmCount,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] != null ? map['id'] as String : null,
      sensorCount: map['sensor_count'] != null ? map['sensor_count'] as int : null,
      status: map['status'] != null ? toTaskStatus(map['status'] as String) : null,
      sensorTaskStatusOverview: map['sensor_task_status_overview'] != null
          ? SensorTaskStatusOverview.fromMap(map['sensor_task_status_overview'] as Map<String, dynamic>)
          : null,
      started: map['started'] != null ? DateTime.parse(map['started'] as String) : null,
      ended: map['ended'] != null ? DateTime.parse(map['ended'] as String) : null,
      taskDetails: map['taskDetails'] != null ? TaskDetails.fromMap(map['taskDetails'] as Map<String, dynamic>) : null,
      alarmCount: map['alarm_count'] != null ? map['alarm_count'] as int : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      sensorCount,
      status,
      sensorTaskStatusOverview,
      started,
      ended,
      taskDetails,
      alarmCount,
    ];
  }
}

extension TaskExt on Task {
  bool isTaskStopped() {
    return status == TaskStatus.TASK_STATUS_STOP_PENDING || status == TaskStatus.TASK_STATUS_SENSOR_COMPLETED;
  }
}

enum TaskStatus {
  TASK_STATUS_ACTIVE,
  TASK_STATUS_ACTIVE_WITH_ALARM,
  TASK_STATUS_SENSOR_REQUIRED,
  TASK_STATUS_SENSOR_COMPLETED,
  TASK_STATUS_START_PENDING,
  TASK_STATUS_STOP_PENDING,
  TASK_STATUS_ACTIVE_WITH_TECH_ALARM,
}

extension TaskStatusExt on TaskStatus {
  String asString() {
    switch (this) {
      case TaskStatus.TASK_STATUS_ACTIVE:
        return 'TASK_STATUS_ACTIVE';
      case TaskStatus.TASK_STATUS_ACTIVE_WITH_ALARM:
        return 'TASK_STATUS_ACTIVE_WITH_ALARM';
      case TaskStatus.TASK_STATUS_SENSOR_REQUIRED:
        return 'TASK_STATUS_SENSOR_REQUIRED';
      case TaskStatus.TASK_STATUS_SENSOR_COMPLETED:
        return 'TASK_STATUS_SENSOR_COMPLETED';
      case TaskStatus.TASK_STATUS_START_PENDING:
        return 'TASK_STATUS_START_PENDING';
      case TaskStatus.TASK_STATUS_STOP_PENDING:
        return 'TASK_STATUS_STOP_PENDING';
      case TaskStatus.TASK_STATUS_ACTIVE_WITH_TECH_ALARM:
        return 'TASK_STATUS_ACTIVE_WITH_TECH_ALARM';
    }
  }

  Color statusColor() {
    switch (this) {
      case TaskStatus.TASK_STATUS_ACTIVE:
        return ZSColors.success;
      case TaskStatus.TASK_STATUS_ACTIVE_WITH_ALARM:
      case TaskStatus.TASK_STATUS_ACTIVE_WITH_TECH_ALARM:
        return ZSColors.error;
      case TaskStatus.TASK_STATUS_SENSOR_REQUIRED:
      case TaskStatus.TASK_STATUS_SENSOR_COMPLETED:
        return ZSColors.secondaryDark;
      case TaskStatus.TASK_STATUS_START_PENDING:
      case TaskStatus.TASK_STATUS_STOP_PENDING:
        return ZSColors.orange400;
    }
  }
}

TaskStatus? toTaskStatus(String status) {
  switch (status) {
    case 'TASK_STATUS_ACTIVE':
      return TaskStatus.TASK_STATUS_ACTIVE;
    case 'TASK_STATUS_ACTIVE_WITH_ALARM':
      return TaskStatus.TASK_STATUS_ACTIVE_WITH_ALARM;
    case 'TASK_STATUS_SENSOR_REQUIRED':
      return TaskStatus.TASK_STATUS_SENSOR_REQUIRED;
    case 'TASK_STATUS_SENSOR_COMPLETED':
      return TaskStatus.TASK_STATUS_SENSOR_COMPLETED;
    case 'TASK_STATUS_START_PENDING':
      return TaskStatus.TASK_STATUS_START_PENDING;
    case 'TASK_STATUS_STOP_PENDING':
      return TaskStatus.TASK_STATUS_STOP_PENDING;
    default:
      return null;
  }
}

class SensorTaskStatusOverview {
  final int active;
  final int activeWithAlarm;
  final int completed;
  final int startPending;
  final int stopPending;

  SensorTaskStatusOverview({
    required this.active,
    required this.activeWithAlarm,
    required this.completed,
    required this.startPending,
    required this.stopPending,
  });

  SensorTaskStatusOverview copyWith({
    int? active,
    int? activeWithAlarm,
    int? completed,
    int? startPending,
    int? stopPending,
  }) {
    return SensorTaskStatusOverview(
      active: active ?? this.active,
      activeWithAlarm: activeWithAlarm ?? this.activeWithAlarm,
      completed: completed ?? this.completed,
      startPending: startPending ?? this.startPending,
      stopPending: stopPending ?? this.stopPending,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'active': active,
      'active_with_alarm': activeWithAlarm,
      'completed': completed,
      'start_pending': startPending,
      'stop_pending': stopPending,
    };
  }

  factory SensorTaskStatusOverview.fromMap(Map<String, dynamic> map) {
    return SensorTaskStatusOverview(
      active: map['active'] as int,
      activeWithAlarm: map['active_with_alarm'] as int,
      completed: map['completed'] as int,
      startPending: map['start_pending'] as int,
      stopPending: map['stop_pending'] as int,
    );
  }

  @override
  String toString() {
    return 'SensorTaskStatusOverview(active: $active, activeWithAlarm: $activeWithAlarm, completed: $completed, startPending: $startPending, stopPending: $stopPending)';
  }

  @override
  bool operator ==(covariant SensorTaskStatusOverview other) {
    if (identical(this, other)) return true;

    return other.active == active &&
        other.activeWithAlarm == activeWithAlarm &&
        other.completed == completed &&
        other.startPending == startPending &&
        other.stopPending == stopPending;
  }

  @override
  int get hashCode {
    return active.hashCode ^
        activeWithAlarm.hashCode ^
        completed.hashCode ^
        startPending.hashCode ^
        stopPending.hashCode;
  }
}

class TaskDetails extends Equatable {
  final String? name;
  final DateTime? created;
  final DateTime? updated;
  final int? intervalMinutes;
  final int? intervalSeconds;
  final bool? loopReads;
  final Map? startImmediately;
  final StartDelayed? startDelayed;
  final SensorType? sensorType;
  final num? alarmLowTemp;
  final num? alarmHighTemp;
  final String? notes;
  final int? lowDurationMinutes;
  final int? lowDurationSeconds;
  final int? highDurationMinutes;
  final int? highDurationSeconds;
  final int? requiredSensors;

  const TaskDetails({
    this.name,
    this.created,
    this.updated,
    this.intervalMinutes,
    this.intervalSeconds,
    this.loopReads,
    this.startImmediately,
    this.startDelayed,
    this.sensorType,
    this.alarmLowTemp,
    this.alarmHighTemp,
    this.notes,
    this.lowDurationMinutes,
    this.lowDurationSeconds,
    this.highDurationMinutes,
    this.highDurationSeconds,
    this.requiredSensors,
  });

  TaskDetails copyWith({
    Wrapped<String?>? name,
    Wrapped<DateTime?>? created,
    Wrapped<DateTime?>? updated,
    Wrapped<int?>? intervalMinutes,
    Wrapped<int?>? intervalSeconds,
    Wrapped<bool?>? loopReads,
    Wrapped<Map?>? startImmediately,
    Wrapped<StartDelayed?>? startDelayed,
    Wrapped<SensorType?>? sensorType,
    Wrapped<num?>? alarmLowTemp,
    Wrapped<num?>? alarmHighTemp,
    Wrapped<String?>? notes,
    Wrapped<int?>? lowDurationMinutes,
    Wrapped<int?>? lowDurationSeconds,
    Wrapped<int?>? highDurationMinutes,
    Wrapped<int?>? highDurationSeconds,
    Wrapped<int?>? requiredSensors,
  }) {
    return TaskDetails(
      name: name != null ? name.value : this.name,
      created: created != null ? created.value : this.created,
      updated: updated != null ? updated.value : this.updated,
      intervalMinutes: intervalMinutes != null ? intervalMinutes.value : this.intervalMinutes,
      intervalSeconds: intervalSeconds != null ? intervalSeconds.value : this.intervalSeconds,
      loopReads: loopReads != null ? loopReads.value : this.loopReads,
      startImmediately: startImmediately != null ? startImmediately.value : this.startImmediately,
      startDelayed: startDelayed != null ? startDelayed.value : this.startDelayed,
      sensorType: sensorType != null ? sensorType.value : this.sensorType,
      alarmLowTemp: alarmLowTemp != null ? alarmLowTemp.value : this.alarmLowTemp,
      alarmHighTemp: alarmHighTemp != null ? alarmHighTemp.value : this.alarmHighTemp,
      lowDurationMinutes: lowDurationMinutes != null ? lowDurationMinutes.value : this.lowDurationMinutes,
      lowDurationSeconds: lowDurationSeconds != null ? lowDurationSeconds.value : this.lowDurationSeconds,
      highDurationMinutes: highDurationMinutes != null ? highDurationMinutes.value : this.highDurationMinutes,
      highDurationSeconds: highDurationSeconds != null ? highDurationSeconds.value : this.highDurationSeconds,
      requiredSensors: requiredSensors != null ? requiredSensors.value : this.requiredSensors,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'created': created?.toUtc().toIso8601String(),
      'updated': updated?.toUtc().toIso8601String(),
      'interval_minutes': intervalMinutes,
      'interval_seconds': intervalSeconds,
      'loop_reads': loopReads,
      if (startDelayed == null) 'start_immediately': startImmediately,
      if (startDelayed != null) 'start_delayed': startDelayed?.toMap(),
      'sensor_type': sensorType?.asString(),
      'alarm_low_temp': alarmLowTemp,
      'alarm_high_temp': alarmHighTemp,
      'low_duration_minutes': lowDurationMinutes,
      'low_duration_seconds': lowDurationSeconds,
      'high_duration_minutes': highDurationMinutes,
      'high_duration_seconds': highDurationSeconds,
      'required_sensors': requiredSensors,
    };
  }

  factory TaskDetails.fromMap(Map<String, dynamic> map) {
    return TaskDetails(
      name: map['name'] != null ? map['name'] as String : null,
      created: map['created'] != null ? DateTime.parse(map['created'] as String) : null,
      updated: map['updated'] != null ? DateTime.parse(map['updated'] as String) : null,
      intervalMinutes: map['interval_minutes'] != null ? map['interval_minutes'] as int : null,
      intervalSeconds: map['interval_seconds'] != null ? map['interval_seconds'] as int : null,
      loopReads: map['loop_reads'] != null ? map['loop_reads'] as bool : null,
      startImmediately: map['start_immediately'] != null ? (map['start_immediately'] as Map<String, dynamic>) : null,
      startDelayed:
          map['start_delayed'] != null ? StartDelayed.fromMap(map['start_delayed'] as Map<String, dynamic>) : null,
      sensorType: map['sensor_type'] != null ? toSensorType(map['sensor_type'] as String) : null,
      alarmLowTemp: map['alarm_low_temp'] != null ? map['alarm_low_temp'] as num : null,
      alarmHighTemp: map['alarm_high_temp'] != null ? map['alarm_high_temp'] as num : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      lowDurationMinutes: map['low_duration_minutes'] != null ? map['low_duration_minutes'] as int : null,
      lowDurationSeconds: map['low_duration_seconds'] != null ? map['low_duration_seconds'] as int : null,
      highDurationMinutes: map['high_duration_minutes'] != null ? map['high_duration_minutes'] as int : null,
      highDurationSeconds: map['high_duration_seconds'] != null ? map['high_duration_seconds'] as int : null,
      requiredSensors: map['required_sensors'] != null ? int.parse(map['required_sensors'] as String) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskDetails.fromJson(String source) => TaskDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      name,
      created,
      updated,
      intervalMinutes,
      intervalSeconds,
      loopReads,
      startImmediately,
      startDelayed,
      sensorType,
      alarmLowTemp,
      alarmHighTemp,
      notes,
      lowDurationMinutes,
      lowDurationSeconds,
      highDurationMinutes,
      highDurationSeconds,
      requiredSensors,
    ];
  }
}

class StartDelayed {
  final bool? onButtonPress;
  final num? delayedTempBelow;
  final num? delayedTempAbove;
  final int? delayedMinutes;
  final DateTime? delayedUntil;

  StartDelayed({
    this.onButtonPress,
    this.delayedTempBelow,
    this.delayedTempAbove,
    this.delayedMinutes,
    this.delayedUntil,
  });

  StartDelayed copyWith({
    bool? onButtonPress,
    num? delayedTempBelow,
    num? delayedTempAbove,
    int? delayedMinutes,
    DateTime? delayedUntil,
  }) {
    return StartDelayed(
      onButtonPress: onButtonPress ?? this.onButtonPress,
      delayedTempBelow: delayedTempBelow ?? this.delayedTempBelow,
      delayedTempAbove: delayedTempAbove ?? this.delayedTempAbove,
      delayedMinutes: delayedMinutes ?? this.delayedMinutes,
      delayedUntil: delayedUntil ?? this.delayedUntil,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'on_button_press': onButtonPress,
      'delayed_temp_below': delayedTempBelow,
      'delayed_temp_above': delayedTempAbove,
      'delayed_minutes': delayedMinutes,
      'delayed_until': delayedUntil?.toUtc().toIso8601String(),
    };
  }

  factory StartDelayed.fromMap(Map<String, dynamic> map) {
    return StartDelayed(
      onButtonPress: map['on_button_press'] != null ? map['on_button_press'] as bool? : null,
      delayedTempBelow: map['delayed_temp_below'] != null ? map['delayed_temp_below'] as num? : null,
      delayedTempAbove: map['delayed_temp_above'] != null ? map['delayed_temp_above'] as num? : null,
      delayedMinutes: map['delayed_minutes'] != null ? map['delayed_minutes'] as int? : null,
      delayedUntil: map['delayed_until'] != null
          ? map['delayed_until'] is String
              ? DateTime.parse(map['delayed_until'] as String)
              : null
          : null,
    );
  }

  @override
  String toString() {
    return 'StartDelayed(onButtonPress: $onButtonPress, delayedTempBelow: $delayedTempBelow, delayedTempAbove: $delayedTempAbove, delayedMinutes: $delayedMinutes, delayedUntil: $delayedUntil)';
  }

  @override
  bool operator ==(covariant StartDelayed other) {
    if (identical(this, other)) return true;

    return other.onButtonPress == onButtonPress &&
        other.delayedTempBelow == delayedTempBelow &&
        other.delayedTempAbove == delayedTempAbove &&
        other.delayedMinutes == delayedMinutes &&
        other.delayedUntil == delayedUntil;
  }

  @override
  int get hashCode {
    return onButtonPress.hashCode ^
        delayedTempBelow.hashCode ^
        delayedTempAbove.hashCode ^
        delayedMinutes.hashCode ^
        delayedUntil.hashCode;
  }
}

enum SensorType {
  SENSOR_TYPE_UNSPECIFIED,
  SENSOR_TYPE_TEMPERATURE,
  SENSOR_TYPE_HUMIDITY,
  SENSOR_TYPE_PRESSURE,
  SENSOR_TYPE_LIGHT,
  SENSOR_TYPE_INERTIAL,
}

extension SensorTypeExt on SensorType {
  String asString() {
    switch (this) {
      case SensorType.SENSOR_TYPE_UNSPECIFIED:
        return 'SENSOR_TYPE_UNSPECIFIED';
      case SensorType.SENSOR_TYPE_TEMPERATURE:
        return 'SENSOR_TYPE_TEMPERATURE';
      case SensorType.SENSOR_TYPE_HUMIDITY:
        return 'SENSOR_TYPE_HUMIDITY';
      case SensorType.SENSOR_TYPE_PRESSURE:
        return 'SENSOR_TYPE_PRESSURE';
      case SensorType.SENSOR_TYPE_LIGHT:
        return 'SENSOR_TYPE_LIGHT';
      case SensorType.SENSOR_TYPE_INERTIAL:
        return 'SENSOR_TYPE_INERTIAL';
    }
  }
}

SensorType? toSensorType(String status) {
  switch (status) {
    case 'SENSOR_TYPE_UNSPECIFIED':
      return SensorType.SENSOR_TYPE_UNSPECIFIED;
    case 'SENSOR_TYPE_TEMPERATURE':
      return SensorType.SENSOR_TYPE_TEMPERATURE;
    case 'SENSOR_TYPE_HUMIDITY':
      return SensorType.SENSOR_TYPE_HUMIDITY;
    case 'SENSOR_TYPE_PRESSURE':
      return SensorType.SENSOR_TYPE_PRESSURE;
    case 'SENSOR_TYPE_LIGHT':
      return SensorType.SENSOR_TYPE_LIGHT;
    case 'SENSOR_TYPE_INERTIAL':
      return SensorType.SENSOR_TYPE_INERTIAL;
    default:
      return null;
  }
}

class ListTasksResponse {
  final List<Task> tasks;
  final PageResponse pageResponse;

  ListTasksResponse(this.tasks, this.pageResponse);
}
