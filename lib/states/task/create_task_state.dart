import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/utils/task.dart';
import 'package:zsdemo_app/components/dialogs/snackbar.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/models.dart';
import 'package:zsdemo_app/models/wrapped.dart';
import 'package:zsdemo_app/services/zsdemo_api_service.dart';
import 'package:zsdemo_app/states/base_state.dart';
import 'package:zsdemo_app/states/sensor/sensor_state.dart';

class CreateTaskState extends BaseState with ZSDemoAPIServiceMixin, SensorStateMixin {
  CreateTaskState();
  TaskDetails taskDetails = const TaskDetails();

  bool get lowLimitSet {
    return !(alarmLowTemp == null || alarmLowTemp!.isEmpty);
  }

  bool get highLimitSet {
    return !(alarmHighTemp == null || alarmHighTemp!.isEmpty);
  }

  ZSAPIError? _error;
  ZSAPIError? get error => _error;
  set error(ZSAPIError? error) {
    _error = error;
    notifyListeners();
  }

  bool _isValid = false;
  bool get isValid => _isValid;

  set isValid(bool valid) {
    _isValid = valid;
    notifyListeners();
  }

  void setFieldsAsTemplate() {
    loopOverwrite = taskDetails.loopReads ?? false;
    readingIntervalMinutes = taskDetails.intervalMinutes.toString();
    readingIntervalSeconds = taskDetails.intervalSeconds.toString();
    if (taskDetails.alarmLowTemp != null) {
      alarmLowTemp = taskDetails.alarmLowTemp.toString();
    } else {
      alarmLowTemp = null;
    }
    alarmHighTemp = taskDetails.alarmHighTemp != null ? taskDetails.alarmHighTemp.toString() : alarmHighTemp = null;

    alarmDelayLowMinutes = taskDetails.lowDurationMinutes != null ? taskDetails.lowDurationMinutes.toString() : alarmDelayLowMinutes = null;

    alarmDelayLowSeconds = taskDetails.lowDurationSeconds != null ? taskDetails.lowDurationSeconds.toString() : alarmDelayLowSeconds = null;

    alarmDelayHighMinutes = taskDetails.highDurationMinutes != null ? taskDetails.highDurationMinutes.toString() : alarmDelayHighMinutes = null;

    alarmDelayHighSeconds = taskDetails.highDurationSeconds != null ? taskDetails.highDurationSeconds.toString() : alarmDelayHighSeconds = null;

    if (taskDetails.startImmediately != null) {
      startMode = StartMode.immediatelly;
    } else if (taskDetails.startDelayed?.onButtonPress != null) {
      startMode = StartMode.onPressed;
    } else if (taskDetails.startDelayed != null) {
      startMode = StartMode.delayed;
    } else {
      startMode = StartMode.immediatelly;
    }
    tempAbove = taskDetails.startDelayed?.delayedTempAbove != null ? taskDetails.startDelayed!.delayedTempAbove.toString() : null;
    tempBelow = taskDetails.startDelayed?.delayedTempBelow != null ? taskDetails.startDelayed!.delayedTempBelow.toString() : null;
    delayedUntil = taskDetails.startDelayed?.delayedUntil != null ? taskDetails.startDelayed!.delayedUntil : null;
    delayTimeToStart = taskDetails.startDelayed?.delayedMinutes != null ? taskDetails.startDelayed!.delayedMinutes.toString() : null;
    if (tempAbove != null) {
      delayedOption = DelayedOption.tempAbove;
    } else if (delayTimeToStart != null) {
      delayedOption = DelayedOption.delayTime;
    } else if (delayedUntil != null) {
      delayedOption = DelayedOption.delayUntil;
    } else {
      delayedOption = DelayedOption.tempBelow;
    }
  }

