import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/utils/date.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/task.dart';

final _taskStatusLabels = {
  TaskStatus.TASK_STATUS_ACTIVE: TaskLabel._(
    short: Loco.current.taskDetailStatusActiveShort,
    long: Loco.current.taskDetailStatusActiveLong,
    longVariant: Loco.current.taskDetailStatusActiveLongVariant,
  ),
  TaskStatus.TASK_STATUS_ACTIVE_WITH_ALARM: TaskLabel._(
    short: Loco.current.taskDetailStatusActiveWithAlarmShort,
    long: Loco.current.taskDetailStatusActiveWithAlarmLong,
    longVariant: Loco.current.taskDetailStatusActiveWithAlarmLong,
  ),
  TaskStatus.TASK_STATUS_ACTIVE_WITH_TECH_ALARM: TaskLabel._(
    short: Loco.current.taskDetailStatusActiveWithTechAlarmShort,
    long: Loco.current.taskDetailStatusActiveWithTechAlarmLong,
    longVariant: Loco.current.taskDetailStatusActiveWithTechAlarmLong,
  ),
  TaskStatus.TASK_STATUS_SENSOR_REQUIRED: TaskLabel._(
    short: Loco.current.taskDetailStatusSensorsRequiredShort,
    long: Loco.current.taskDetailStatusSensorsRequiredLong,
    longVariant: Loco.current.taskDetailStatusSensorsRequiredLong,
  ),
  TaskStatus.TASK_STATUS_SENSOR_COMPLETED: TaskLabel._(
    short: Loco.current.taskDetailStatusSensorsCompletedShort,
    long: Loco.current.taskDetailStatusSensorsCompletedLong,
    longVariant: Loco.current.taskDetailStatusSensorsCompletedLong,
  ),
  TaskStatus.TASK_STATUS_START_PENDING: TaskLabel._(
    short: Loco.current.taskDetailStatusStartPendingShort,
    long: Loco.current.taskDetailStatusStartPendingLong,
    longVariant: Loco.current.taskDetailStatusStartPendingLongVariant,
  ),
  TaskStatus.TASK_STATUS_STOP_PENDING: TaskLabel._(
    short: Loco.current.taskDetailStatusStopPendingShort,
    long: Loco.current.taskDetailStatusStopPendingLong,
    longVariant: Loco.current.taskDetailStatusStopPendingLongVariant,
  ),
};

final Map<TaskStatus, ZSTaskColor> _taskColors = {
  TaskStatus.TASK_STATUS_ACTIVE: const ZSTaskColor._(
    primary: ZSColors.success,
    backgroundColor: ZSColors.successLight,
    primaryVariant: ZSColors.successG400,
  ),
  TaskStatus.TASK_STATUS_ACTIVE_WITH_ALARM: const ZSTaskColor._(
    primary: ZSColors.errorLight,
    primaryVariant: ZSColors.errorLightBG,
    backgroundColor: ZSColors.errorLightBG,
  ),
  TaskStatus.TASK_STATUS_SENSOR_REQUIRED: const ZSTaskColor._(
    primary: ZSColors.info,
    primaryVariant: ZSColors.neutralLight300,
    backgroundColor: ZSColors.infoP50,
  ),
  TaskStatus.TASK_STATUS_SENSOR_COMPLETED: const ZSTaskColor._(
    primary: ZSColors.neutralLight300,
    primaryVariant: ZSColors.neutralLight20,
    backgroundColor: ZSColors.neutralLight20,
  ),
  TaskStatus.TASK_STATUS_START_PENDING: const ZSTaskColor._(
    primary: ZSColors.teal,
    primaryVariant: ZSColors.tealLight,
    backgroundColor: ZSColors.tealLight,
  ),
  TaskStatus.TASK_STATUS_STOP_PENDING: const ZSTaskColor._(
    primary: ZSColors.warning,
    primaryVariant: ZSColors.warningLight,
    backgroundColor: ZSColors.warningLight,
  ),
};

class TaskLabel {
  final String short;
  final String long;
  final String longVariant;
  const TaskLabel._({required this.short, required this.long, required this.longVariant});

  factory TaskLabel.fromTask(TaskStatus status) {
    final badge = _taskStatusLabels[status];
    if (badge == null) return _kDefaultStatusToBadge;

    return badge;
  }

  factory TaskLabel.alerts(AlertsEnum alert) {
    final badge = _alertsLabels[alert];
    if (badge == null) return _kDefaultStatusToBadge;
    return badge;
  }
}

class ZSTaskColor {
  final Color primary;
  final Color primaryVariant;
  final Color backgroundColor;

  const ZSTaskColor._({required this.primary, required this.primaryVariant, required this.backgroundColor});
  factory ZSTaskColor.fromTask(TaskStatus status) {
    return _taskColors[status] ?? kDefaultTaskColor;
  }
}

extension TaskStatusColor on TaskStatus {
  ZSTaskColor get color => ZSTaskColor.fromTask(this);
}

const _kDefaultStatusToBadge = TaskLabel._(short: 'unknown', long: 'Unknown', longVariant: 'Unknown');
const kDefaultTaskColor = ZSTaskColor._(
  primary: ZSColors.primaryDark,
  primaryVariant: ZSColors.primaryB300,
  backgroundColor: ZSColors.primaryB300,
);

