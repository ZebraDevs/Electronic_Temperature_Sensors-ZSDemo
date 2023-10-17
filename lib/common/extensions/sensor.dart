import 'package:zsdemo_app/models/models.dart';

extension SensorExt on Sensor {
  bool isOnTask() {
    switch (status) {
      case SensorStatus.SENSOR_STATUS_ACTIVE:
      case SensorStatus.SENSOR_STATUS_ACTIVE_WITH_ALARM:
        return true;
      case SensorStatus.SENSOR_STATUS_STOPPED:
      case SensorStatus.SENSOR_STATUS_UNSPECIFIED:
        return false;
      default:
        return false;
    }
  }
}
