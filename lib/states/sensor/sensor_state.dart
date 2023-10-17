import 'package:either_option/either_option.dart';
import 'package:zsdemo_app/common/extensions/sensor.dart';
import 'package:zsdemo_app/models/models.dart';
import 'package:zsdemo_app/services/bluetooth_service.dart';
import 'package:zsdemo_app/services/zsdemo_api_service.dart';
import 'package:zsdemo_app/states/base_state.dart';
import 'package:zsdemo_app/states/mixins/location_mixin.dart';

mixin SensorStateMixin {
  late SensorState sensorState;
}

class SensorState extends BaseState with LocationStateMixin, BluetoothServiceMixin, ZSDemoAPIServiceMixin {
  SensorSerialNumberData? _sensorId;
  SensorSerialNumberData? get sensorId => _sensorId;
  set sensorId(SensorSerialNumberData? sensorId) {
    _sensorId = sensorId;
    // Immediately when next page - fetch sensor
    if (_sensorId != null) {
      sensorPageState = SensorPageState.validateSN;
      getSensorDetails();
    }
  }

  SensorPageState _sensorPageState = SensorPageState.scanCode;
  SensorPageState get sensorPageState => _sensorPageState;
  set sensorPageState(SensorPageState sensorPageState) {
    _sensorPageState = sensorPageState;
    notifyListeners();
  }

  UserLevelError? _error;
  UserLevelError? get error => _error;

  BLESensor? bleSensor;

  Sensor? _sensor;
  Sensor? get sensor => _sensor;
  set sensor(Sensor? s) {
    _sensor = s;
    notifyListeners();
  }

  set error(UserLevelError? error) {
    _error = error;
    notifyListeners();
  }

  Future<void> getSensorDetails() async {
    return whileBusy(() async {
      final Either<ZSAPIError, Sensor?> res = await apiService.getSensorInfo(sensorId!.serialNumber);
      res.fold((ZSAPIError e) {
        error = e;
      }, (Sensor? s) {
        if (s == null) {
          sensorPageState = SensorPageState.enrollSensor;
        } else {
          populateSensor(s);
        }
      });
    });
  }

  Future<void> tryAgain() async {
    error = null;
    await getSensorDetails();
  }

  void populateSensor(Sensor s) {
    _sensor = s;
    if ((s.mostRecent!.taskId!.isNotEmpty && s.isOnTask()) ||
        s.mostRecent!.sensorTaskStatus == SensorTaskStatus.SENSOR_TASK_STATUS_START_PENDING) {
      sensorPageState = SensorPageState.taskDetails;
    } else {
      sensorPageState = SensorPageState.createTask;
    }
  }
}
