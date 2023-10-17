import 'package:device_apps/device_apps.dart';
import 'package:either_option/either_option.dart';
import 'package:flutter/services.dart';
import 'package:zsdemo_app/services/bluetooth_service.dart';
import 'package:zsdemo_app/services/zsdemo_api_service.dart';
import 'package:zsdemo_app/states/base_state.dart';

import '../../models/error.dart';

class ZSFinderState extends BaseState with BluetoothServiceMixin, ZSDemoAPIServiceMixin {
  ZSFinderState() : super(busy: true) {
    readAIDLVersionAndRevision();
  }

  int _aidlVersion = -1;
  int _aidlRevision = -1;
  String _aidlFileContents = "";
  final String versionKeyword = 'const int VERSION = ';
  final String revisionKeyword = 'const int REVISION = ';
  final String aidlFilePath = 'android/app/src/main/aidl/com/zebra/zsfinder/IZebraSensorService.aidl';
  final Stream<ApplicationEvent> _events = DeviceApps.listenToAppsChanges().where((ApplicationEvent event) {
    return event.event == ApplicationEventType.uninstalled && event.packageName == 'com.zebra.zsfinder';
  });

  bool _installed = false;
  bool _permissionsGranted = false;
  bool _serviceBound = false;
  bool _bindingFailure = false;
  bool _clientCompatible = false;
  bool _clientHasAuthToken = false;

  bool get installed => _installed;
  bool get permissionsGranted => _permissionsGranted;
  bool get serviceBound => _serviceBound;
  bool get bindingFailure => _bindingFailure;
  bool get clientCompatible => _clientCompatible;
  int get aidlVersion => _aidlVersion;
  int get aidlRevision => _aidlRevision;
  Stream<ApplicationEvent> get events => _events;

  set installed(bool value) {
    _installed = value;
    notifyListeners();
  }

  set permissionsGranted(bool value) {
    _permissionsGranted = value;
    notifyListeners();
  }

  set clientCompatible(bool value) {
    _clientCompatible = value;
    notifyListeners();
  }

  set serviceBound(bool value) {
    _serviceBound = value;
    notifyListeners();
  }

  set bindingFailure(bool value) {
    _bindingFailure = value;
    notifyListeners();
  }

  set clientHasAuthToken(bool value) {
    _clientHasAuthToken = value;
    notifyListeners();
  }

  Future<int> parseAIDLValue(String fileContents, String keyword) async {
    int startIndex = fileContents.indexOf(keyword) + keyword.length;
    int index = startIndex;
    while (fileContents[index] != ';') {
      index++;
    }
    return int.parse(fileContents.substring(startIndex, index));
  }

  Future<void> readAIDLVersionAndRevision() async {
    if (_aidlFileContents.isEmpty) {
      _aidlFileContents = await rootBundle.loadString(aidlFilePath);
    }
    _aidlVersion = await parseAIDLValue(_aidlFileContents, versionKeyword);
    _aidlRevision = await parseAIDLValue(_aidlFileContents, revisionKeyword);
  }

  Future<void> checkZSFinderInstallation() async {
    if (_installed == false) {
      _installed = await DeviceApps.isAppInstalled("com.zebra.zsfinder");
    }
    if (_installed == true) {
      installed = _installed;
      await bindToService();
    }
    busy = false;
  }

  Future<void> checkIsClientCompatible() async {
    busy = true;
    if (_installed) {
      Either<BluetoothUserError, bool?> result = await bluetoothService.isClientCompatible(_aidlVersion, _aidlRevision);
      result.fold((e) {
        clientCompatible = false;
      }, (retVal) {
        clientCompatible = retVal!;
      });
    }
    busy = false;
  }

  Future<void> bindToService() async {
    busy = true;
    _bindingFailure = false;
    if (_installed) {
      final result = await bluetoothService.bindToService();
      result.fold((error) {
        bindingFailure = true;
      }, (bound) {
        if (bound == null || !bound) {
          bindingFailure = true;
          _serviceBound = false;
        }
      });

      if (!bindingFailure) {
        while (await bluetoothService.isServiceBound() == false) {
          await Future.delayed(const Duration(seconds: 1));
        }
        _serviceBound = true;
      }
    }
    busy = false;
  }

  Future<void> checkZSFinderPermissions() async {
    busy = true;
    if (_installed) {
      if (!_serviceBound) {
        await bindToService();
      }
      Either<BluetoothUserError, bool?> result = await bluetoothService.areZSFinderPermissionsGranted();
      result.fold((e) {
        busy = false;
        _permissionsGranted = false;
        serviceBound = false;
        bindingFailure = true;
      }, (retVal) {
        busy = false;
        _permissionsGranted = retVal!;
        if (_permissionsGranted == true) {
          bindingFailure = false;
          permissionsGranted = _permissionsGranted;
        }
      });
    }
    busy = false;
  }

  Future<void> setClientAuthKey() async {
    Either<BluetoothUserError, bool?> result = await bluetoothService
        .clientHasAuthToken(); //TODO note, the AIDL call does not verify VALID configuration, only that something is stored is prefs...
    result.fold((e) {
      _clientHasAuthToken = false;
    }, (retVal) async {
      _clientHasAuthToken = retVal!;

      if (!_clientHasAuthToken) {
        final token = await apiService.getAuthenticationToken();
        token.fold(
            (error) => {},
            (token) async => {await bluetoothService.setClientAuthToken(token)});
      }
    });
  }
}