  Future<Either<ZSAPIError, String>> createTask(TaskDetails taskDetails) async {
    busy = true;
    if (taskDetails.startDelayed?.delayedUntil != null && taskDetails.startDelayed!.delayedUntil!.compareTo(DateTime.now()) < 0) {
      taskDetails = taskDetails.copyWith(
          startDelayed: Wrapped.value(StartDelayed(
        delayedUntil: DateTime.now().add(const Duration(minutes: 1)).toUtc(),
      )));
    }
    final res = await apiService.createTask(taskDetails);
    busy = false;
    res.fold((ZSAPIError error) {
      if (error.code == '3' && error.message == 'Cannot create task with duplicate name for tenant') {
        taskDetails = taskDetails.copyWith(name: Wrapped.value(generateRandomTaskName()));
        createTask(taskDetails);
        return;
      }
      _error = error;
      showZSSnackBar(
        ZSSnackBar.icon(
          label: Text(error.message!.contains('Failed host lookup') ? Loco.current.connectionErrorMesssage : error.message!),
          iconBackgroundColor: ZSColors.error,
        ),
      );
    }, (id) async {
      final SensorTaskData mostRecent = sensorState.sensor!.mostRecent!.copyWith(taskId: id);
      sensorState.sensor = sensorState.sensor!.copyWith(mostRecent: mostRecent);
      sensorState.sensorPageState = SensorPageState.associateSensor;
    });
    return res;
  }

  bool syncForm() {
    taskDetails = taskDetails.copyWith(name: Wrapped.value(_name));

    taskDetails = taskDetails.copyWith(
      intervalSeconds: Wrapped.value(int.tryParse(readingIntervalSeconds)),
      intervalMinutes: Wrapped.value(int.tryParse(readingIntervalMinutes)),
    );

    taskDetails = taskDetails.copyWith(alarmLowTemp: Wrapped.value(alarmLowTemp != null ? int.tryParse(alarmLowTemp!) : null));
    taskDetails = taskDetails.copyWith(alarmHighTemp: Wrapped.value(alarmHighTemp != null ? int.tryParse(alarmHighTemp!) : null));

    if (delayedUntil == null && startMode == StartMode.delayed && delayedOption == DelayedOption.delayUntil) {
      delayedUntilError = Loco.current.createTaskDelayedError;
      notifyListeners();
      throw Exception(Loco.current.taskDetailStartModeDelayed);
    } else {
      delayedUntilError = null;
      notifyListeners();
    }
    switch (startMode) {
      case StartMode.immediatelly:
        taskDetails = taskDetails.copyWith(startImmediately: const Wrapped.value({}));
        break;
      case StartMode.onPressed:
        taskDetails = taskDetails.copyWith(
            startDelayed: Wrapped.value(StartDelayed(
          onButtonPress: true,
        )));
        break;
      case StartMode.delayed:
        switch (delayedOption) {
          case DelayedOption.tempBelow:
            taskDetails = taskDetails.copyWith(
                startDelayed: Wrapped.value(StartDelayed(
              delayedTempBelow: double.tryParse(tempBelow!),
            )));
            break;
          case DelayedOption.tempAbove:
            taskDetails = taskDetails.copyWith(
                startDelayed: Wrapped.value(StartDelayed(
              delayedTempAbove: double.tryParse(tempAbove!),
            )));
            break;
          case DelayedOption.delayTime:
            taskDetails = taskDetails.copyWith(
                startDelayed: Wrapped.value(StartDelayed(
              delayedMinutes: int.tryParse(delayTimeToStart!),
            )));
            break;
          case DelayedOption.delayUntil:
            taskDetails = taskDetails.copyWith(
                startDelayed: Wrapped.value(StartDelayed(
              delayedUntil: delayedUntil != null ? delayedUntil!.toUtc() : DateTime.now().add(const Duration(minutes: 5)).toUtc(),
            )));
            break;
        }
        break;
    }

    taskDetails = taskDetails.copyWith(lowDurationMinutes: Wrapped.value(alarmDelayLowMinutes != null ? int.tryParse(alarmDelayLowMinutes!) : null));
    taskDetails = taskDetails.copyWith(lowDurationSeconds: Wrapped.value(alarmDelayLowSeconds != null ? int.tryParse(alarmDelayLowSeconds!) : null));
    taskDetails = taskDetails.copyWith(highDurationMinutes: Wrapped.value(alarmDelayHighMinutes != null ? int.tryParse(alarmDelayHighMinutes!) : null));
    taskDetails = taskDetails.copyWith(highDurationSeconds: Wrapped.value(alarmDelayHighSeconds != null ? int.tryParse(alarmDelayHighSeconds!) : null));

    taskDetails = taskDetails.copyWith(loopReads: Wrapped.value(_loopOverwrite));
    return true;
  }

