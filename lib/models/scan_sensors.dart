import 'package:zsdemo_app/common/utils/scan.dart';

class SensorSerialNumberData {
  final String serialNumber;
  final ScannedData? scannedData;
  const SensorSerialNumberData({
    required this.serialNumber,
    this.scannedData,
  });
}

class ScannedData extends SensorSerialNumberData {
  final String? macAddress;
  final String? friendlyName;
  final String? version;
  final String? id;

  const ScannedData({
    this.macAddress,
    this.friendlyName,
    this.version,
    this.id,
    required String serialNumber,
  }) : super(serialNumber: serialNumber);

  factory ScannedData.fromMap(Map<String, String> map) {
    String macAddress = '';
    String id = '';
    if (map['m'] != null) {
      macAddress = decodedMacAddress(map['m']!);
      id = map['m']!;
    }
    if (map['mB'] != null) {
      macAddress = decodedMacAddress(map['mB']!);
      id = map['mB']!;
    }
    final (String, String) sn = decodeSN(map['n']!);
    return ScannedData(
      macAddress: macAddress,
      friendlyName: sn.$1,
      version: map['v'],
      serialNumber: sn.$2,
      id: id,
    );
  }
}

enum SensorPageState {
  scanCode,
  validateSN,
  enrollSensor,
  createTask,
  taskDetails,
  associateSensor,
}

enum AssignSensorState {
  associatingSensor,
  assignedSensor,
}

enum EnrollmentStatus {
  enrollSensor,
  verifyingSensorEnrollment,
  pendingEnrollment,
  sensorEnrolledOtherTenant,
  notVerifiedEnrollment,
  enrollSensorSuccess,
}