Widget startDate(DateTime? date, BuildContext context) {
  if (date == null) {
    return const Text('-');
  }

  return Text(
    formatDetailed.format(date.toLocal()),
    style: Theme.of(context).textTheme.bodyLarge,
  );
}

Widget endDate(DateTime? startDate, DateTime? endDate, BuildContext context) {
  if (startDate == null && endDate == null) {
    return const Text('-');
  }
  if (startDate != null && endDate == null) {
    return Text(
      Loco.of(context).taskDetailTimeEndInProgress,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
  if (endDate == null) {
    return const Text('-');
  }

  final now = DateTime.now();
  if (now.isBefore(endDate)) {
    return Text(
      Loco.of(context).taskDetailTimeEndInProgress,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  return Text(
    formatDetailed.format(endDate.toLocal()),
    style: Theme.of(context).textTheme.bodyLarge,
  );
}

extension TaskDetailsExt on SensorType {
  String sensorTypeString() {
    switch (this) {
      case SensorType.SENSOR_TYPE_TEMPERATURE:
        return Loco.current.sensorTypeTemperature;
      case SensorType.SENSOR_TYPE_HUMIDITY:
        return Loco.current.sensorTypeHumidity;
      case SensorType.SENSOR_TYPE_PRESSURE:
        return Loco.current.sensorTypePressure;
      case SensorType.SENSOR_TYPE_LIGHT:
        return Loco.current.sensorTypeLight;
      case SensorType.SENSOR_TYPE_INERTIAL:
        return Loco.current.sensorTypeInertial;
      default:
        return Loco.current.taskDetailInfoNotSet;
    }
  }
}

extension TaskDelayExt on StartDelayed {
  String? getDelayValue() {
    if (delayedMinutes != null) return '${delayedMinutes.toString()} ${Loco.current.minutes}';
    if (delayedTempAbove != null) {
      return '${Loco.current.labelAbove} ${Loco.current.taskDetailInfoDegree(delayedTempAbove!)}';
    }
    if (delayedTempBelow != null) {
      return '${Loco.current.labelBelow} ${Loco.current.taskDetailInfoDegree(delayedTempBelow!)}';
    }
    if (delayedUntil != null) {
      return '${Loco.current.labelUntil} ${formatDateFilterMD24.format(delayedUntil!.toLocal())}';
    }

    return Loco.current.notSpecified;
  }

  bool onButtonPressed() {
    return onButtonPress != null && onButtonPress!;
  }
}

String temperatureWithSuffix({
  required num celcius,
  TemperatureUnit temperatureUnit = TemperatureUnit.TEMPERATURE_UNIT_UNSPECIFIED,
}) {
  return '${celcius.toStringAsFixed(celcius.truncateToDouble() == celcius ? 0 : 2)}°C';
}

enum TemperatureUnit {
  TEMPERATURE_UNIT_UNSPECIFIED,
  TEMPERATURE_UNIT_CELSIUS,
  TEMPERATURE_UNIT_FAHRENHEIT,
}

enum AlertsEnum {
  highLimitAlarms,
  lowLimitAlarms,
  lowBattery,
}

final _alertsLabels = {
  AlertsEnum.highLimitAlarms: TaskLabel._(
    short: Loco.current.taskDetailAlertHighLimitShort,
    long: Loco.current.taskDetailAlertHighLimitLong,
    longVariant: Loco.current.taskDetailAlertHighLimitLongVariant,
  ),
  AlertsEnum.lowLimitAlarms: TaskLabel._(
    short: Loco.current.taskDetailAlertLowLimitShort,
    long: Loco.current.taskDetailAlertLowLimitLong,
    longVariant: Loco.current.taskDetailAlertLowLimitLongVariant,
  ),
  AlertsEnum.lowBattery: TaskLabel._(
    short: Loco.current.taskDetailAlertLowBatteryShort,
    long: Loco.current.taskDetailAlertLowBatteryLong,
    longVariant: Loco.current.taskDetailAlertLowBatteryLongVariant,
  ),
};

String generateRandomTaskName() {
  var r = Random();
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return 'Task ${List.generate(10, (index) => _chars[r.nextInt(_chars.length)]).join()}';
}

String? taskInfoStartMode(TaskDetails? taskDetails) {
  if (taskDetails != null && taskDetails.startImmediately != null) {
    return Loco.current.taskDetailInfoStartModeImmediately;
  } else if (taskDetails != null &&
      taskDetails.startDelayed != null &&
      taskDetails.startDelayed!.onButtonPress != null &&
      taskDetails.startDelayed!.onButtonPress!) {
    return Loco.current.createTaskItemButtonPress;
  } else if (taskDetails != null &&
      taskDetails.startDelayed != null &&
      taskDetails.startDelayed!.onButtonPress != null &&
      taskDetails.startDelayed!.onButtonPress == false) {
    return Loco.current.taskDetailInfoStartModeDelayed;
  } else {
    return null;
  }
}

String? taskStartDelay(TaskDetails? taskDetails) {
  if (taskDetails != null &&
      taskDetails.startDelayed != null &&
      taskDetails.startDelayed!.onButtonPress != null &&
      taskDetails.startDelayed!.onButtonPress == false) {
    return taskDetails.startDelayed?.getDelayValue();
  } else {
    return Loco.current.notSpecified;
  }
}
