import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/sensor.dart';

String getSensorMacAddress(String macAddress) {
  if (macAddress.contains(":")) {
    return macAddress;
  }
  return macAddress.replaceAllMapped(RegExp("(.{2})"), (match) => "${match.group(0)}:").substring(0, 17);
}

final _sensorTaskStatusLabels = {
  SensorTaskStatus.SENSOR_TASK_STATUS_ACTIVE: SensorLabel._(
    short: Loco.current.taskDetailSensorActiveShort,
    long: Loco.current.taskDetailSensorActiveLong,
    longVariant: Loco.current.taskDetailSensorActiveLongVariant,
  ),
  SensorTaskStatus.SENSOR_TASK_STATUS_ACTIVE_WITH_ALARM: SensorLabel._(
    short: Loco.current.taskDetailSensorActiveWithAlarmShort,
    long: Loco.current.taskDetailSensorActiveWithAlarmLong,
    longVariant: Loco.current.taskDetailSensorActiveWithAlarmLongVariant,
  ),
  SensorTaskStatus.SENSOR_TASK_STATUS_ACTIVE_WITH_TECH_ALARM: SensorLabel._(
    short: Loco.current.taskDetailSensorActiveWithTechAlarmShort,
    long: Loco.current.taskDetailSensorActiveWithTechAlarmLong,
    longVariant: Loco.current.taskDetailSensorActiveWithTechAlarmLongVariant,
  ),
  SensorTaskStatus.SENSOR_TASK_STATUS_COMPLETED: SensorLabel._(
    short: Loco.current.taskDetailStatusSensorsCompletedShort,
    long: Loco.current.taskDetailStatusSensorsCompletedLong,
    longVariant: Loco.current.taskDetailStatusSensorsCompletedLong,
  ),
  SensorTaskStatus.SENSOR_TASK_STATUS_PENDING: SensorLabel._(
    short: Loco.current.taskDetailSensorStoppedPendingShort,
    long: Loco.current.taskDetailSensorStoppedPendingLong,
    longVariant: Loco.current.taskDetailSensorStoppedPendingLongVariant,
  ),
  SensorTaskStatus.SENSOR_TASK_STATUS_START_PENDING: SensorLabel._(
    short: Loco.current.taskDetailStatusStartPendingShort,
    long: Loco.current.taskDetailStatusStartPendingLong,
    longVariant: Loco.current.taskDetailStatusStartPendingLongVariant,
  ),
  SensorTaskStatus.SENSOR_TASK_STATUS_STOP_PENDING: SensorLabel._(
    short: Loco.current.taskDetailSensorStoppedPendingShort,
    long: Loco.current.taskDetailSensorStoppedPendingLong,
    longVariant: Loco.current.taskDetailSensorStoppedPendingLongVariant,
  ),
  SensorTaskStatus.SENSOR_TASK_STATUS_UNSPECIFIED: SensorLabel._(
    short: Loco.current.taskDetailSensorUnspecifiedShort,
    long: Loco.current.taskDetailSensorUnspecifiedLong,
    longVariant: Loco.current.taskDetailSensorUnspecifiedLongVariant,
  ),
  SensorTaskStatus.SENSOR_TASK_STATUS_STOP_PENDING_COLD: SensorLabel._(
    short: Loco.current.taskDetailSensorStoppedPendingColdShort,
    long: Loco.current.taskDetailSensorStoppedPendingColdLong,
    longVariant: Loco.current.taskDetailSensorStoppedPendingLongColdVariant,
  ),
};

final Map<SensorTaskStatus, ZSSensorColor> _sensorTaskColors = {
  SensorTaskStatus.SENSOR_TASK_STATUS_ACTIVE: const ZSSensorColor._(
    primary: ZSColors.success,
    primaryVariant: ZSColors.successG400,
    backgroundColor: ZSColors.successLight,
  ),
  SensorTaskStatus.SENSOR_TASK_STATUS_ACTIVE_WITH_ALARM: const ZSSensorColor._(
    primary: ZSColors.errorLight,
    primaryVariant: ZSColors.errorLightBG,
    backgroundColor: ZSColors.errorLightBG,
  ),
  SensorTaskStatus.SENSOR_TASK_STATUS_COMPLETED: const ZSSensorColor._(
    primary: ZSColors.neutralLight300,
    primaryVariant: ZSColors.neutralLight300,
    backgroundColor: ZSColors.neutralLight20,
  ),
  SensorTaskStatus.SENSOR_TASK_STATUS_PENDING: const ZSSensorColor._(
    primary: ZSColors.info,
    primaryVariant: ZSColors.infoP50,
    backgroundColor: ZSColors.infoP50,
  ),
  SensorTaskStatus.SENSOR_TASK_STATUS_START_PENDING: const ZSSensorColor._(
    primary: ZSColors.teal,
    primaryVariant: ZSColors.tealLight,
    backgroundColor: ZSColors.tealLight,
  ),
  SensorTaskStatus.SENSOR_TASK_STATUS_STOP_PENDING: const ZSSensorColor._(
    primary: ZSColors.warning,
    primaryVariant: ZSColors.warningLight,
    backgroundColor: ZSColors.warningLight,
  ),
  SensorTaskStatus.SENSOR_TASK_STATUS_UNSPECIFIED: const ZSSensorColor._(
    primary: ZSColors.neutralLight300,
    primaryVariant: ZSColors.neutralLight300,
    backgroundColor: ZSColors.neutralLight20,
  ),
  SensorTaskStatus.SENSOR_TASK_STATUS_STOP_PENDING_COLD: const ZSSensorColor._(
    primary: ZSColors.warning,
    primaryVariant: ZSColors.warningLight,
    backgroundColor: ZSColors.warningLight,
  ),
};

class SensorLabel {
  final String short;
  final String long;
  final String longVariant;
  const SensorLabel._({required this.short, required this.long, required this.longVariant});

  factory SensorLabel.fromSensorTask(SensorTaskStatus status) {
    final badge = _sensorTaskStatusLabels[status];
    if (badge == null) return _kDefaultStatusToSensorLabel;
    return badge;
  }
}

const _kDefaultStatusToSensorLabel = SensorLabel._(short: 'unknown', long: 'Unknown', longVariant: 'Unknown');

class ZSSensorColor {
  final Color primary;
  final Color primaryVariant;
  final Color backgroundColor;

  const ZSSensorColor._({
    required this.primary,
    required this.primaryVariant,
    required this.backgroundColor,
  });

  factory ZSSensorColor.fromSensorTask(SensorTaskStatus status) {
    return _sensorTaskColors[status] ?? kDefaultSensorColor;
  }
}

extension SensorStatusColor on SensorTaskStatus {
  ZSSensorColor get color => ZSSensorColor.fromSensorTask(this);
}

const kDefaultSensorColor = ZSSensorColor._(
  primary: ZSColors.primaryDark,
  primaryVariant: ZSColors.primaryB300,
  backgroundColor: ZSColors.primaryB300,
);