  bool editing = false;

  final String _name = generateRandomTaskName();
  String get name => _name;

  String? nameError;
  String? readingIntervalError;

  String _readingIntervalSeconds = '15';

  String get readingIntervalSeconds => _readingIntervalSeconds;

  set readingIntervalSeconds(String readingInterval) {
    _readingIntervalSeconds = readingInterval;
    notifyListeners();
  }

  void changeReadingIntervalSeconds(String seconds) {
    _readingIntervalSeconds = seconds;

    if ((seconds.isEmpty || int.parse(_readingIntervalSeconds) < 15) && _readingIntervalMinutes == '0') {
      _readingIntervalSeconds = '15';
    } else if (seconds.isEmpty && _readingIntervalMinutes != '0') {
      _readingIntervalSeconds = '0';
    } else {
      final intSeconds = int.parse(seconds);
      if (intSeconds > 0 && _readingIntervalMinutes == '240') {
        _readingIntervalSeconds = '0';
      } else if (intSeconds > 59) {
        _readingIntervalSeconds = '59';
      } else if (intSeconds < 0) {
        _readingIntervalSeconds = '0';
      }
    }

    notifyListeners();
  }

  String _readingIntervalMinutes = '0';

  String get readingIntervalMinutes => _readingIntervalMinutes;

  set readingIntervalMinutes(String readingIntervalMinutes) {
    _readingIntervalMinutes = readingIntervalMinutes;
    notifyListeners();
  }

  void changeReadingIntervalMinutes(String minutes) {
    _readingIntervalMinutes = minutes;
    if (minutes.isEmpty || minutes == '0') {
      _readingIntervalMinutes = '0';
      if (_readingIntervalSeconds.isEmpty || int.parse(_readingIntervalSeconds) < 15) {
        _readingIntervalSeconds = '15';
      }
    } else if (minutes == '240') {
      _readingIntervalSeconds = '0';
    }

    notifyListeners();
  }

  bool get alarmIsEmpty {
    if (alarmLowTemp == null || alarmHighTemp == null) return true;
    return (alarmLowTemp!.isEmpty && alarmHighTemp!.isEmpty) || (alarmLowTemp!.contains('') && alarmHighTemp!.contains(''));
  }

  String? _alarmLowTemp;

  String? get alarmLowTemp => _alarmLowTemp;

  set alarmLowTemp(String? alarmLowTemp) {
    _alarmLowTemp = alarmLowTemp;
    notifyListeners();
  }

  String? _alarmHighTemp;

  String? get alarmHighTemp => _alarmHighTemp;

  set alarmHighTemp(String? alarmHighTemp) {
    _alarmHighTemp = alarmHighTemp;
    notifyListeners();
  }

  String? _alarmDelayLowMinutes;

  String? get alarmDelayLowMinutes => _alarmDelayLowMinutes;

  set alarmDelayLowMinutes(String? alarmDelayLowMinutes) {
    _alarmDelayLowMinutes = alarmDelayLowMinutes;
    notifyListeners();
  }

  String? _alarmDelayLowSeconds;

  String? get alarmDelayLowSeconds => _alarmDelayLowSeconds;

  set alarmDelayLowSeconds(String? alarmDelayLowSeconds) {
    _alarmDelayLowSeconds = alarmDelayLowSeconds;
    notifyListeners();
  }

  String? _alarmDelayHighMinutes;

  String? get alarmDelayHighMinutes => _alarmDelayHighMinutes;

  set alarmDelayHighMinutes(String? alarmDelayHighMinutes) {
    _alarmDelayHighMinutes = alarmDelayHighMinutes;
    notifyListeners();
  }

  String? _alarmDelayHighSeconds;

