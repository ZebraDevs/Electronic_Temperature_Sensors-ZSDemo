import 'package:either_option/either_option.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/models.dart';
import 'package:zsdemo_app/services/bluetooth_service.dart';
import 'package:zsdemo_app/services/zsdemo_api_service.dart';
import 'package:zsdemo_app/states/base_state.dart';
import 'package:zsdemo_app/states/sensor/sensor_state.dart';

class AssociateSensorState extends BaseState with ZSDemoAPIServiceMixin, BluetoothServiceMixin, SensorStateMixin {
  AssociateSensorState();

  AssignSensorState _status = AssignSensorState.associatingSensor;
  AssignSensorState get status => _status;
  set status(AssignSensorState status) {
    _status = status;
    notifyListeners();
  }

  UserLevelError? _error;
  UserLevelError? get error => _error;
  set error(UserLevelError? error) {
    _error = error;
    notifyListeners();
  }

  int assignAttempts = 0;

  Future<void> assignSensorToTask() async {
    if (status != AssignSensorState.associatingSensor) {
      status = AssignSensorState.associatingSensor;
    }
    await checkBatteryLevel();
    final Either<ZSAPIError, AssociateSensorResponse> res = await apiService.associateSensorsToTask(
      [sensorState.sensor!],
      sensorState.sensor!.mostRecent!.taskId!,
    );
    res.fold((e) {
      error = e;
    }, (success) async {
      if (success.associatedSensors.isNotEmpty) {
        await bluetoothService.prioritizeSensor(sensorState.sensor!.macAddress!);
        status = AssignSensorState.assignedSensor;
      } else {
        error = GenericUserError(
          title: Loco.current.associateSensorErrorGeneralTitle,
          message: success.failedSensors.first.error!.asString(),
        );
      }
    });
  }

  Future<void> checkBatteryLevel() async {
    if (sensorState.sensor == null) return;
    if (sensorState.sensor!.batteryLevel! <= 5) {
      error = GenericUserError(
        title: Loco.current.associateSensorErrorGeneralTitle,
        message: Loco.current.associateSensorErrorLowBattery,
      );
      return;
    }
  }
}
