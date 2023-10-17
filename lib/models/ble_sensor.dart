import 'dart:convert';
import 'dart:typed_data';

class BLESensor {
  final String macAddress;
  final String friendlyName;
  final String id;
  final int? rssi;
  final AdvInfo? advertisingInfo;
  final DateTime lastDiscovered;

  BLESensor({
    required this.macAddress,
    required this.friendlyName,
    required this.id,
    this.rssi,
    this.advertisingInfo,
    required this.lastDiscovered,
  });

  BLESensor copyWith({
    String? macAddress,
    String? friendlyName,
    String? id,
    int? rssi,
    AdvInfo? advertisingInfo,
    DateTime? lastDiscovered,
  }) {
    return BLESensor(
      macAddress: macAddress ?? this.macAddress,
      friendlyName: friendlyName ?? this.friendlyName,
      id: id ?? this.id,
      rssi: rssi ?? this.rssi,
      advertisingInfo: advertisingInfo ?? this.advertisingInfo,
      lastDiscovered: lastDiscovered ?? this.lastDiscovered,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'macAddress': macAddress,
      'friendlyName': friendlyName,
      'id': id,
      'rssi': rssi,
      'advertisingInfo': advertisingInfo?.toMap(),
      'lastDiscovered': lastDiscovered,
    };
  }