  String? get alarmDelayHighSeconds => _alarmDelayHighSeconds;

  set alarmDelayHighSeconds(String? alarmDelayHighSeconds) {
    _alarmDelayHighSeconds = alarmDelayHighSeconds;
    notifyListeners();
  }

  String? _tempAbove;

  String? get tempAbove => _tempAbove;

  set tempAbove(String? tempAbove) {
    _tempAbove = tempAbove;
    notifyListeners();
  }

  String? _tempBelow;

  String? get tempBelow => _tempBelow;

  set tempBelow(String? tempBelow) {
    _tempBelow = tempBelow;
    notifyListeners();
  }

  String? _delayTimeToStart;

  String? get delayTimeToStart => _delayTimeToStart;

  set delayTimeToStart(String? delayTimeToStart) {
    _delayTimeToStart = delayTimeToStart;
    notifyListeners();
  }

  DateTime? _delayedUntil;
  String? delayedUntilError;

  DateTime? get delayedUntil => _delayedUntil;

  set delayedUntil(DateTime? delayedUntil) {
    _delayedUntil = delayedUntil;
    notifyListeners();
  }

  // DELAYED UNTIL
  bool _enableDelayedUntil = true;

  bool get enableDelayedUntil => _enableDelayedUntil;

  set enableDelayedUntil(bool enableDelayedUntil) {
    _enableDelayedUntil = enableDelayedUntil;
    if (!_enableDelayedUntil) {
      delayedUntil = null;
    }
    notifyListeners();
  }

  StartMode _startMode = StartMode.immediatelly;

  StartMode get startMode => _startMode;

  set startMode(StartMode selectedMode) {
    _startMode = selectedMode;
    notifyListeners();
  }

  // SELECTED MODE

  // SELECTED DELAYED OPTION
  DelayedOption _delayedOption = DelayedOption.tempBelow;

  DelayedOption get delayedOption => _delayedOption;

  set delayedOption(DelayedOption dOption) {
    _delayedOption = dOption;
    notifyListeners();
  }

  // SELECTED DELAYED OPTION

  // LOOP OVERWRITE
  bool _loopOverwrite = false;

  bool get loopOverwrite => _loopOverwrite;

  set loopOverwrite(bool loopOverwrite) {
    _loopOverwrite = loopOverwrite;
    notifyListeners();
  }
  // LOOP OVERWRITE
}

final selectedModes = <StartMode, String>{
  StartMode.immediatelly: Loco.current.createTaskItmImmediately,
  StartMode.onPressed: Loco.current.createTaskItmButtonPress,
  StartMode.delayed: Loco.current.createTaskItmDelayUntil
};

enum StartMode { immediatelly, onPressed, delayed }

extension StartModeExtension on StartMode {
  String toModeString() {
    return selectedModes[this]!;
  }

  String startModeOverview(DateTime? delayedUntil) {
    switch (this) {
      case StartMode.immediatelly:
        return toModeString();
      case StartMode.onPressed:
        return toModeString();
      case StartMode.delayed:
        return toModeString();
    }
  }
}

final selectedDelayedOption = <DelayedOption, String>{
  DelayedOption.tempBelow: Loco.current.createTaskItmTempBelow,
  DelayedOption.tempAbove: Loco.current.createTaskItmTempAbove,
  DelayedOption.delayTime: Loco.current.createTaskItmDelayTimeStart,
  DelayedOption.delayUntil: Loco.current.createTaskItmDelayUntil,
};

enum DelayedOption { tempBelow, tempAbove, delayTime, delayUntil }

extension DelayedOptionExt on DelayedOption {
  String toDelayOptionString() {
    return selectedDelayedOption[this]!;
    // switch (this) {
    //   case DelayedOption.tempBelow:
    //     return Loco.createTaskItemTempBelow;
    //   case DelayedOption.tempAbove:
    //     return Loco.createTaskItemTempAbove;
    //   case DelayedOption.delayTime:
    //     return Loco.createTaskItemDelayTimeStart;
    //   case DelayedOption.delayUntil:
    //     return Loco.createTaskItemDelayedUntil;
    // }
  }
}
