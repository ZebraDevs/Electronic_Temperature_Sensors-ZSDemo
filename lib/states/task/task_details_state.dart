import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:zsdemo_app/app.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/components/dialogs/dialog_widget.dart';
import 'package:zsdemo_app/components/dialogs/snackbar.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/models.dart';
import 'package:zsdemo_app/services/bluetooth_service.dart';
import 'package:zsdemo_app/services/zsdemo_api_service.dart';
import 'package:zsdemo_app/states/base_state.dart';

class TaskDetailsState extends BaseState with ZSDemoAPIServiceMixin, BluetoothServiceMixin {
  final String _taskId;

  Task? _task;
  Task? get task => _task;
  set task(Task? task) {
    _task = task;
    notifyListeners();
  }

  Sensor _sensor;
  Sensor get sensor => _sensor;
  set sensor(Sensor sensor) {
    _sensor = sensor;
    notifyListeners();
  }

  UserLevelError? _error;
  UserLevelError? get error => _error;
  set error(UserLevelError? error) {
    _error = error;
    notifyListeners();
  }

  bool _stoppingTask = false;
  bool get stoppingTask => _stoppingTask;
  set stoppingTask(bool value) {
    _stoppingTask = value;
    notifyListeners();
  }

  TaskDetailsState({required String taskId, required Sensor sensor})
      : _sensor = sensor,
        _taskId = taskId,
        super(busy: true);

  Future<void> stopTask(BuildContext context) async {
    int numberOfTries = 1;
    if (task != null) {
      stoppingTask = true;
      while (true) {
        final Either<ZSAPIError, Task> stopRes = await apiService.stopTask(task!.id!);
        if (stopRes.isLeft) {
          if (numberOfTries >= 3) {
            stopRes.fold((e) {
              showDialog(
                context: context,
                builder: (_) {
                  return ZSDialogWidget(
                    title: Text(e.toErrorData().errorTitle),
                    content: [
                      Text(
                        e.toErrorData().errorDescription,
                        style: Theme.of(_).textTheme.bodyLarge,
                      )
                    ],
                    button: TextButton(
                      child: Text(Loco.current.cancel),
                      onPressed: () => navigatorKey.currentState?.pop(),
                    ),
                    optionalButton: TextButton(
                      onPressed: () {
                        navigatorKey.currentState?.pop();
                        stopTask(context);
                      },
                      child: Text(
                        Loco.current.retry,
                        style: const TextStyle(
                          color: ZSColors.error,
                        ),
                      ),
                    ),
                  );
                },
              );
            }, (t) => null);
            stoppingTask = false;
            break;
          }
          numberOfTries++;
        } else {
          await bluetoothService.prioritizeSensor(sensor.macAddress!);
          stopRes.fold((e) => null, (t) {
            task = t;
            getSensorDetails();
            if (t.status == TaskStatus.TASK_STATUS_STOP_PENDING) {
              showDialog(
                context: context,
                builder: (_) {
                  return ZSDialogWidget(
                    title: Text(Loco.of(context).stopTaskPending),
                    content: [
                      Text(
                        Loco.of(context).stopTaskPendingDesc(sensor.serialNumber!),
                        style: Theme.of(_).textTheme.bodyLarge,
                      )
                    ],
                    button: TextButton(
                      child: Text(Loco.current.ok),
                      onPressed: () => navigatorKey.currentState?.pop(),
                    ),
                  );
                },
              );
              checkTaskStopped();
            } else if (t.status == TaskStatus.TASK_STATUS_SENSOR_COMPLETED) {
              showZSSnackBar(
                ZSSnackBar.basic(label: Text(Loco.of(context).stopTaskSuccess)),
              );
            }
          });
          stoppingTask = false;
          break;
        }
      }
    }
  }

  Future<void> getTaskData(BuildContext context) async {
    return whileBusy(() async {
      final res = await apiService.getTask(_taskId);
      res.fold((ZSAPIError e) {
        error = e;
      }, (Task t) {
        task = t;
        if (t.status == TaskStatus.TASK_STATUS_STOP_PENDING) {
          checkTaskStopped();
        }
        getSensorDetails();
      });
    });
  }

  Future<void> checkTaskStopped() async {
    while (task!.status == TaskStatus.TASK_STATUS_STOP_PENDING) {
      await Future.delayed(const Duration(seconds: 5));
      final res = await apiService.getTask(_taskId);
      res.fold(
        (ZSAPIError e) {},
        (Task t) {
          if (t.status == TaskStatus.TASK_STATUS_SENSOR_COMPLETED) {
            task = t;
            getSensorDetails();
            showZSSnackBar(
              ZSSnackBar.basic(label: Text(Loco.current.stopTaskSuccess)),
            );
          }
        },
      );
    }
  }

  Future<void> getSensorDetails() async {
    return whileBusy(() async {
      final Either<ZSAPIError, Sensor?> res = await apiService.getSensorInfo(sensor.serialNumber!);
      res.fold((e) => null, (Sensor? s) {
        if (s != null) {
          sensor = s;
        }
      });
    });
  }
}
