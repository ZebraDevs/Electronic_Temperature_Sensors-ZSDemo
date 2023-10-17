import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:zsdemo_app/models/error.dart';
import 'package:zsdemo_app/states/base_state.dart';

mixin BaseHandlerListMixin<T, C extends List<T>> on BaseHandlerState<C> {
  @override
  bool get isDataEmpty => data.isEmpty;
}
mixin BaseHandlerSimpleListMixin<T> on BaseHandlerListMixin<T, List<T>> {
  @override
  get initialData => <T>[];
}

typedef BuildError = RpcErrorData Function(BuildContext);
mixin BaseHandlerState<T> on BaseStateMixin {
  UserLevelError? _error;

  T? _data;

  T get data => _data ?? initialData;

  set data(T? data) {
    _data = data;
    notifyListeners();
  }

  bool get isDataEmpty;

  T get initialData;

  UserLevelError? get error => _error;

  set error(UserLevelError? error) {
    _error = error;
    if (error != null) _oldError = error;
  }

  RpcErrorData defaultData(BuildContext context) {
    return const RpcErrorData(errorTitle: '', errorDescription: '');
  }

  UserLevelError? _oldError;

  UserLevelError? get oldError => _oldError;

  BuildError get buildOldError => (context) => oldError?.toErrorData() ?? defaultData(context);

  bool get hasError => error != null;

  Future<void> whileRefreshing(Future<void> Function() callback) async {
    await callback();
    notifyListeners();
  }

  Future<void> busyRetry() async {
    return whileBusy(retry);
  }

  Future<void> whileFetching(Future<void> Function() callback) {
    // load by default on fetch
    return whileBusy(callback);
  }

  Future<void> busyFetch() => whileBusy(fetch);

  Future<void> refresh() {
    // fetch by default
    return fetch();
  }

  Future<void> fetch() async {
    this.data = await handleError(fetchData);
  }

  void didFiltersChange() {}

  Future<T?> handleError(Future<Either<UserLevelError, T>> Function() callback) async {
    this.error = null;
    final result = await callback();
    return result.fold((error) {
      this.error = error;
      return null;
    }, (value) {
      return value;
    });
  }

  Future<Either<UserLevelError, T>> fetchData();

  Future<void> retry() {
    // fetch by default
    return fetch();
  }
}
