import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

mixin BaseStateMixin on ChangeNotifier {
  bool _disposed = false;
  bool get disposed => _disposed;
  bool _busy = false;
  bool get busy => _busy;
  set busy(bool value) {
    bool diff = _busy != value;
    _busy = value;
    if (!_disposed && diff) {
      notifyListeners();
    }
  }

  Future<T> whileBusy<T>(Future<T> Function() callback) {
    busy = true;
    return callback().then((_) {
      busy = false;
      return _;
    }).catchError((e) {
      busy = false;
      return e;
    });
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }
}

class BaseState extends ChangeNotifier with BaseStateMixin {
  BaseState({bool busy = false}) {
    _busy = busy;
  }
}