  factory BLESensor.fromMap(Map<String, dynamic> map) {
    return BLESensor(
      macAddress: map['macAddress'] as String,
      friendlyName: map['friendlyName'] as String,
      id: map['sensorId'] as String,
      rssi: map['rssi'] as int,
      advertisingInfo: AdvInfo.fromMap(map),
      lastDiscovered: DateTime.parse(map['lastDiscovered'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory BLESensor.fromJson(String source) => BLESensor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BLESensor(macAddress: $macAddress, friendlyName: $friendlyName, rssi: $rssi, advInfo: $advertisingInfo, lastDiscovered: $lastDiscovered)';
  }

  @override
  bool operator ==(covariant BLESensor other) {
    if (identical(this, other)) return true;

    return other.macAddress == macAddress &&
        other.friendlyName == friendlyName &&
        other.rssi == rssi &&
        other.advertisingInfo == advertisingInfo &&
        other.lastDiscovered == lastDiscovered;
  }

  @override
  int get hashCode {
    return macAddress.hashCode ^
        friendlyName.hashCode ^
        rssi.hashCode ^
        advertisingInfo.hashCode ^
        lastDiscovered.hashCode;
  }
}

class AdvInfo {
  final Uint8List? advInfoBytes;
  final int? type;
  final int? batteryLevel;
  final int? sensorStatus;
  final int? alarmStatus;
  final int? temperatureSensorStatus;
  final int? temperatureSamplesCount;
  final int? humiditySensorStatus;
  final int? humiditySamplesCount;
  final int? pressureSensorStatus;
  final int? pressureSamplesCount;
  final int? lightSensorStatus;
  final int? lightSamplesCount;
  final int? inertialSensorStatus;
  final int? inertialSamplesCount;
  final num? lastTemp;

  AdvInfo({
    this.advInfoBytes,
    this.type,
    this.batteryLevel,
    this.sensorStatus,
    this.alarmStatus,
    this.temperatureSensorStatus,
    this.temperatureSamplesCount,
    this.humiditySensorStatus,
    this.humiditySamplesCount,
    this.pressureSensorStatus,
    this.pressureSamplesCount,
    this.lightSensorStatus,
    this.lightSamplesCount,
    this.inertialSensorStatus,
    this.inertialSamplesCount,
    this.lastTemp,
  });

  AdvInfo copyWith({
    Uint8List? advInfoBytes,
    int? type,
    int? batteryLevel,
    int? sensorStatus,
    int? alarmStatus,
    int? temperatureSensorStatus,
    int? temperatureSamplesCount,
    int? humiditySensorStatus,
    int? humiditySamplesCount,
    int? pressureSensorStatus,
    int? pressureSamplesCount,
    int? lightSensorStatus,
    int? lightSamplesCount,
    int? inertialSensorStatus,
    int? inertialSamplesCount,
    num? lastTemp,
  }) {
    return AdvInfo(
      advInfoBytes: advInfoBytes ?? this.advInfoBytes,
      type: type ?? this.type,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      sensorStatus: sensorStatus ?? this.sensorStatus,
      alarmStatus: alarmStatus ?? this.alarmStatus,
      temperatureSensorStatus: temperatureSensorStatus ?? this.temperatureSensorStatus,
      temperatureSamplesCount: temperatureSamplesCount ?? this.temperatureSamplesCount,
      humiditySensorStatus: humiditySensorStatus ?? this.humiditySensorStatus,
      humiditySamplesCount: humiditySamplesCount ?? this.humiditySamplesCount,
      pressureSensorStatus: pressureSensorStatus ?? this.pressureSensorStatus,
      pressureSamplesCount: pressureSamplesCount ?? this.pressureSamplesCount,
      lightSensorStatus: lightSensorStatus ?? this.lightSensorStatus,
      lightSamplesCount: lightSamplesCount ?? this.lightSamplesCount,
      inertialSensorStatus: inertialSensorStatus ?? this.inertialSensorStatus,
      inertialSamplesCount: inertialSamplesCount ?? this.inertialSamplesCount,
      lastTemp: lastTemp ?? this.lastTemp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'advInfoBytes': List<int>.from(advInfoBytes!),
      'type': type,
      'batteryLevel': batteryLevel,
      'sensorStatus': sensorStatus,
      'alarmStatus': alarmStatus,
      'temperatureSensorStatus': temperatureSensorStatus,
      'temperatureSamplesCount': temperatureSamplesCount,
      'humiditySensorStatus': humiditySensorStatus,
      'humiditySamplesCount': humiditySamplesCount,
      'pressureSensorStatus': pressureSensorStatus,
      'pressureSamplesCount': pressureSamplesCount,
      'lightSensorStatus': lightSensorStatus,
      'lightSamplesCount': lightSamplesCount,
      'inertialSensorStatus': inertialSensorStatus,
      'inertialSamplesCount': inertialSamplesCount,
      'lastTemp': lastTemp,
    };
  }

  factory AdvInfo.fromMap(Map<String, dynamic> map) {
    return AdvInfo(
      advInfoBytes: map['advertisingInfo'] != null ? Uint8List.fromList(map['advertisingInfo'].cast<int>()) : null,
      type: map['type'] != null ? map['type'] as int : null,
      batteryLevel: map['batteryLevel'] != null ? map['batteryLevel'] as int : null,
      sensorStatus: map['sensorStatus'] != null ? map['sensorStatus'] as int : null,
      alarmStatus: map['alarmStatus'] != null ? map['alarmStatus'] as int : null,
      temperatureSensorStatus: map['temperatureSensorStatus'] != null ? map['temperatureSensorStatus'] as int : null,
      temperatureSamplesCount: map['temperatureSamplesCount'] != null ? map['temperatureSamplesCount'] as int : null,
      humiditySensorStatus: map['humiditySensorStatus'] != null ? map['humiditySensorStatus'] as int : null,
      humiditySamplesCount: map['humiditySamplesCount'] != null ? map['humiditySamplesCount'] as int : null,
      pressureSensorStatus: map['pressureSensorStatus'] != null ? map['pressureSensorStatus'] as int : null,
      pressureSamplesCount: map['pressureSamplesCount'] != null ? map['pressureSamplesCount'] as int : null,
      lightSensorStatus: map['lightSensorStatus'] != null ? map['lightSensorStatus'] as int : null,
      lightSamplesCount: map['lightSamplesCount'] != null ? map['lightSamplesCount'] as int : null,
      inertialSensorStatus: map['inertialSensorStatus'] != null ? map['inertialSensorStatus'] as int : null,
      inertialSamplesCount: map['inertialSamplesCount'] != null ? map['inertialSamplesCount'] as int : null,
      lastTemp: map['lastSampledTemperature'] != null ? map['lastSampledTemperature'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdvInfo.fromJson(String source) => AdvInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AdvInfo(advInfoBytes: $advInfoBytes, type: $type, batteryLevel: $batteryLevel, sensorStatus: $sensorStatus, alarmStatus: $alarmStatus, temperatureSensorStatus: $temperatureSensorStatus, temperatureSamplesCount: $temperatureSamplesCount, humiditySensorStatus: $humiditySensorStatus, humiditySamplesCount: $humiditySamplesCount, pressureSensorStatus: $pressureSensorStatus, pressureSamplesCount: $pressureSamplesCount, lightSensorStatus: $lightSensorStatus, lightSamplesCount: $lightSamplesCount, inertialSensorStatus: $inertialSensorStatus, inertialSamplesCount: $inertialSamplesCount, lastTemp: $lastTemp)';
  }

  @override
  bool operator ==(covariant AdvInfo other) {
    if (identical(this, other)) return true;

    return other.advInfoBytes == advInfoBytes &&
        other.type == type &&
        other.batteryLevel == batteryLevel &&
        other.sensorStatus == sensorStatus &&
        other.alarmStatus == alarmStatus &&
        other.temperatureSensorStatus == temperatureSensorStatus &&
        other.temperatureSamplesCount == temperatureSamplesCount &&
        other.humiditySensorStatus == humiditySensorStatus &&
        other.humiditySamplesCount == humiditySamplesCount &&
        other.pressureSensorStatus == pressureSensorStatus &&
        other.pressureSamplesCount == pressureSamplesCount &&
        other.lightSensorStatus == lightSensorStatus &&
        other.lightSamplesCount == lightSamplesCount &&
        other.inertialSensorStatus == inertialSensorStatus &&
        other.inertialSamplesCount == inertialSamplesCount &&
        other.lastTemp == lastTemp;
  }

  @override
  int get hashCode {
    return advInfoBytes.hashCode ^
        type.hashCode ^
        batteryLevel.hashCode ^
        sensorStatus.hashCode ^
        alarmStatus.hashCode ^
        temperatureSensorStatus.hashCode ^
        temperatureSamplesCount.hashCode ^
        humiditySensorStatus.hashCode ^
        humiditySamplesCount.hashCode ^
        pressureSensorStatus.hashCode ^
        pressureSamplesCount.hashCode ^
        lightSensorStatus.hashCode ^
        lightSamplesCount.hashCode ^
        inertialSensorStatus.hashCode ^
        inertialSamplesCount.hashCode ^
        lastTemp.hashCode;
  }
}
