import 'package:either_option/either_option.dart';
import 'package:zsdemo_app/models/models.dart';
import 'package:zsdemo_app/services/bluetooth_service.dart';
import 'package:zsdemo_app/services/zsdemo_api_service.dart';
import 'package:zsdemo_app/states/sensor/sensor_state.dart';
import 'package:zsdemo_app/states/base_state.dart';

class EnrollSensorState extends BaseState with ZSDemoAPIServiceMixin, BluetoothServiceMixin, SensorStateMixin {
  EnrollSensorState();

  EnrollmentStatus _enrollmentStatus = EnrollmentStatus.enrollSensor;
  EnrollmentStatus get enrollmentStatus => _enrollmentStatus;
  set enrollmentStatus(EnrollmentStatus enrollmentStatus) {
    _enrollmentStatus = enrollmentStatus;
    notifyListeners();
  }

  UserLevelError? _error;
  UserLevelError? get error => _error;
  set error(UserLevelError? error) {
    _error = error;
    notifyListeners();
  }

  Sensor? sensor;

  void scanAgain() {
    sensorState.sensorPageState = SensorPageState.scanCode;
  }

  Future<void> checkBatteryLevel() async {
    if (sensor!.batteryLevel! <= 5) {
      error = const SensorLowBatteryError();
    } else {
      enrollmentStatus = EnrollmentStatus.enrollSensorSuccess;
    }
  }

  Future<void> enrollSensor() async {
    if (enrollmentStatus != EnrollmentStatus.verifyingSensorEnrollment) {
      enrollmentStatus = EnrollmentStatus.verifyingSensorEnrollment;
    }
    final Option<ZSAPIError> res = await apiService.enrollSensor(sensorState.sensorId!.serialNumber);

    if (res.isDefined) {
      final ZSAPIError? e = res.getOrElse(() => null);
      if (e != null) {
        if (e.message == 'sensor enrollment already started' || e.message == 'sensor already has pending enrollment') {
          await prioritizeSensor();
          enrollmentStatus = EnrollmentStatus.pendingEnrollment;
        } else if (e.message == "sensor already enrolled on tenant") {
          await checkBatteryLevel();
        } else if (e.message == "sensor already enrolled on another tenant") {
          enrollmentStatus = EnrollmentStatus.sensorEnrolledOtherTenant;
        } else {
          error = e;
        }
      }

      return;
    } else {
      await prioritizeSensor();
      await verifyEnrollment();
    }
  }

  Future<void> verifyEnrollment() async {
    if (enrollmentStatus != EnrollmentStatus.verifyingSensorEnrollment) {
      enrollmentStatus = EnrollmentStatus.verifyingSensorEnrollment;
    }
    int counter = 1;
    bool sensorEnrolled = false;
    while (counter <= 6) {
      await Future.delayed(const Duration(seconds: 10));
      counter++;
      final Either<ZSAPIError, Sensor?> res = await apiService.getSensorInfo(sensorState.sensorId!.serialNumber);
      sensorEnrolled = await res.fold((e) async => false, (s) async {
        if (s != null) {
          sensor = s;
          return true;
        }
        return false;
      });
      if (sensorEnrolled) {
        await checkBatteryLevel();
        break;
      }
    }
    if (!sensorEnrolled) {
    enrollmentStatus = EnrollmentStatus.notVerifiedEnrollment;
  }
  }

  Future<void> tryAgain() async {
    error = null;
    await enrollSensor();
  }

  Future<void> prioritizeSensor() async {
    if (sensorState.sensorId!.scannedData != null &&
        sensorState.sensorId!.scannedData!.id != null &&
        sensorState.sensorId!.scannedData!.id!.isNotEmpty) {
      await bluetoothService.prioritizeSensor(sensorState.sensorId!.scannedData!.id!);
    }
  }
}
