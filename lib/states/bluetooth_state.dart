// import 'package:envirovuemobilesdk/envirovuemobilesdk.dart';
import 'package:zsdemo_app/services/bluetooth_service.dart';
import 'package:zsdemo_app/states/base_state.dart';
import 'package:zsdemo_app/states/mixins/location_mixin.dart';

abstract class BluetoothState<T> extends BaseState with BluetoothServiceMixin, LocationStateMixin {
  T get initialValue;
  T? _bluetoothConnection;

  T get bluetoothConnection => _bluetoothConnection ?? initialValue;

  set bluetoothConnection(T connection) {
    _bluetoothConnection = connection;
    notifyListeners();
  }

  bool get hasStarted {
    return bluetoothConnection != initialValue;
  }

  // Future<Option<UserLevelError>> connectWithoutBleSensor(Sensor sensor) {
  //   BluetoothLeSensor btSensor = BluetoothLeSensor(address: getSensorMacAddress(sensor.macAddress));
  //   return bluetoothService.connectToSensor(btSensor);
  // }

  // Future<Either<UserLevelError, SensorSeenResponse>> sdkSyncStatusResponse(BluetoothLeSensor bleSensor) async {
  //   return sensorSeen(bleSensor);
  // }
}
