import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/page_response.dart';

enum AlarmType {
  ALARM_TYPE_UNSPECIFIED,
  ALARM_TYPE_LOW_LIMIT_ALARM,
  ALARM_TYPE_HIGH_LIMIT_ALARM,
  ALARM_TYPE_LOW_LIMIT_ALARM_CLEAR,
  ALARM_TYPE_HIGH_LIMIT_ALARM_CLEAR,
  ALARM_TYPE_LOW_BATTERY_ALARM,
  ALARM_TYPE_BATTERY_SAVER_PLUS_SET,
  ALARM_TYPE_BATTERY_SAVER_PLUS_CLEAR,
  ALARM_TYPE_TOO_COLD,
}

extension AlarmTypeExt on AlarmType {
  String asString() {
    switch (this) {
      case AlarmType.ALARM_TYPE_BATTERY_SAVER_PLUS_CLEAR:
        return 'ALARM_TYPE_BATTERY_SAVER_PLUS_CLEAR';
      case AlarmType.ALARM_TYPE_BATTERY_SAVER_PLUS_SET:
        return 'ALARM_TYPE_BATTERY_SAVER_PLUS_SET';
      case AlarmType.ALARM_TYPE_HIGH_LIMIT_ALARM:
        return 'ALARM_TYPE_HIGH_LIMIT_ALARM';
      case AlarmType.ALARM_TYPE_HIGH_LIMIT_ALARM_CLEAR:
        return 'ALARM_TYPE_HIGH_LIMIT_ALARM_CLEAR';
      case AlarmType.ALARM_TYPE_LOW_LIMIT_ALARM:
        return 'ALARM_TYPE_LOW_LIMIT_ALARM';
      case AlarmType.ALARM_TYPE_LOW_LIMIT_ALARM_CLEAR:
        return 'ALARM_TYPE_LOW_LIMIT_ALARM_CLEAR';
      case AlarmType.ALARM_TYPE_LOW_BATTERY_ALARM:
        return 'ALARM_TYPE_LOW_BATTERY_ALARM';
      case AlarmType.ALARM_TYPE_UNSPECIFIED:
        return 'ALARM_TYPE_UNSPECIFIED';
      case AlarmType.ALARM_TYPE_TOO_COLD:
        return 'ALARM_TYPE_TOO_COLD';
      default:
        return '';
    }
  }

  String toStatus() {
    switch (this) {
      case AlarmType.ALARM_TYPE_BATTERY_SAVER_PLUS_CLEAR:
        return Loco.current.alarmTypeBatterySaverPlusClear;
      case AlarmType.ALARM_TYPE_BATTERY_SAVER_PLUS_SET:
        return Loco.current.alarmTypeBatterySaverPlusSet;
      case AlarmType.ALARM_TYPE_HIGH_LIMIT_ALARM:
        return Loco.current.alarmTypeHighLimitAlarm;
      case AlarmType.ALARM_TYPE_HIGH_LIMIT_ALARM_CLEAR:
        return Loco.current.alarmTypeHighLimitAlarmClear;
      case AlarmType.ALARM_TYPE_LOW_LIMIT_ALARM:
        return Loco.current.alarmTypeLowLimitAlarm;
      case AlarmType.ALARM_TYPE_LOW_LIMIT_ALARM_CLEAR:
        return Loco.current.alarmTypeLowLimitAlarmClear;
      case AlarmType.ALARM_TYPE_LOW_BATTERY_ALARM:
        return Loco.current.alarmTypeLowBattery;
      case AlarmType.ALARM_TYPE_UNSPECIFIED:
        return Loco.current.alarmTypeUnspecified;
      case AlarmType.ALARM_TYPE_TOO_COLD:
        return Loco.current.alarmTypeTooCold;
      default:
        return '';
    }
  }
}

AlarmType toAlarmType(String alarmType) {
  switch (alarmType) {
    case 'ALARM_TYPE_BATTERY_SAVER_PLUS_CLEAR':
      return AlarmType.ALARM_TYPE_BATTERY_SAVER_PLUS_CLEAR;
    case 'ALARM_TYPE_BATTERY_SAVER_PLUS_SET':
      return AlarmType.ALARM_TYPE_BATTERY_SAVER_PLUS_SET;
    case 'ALARM_TYPE_HIGH_LIMIT_ALARM':
      return AlarmType.ALARM_TYPE_HIGH_LIMIT_ALARM;
    case 'ALARM_TYPE_HIGH_LIMIT_ALARM_CLEAR':
      return AlarmType.ALARM_TYPE_HIGH_LIMIT_ALARM_CLEAR;
    case 'ALARM_TYPE_LOW_LIMIT_ALARM':
      return AlarmType.ALARM_TYPE_LOW_LIMIT_ALARM;
    case 'ALARM_TYPE_LOW_LIMIT_ALARM_CLEAR':
      return AlarmType.ALARM_TYPE_LOW_LIMIT_ALARM_CLEAR;
    case 'ALARM_TYPE_LOW_BATTERY_ALARM':
      return AlarmType.ALARM_TYPE_LOW_BATTERY_ALARM;
    case 'ALARM_TYPE_TOO_COLD':
      return AlarmType.ALARM_TYPE_TOO_COLD;
    case 'ALARM_TYPE_UNSPECIFIED':
    default:
      return AlarmType.ALARM_TYPE_UNSPECIFIED;
  }
}

class SensorAlarm extends Equatable {
  final String? sensorId;
  final AlarmType? alarmType;
  final DateTime? occurred;
  final num? temperature;
  final String? sensorName;

  const SensorAlarm({
    this.sensorId,
    this.alarmType,
    this.occurred,
    this.temperature,
    this.sensorName,
  });

  SensorAlarm copyWith({
    String? sensorId,
    AlarmType? alarmType,
    DateTime? occurred,
    num? temperature,
    String? sensorName,
  }) {
    return SensorAlarm(
      sensorId: sensorId ?? this.sensorId,
      alarmType: alarmType ?? this.alarmType,
      occurred: occurred ?? this.occurred,
      temperature: temperature ?? this.temperature,
      sensorName: sensorName ?? this.sensorName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sensor_id': sensorId,
      'alarm_type': alarmType?.asString(),
      'occurred': occurred?.millisecondsSinceEpoch,
      'temperature': temperature,
      'sensor_name': sensorName,
    };
  }

  factory SensorAlarm.fromMap(Map<String, dynamic> map) {
    return SensorAlarm(
      sensorId: map['sensor_id'] != null ? map['sensor_id'] as String : null,
      alarmType: map['alarm_type'] != null ? toAlarmType(map['alarm_type'] as String) : null,
      occurred: map['occurred'] != null ? DateTime.parse(map['occurred'] as String) : null,
      temperature: map['temperature'] != null ? map['temperature'] as num : null,
      sensorName: map['sensor_name'] != null ? map['sensor_name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SensorAlarm.fromJson(String source) => SensorAlarm.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      sensorId,
      alarmType,
      occurred,
      temperature,
      sensorName,
    ];
  }
}

class ListAlarmsResponse {
  final List<SensorAlarm> sensorAlarms;
  final PageResponse pageResponse;

  ListAlarmsResponse(this.sensorAlarms, this.pageResponse);
}
