import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/extensions/string.dart';
import 'package:zsdemo_app/generated/intl/messages_en.dart';
import 'package:zsdemo_app/generated/l10n.dart';

abstract class UserLevelError {
  const UserLevelError();
  RpcErrorData toErrorData();
}

class BluetoothUserError extends UserLevelError {
  final String description;
  const BluetoothUserError({required this.description}) : super();

  @override
  RpcErrorData toErrorData() {
    return RpcErrorData(
      errorTitle: title(),
      errorDescription: description,
    );
  }

  String title() {
    return '';
  }

  @override
  String toString() {
    return description;
  }
}

class SensorAvailabilityRegisteredError extends BluetoothUserError {
  const SensorAvailabilityRegisteredError() : super(description: '');

  @override
  RpcErrorData toErrorData() {
    return RpcErrorData(
      errorTitle: Loco.current.addSensorsRegisteredTitle,
      errorDescription: Loco.current.addSensorsRegisteredDescription,
    );
  }
}

class SensorAvailabilityUnavailableError extends SensorAvailabilityRegisteredError {
  const SensorAvailabilityUnavailableError() : super();

  @override
  RpcErrorData toErrorData() {
    return RpcErrorData(
      errorTitle: Loco.current.addSensorsUnavailableTitle,
      errorDescription: Loco.current.addSensorsUnavailableTitle,
    );
  }
}

class SensorLowBatteryError extends BluetoothUserError {
  const SensorLowBatteryError() : super(description: '');

  @override
  RpcErrorData toErrorData() {
    return RpcErrorData(
      errorTitle: Loco.current.addSensorsRegisteredLowBatteryTitle,
      errorDescription: Loco.current.addSensorsRegisteredLowBatteryDescription,
    );
  }
}

class GenericUserError extends UserLevelError {
  final String _errorDescription;
  final String? _errorTitle;
  const GenericUserError({
    required String message,
    String? title,
  })  : _errorDescription = message,
        _errorTitle = title,
        super();

  String title(BuildContext context) {
    return _errorTitle ?? '';
  }

  @override
  String toString() {
    return _errorDescription;
  }

  @override
  RpcErrorData toErrorData() {
    return RpcErrorData(
      errorTitle: Loco.current.unknownError,
      errorDescription: _errorDescription,
    );
  }
}

class GenericException implements Exception {
  String? message;
  String? type;
  final int code;
  final dynamic raw;

  GenericException(this.code, {this.raw, String? error}) {
    if (raw != null) {
      type = getErrorFromRaw(raw).toString();
      message = (raw["Message"] ?? messages)['error_description'] ?? (raw["Messages"] ?? messages)[type];
    } else {
      message = error;
    }
  }

  GenericException.general(this.message)
      : code = -1,
        raw = null;

  String? errorMessage() {
    return message;
  }

  @override
  String toString() {
    if (message == null) return "GenericException: ${jsonEncode(raw)}";
    return "GenericException: $message";
  }

  static GenericException generate(int code, dynamic raw) {
    final error = raw != null ? getErrorFromRaw(raw) : null;
    if (error is List<dynamic>) {
      final missingReg = RegExp(r"^error\.missing.(\w+)$");
      final invalidReg = RegExp(r"^error\.invalid.(\w+)$");

      final errors = error.map<GenericException>((e) {
        if (missingReg.hasMatch(e)) {
          return MissingRequestError(code, raw: raw, error: e);
        }
        if (invalidReg.hasMatch(e)) {
          return InvalidRequestError(code, raw: raw, error: e);
        }
        return GenericException.general(e);
      }).toList();

      if (errors.length == 1) {
        return errors.first;
      }

      return MultipleErrors(errors);
    } else {
      switch (error) {
        case 'error.invalid_api_key':
          return AuthenticationError(code, raw: raw);
        case 'error.missing_api_key':
          return PermissionError(code, raw: raw);
        case 'invalid_grant':
          return InvalidGrantError(code, raw: raw);
        default:
          return APIError(code, raw: raw);
      }
    }
  }
}

class InvalidGrantError extends GenericException {
  InvalidGrantError(int code, {dynamic raw, String? error}) : super(code, raw: raw, error: error);
}

class APIError extends GenericException {
  APIError(int code, {dynamic raw, String? error}) : super(code, raw: raw, error: error);
}

class ZSAPIError extends UserLevelError {
  final String? code;
  final String? message;
  final String? info;
  ZSAPIError({this.code, this.message, this.info}) : super();

  @override
  RpcErrorData toErrorData() {
    return RpcErrorData(
      errorTitle: codeToString(),
      errorDescription: getDescription(),
    );
  }

  String getDescription() {
    if (message == null && info == null) {
      return '';
    }
    if (message == null) {
      return info!.toFirstLetterCapital();
    }
    if (info == null) {
      return message!.toFirstLetterCapital();
    }
    if (info!.contains('No results for TaskId')) {
      return Loco.current.noEventsFoundMessage;
    }
    return '${message!.toFirstLetterCapital()}. ${info!.toFirstLetterCapital()}';
  }

  String codeToString() {
    if (code == null) return Loco.current.backendError;
    if (info != null && info!.contains('No results for TaskId')) return Loco.current.noEventsFoundTitle;
    final StatusCodes codes = toStatusCodes(code!);
    switch (codes) {
      case StatusCodes.OK:
        return Loco.current.apiErrorOk;
      case StatusCodes.CANCELLED:
        return Loco.current.apiErrorCancelled;
      case StatusCodes.UNKNOWN:
        return Loco.current.error;
      case StatusCodes.INVALID_ARGUMENT:
        return Loco.current.apiErrorInvalidArgument;
      case StatusCodes.DEADLINE_EXCEEDED:
        return Loco.current.apiErrorDeadlineExceeded;
      case StatusCodes.NOT_FOUND:
        return Loco.current.apiErrorNotFound;
      case StatusCodes.ALREADY_EXISTS:
        return Loco.current.apiErrorAlreadyExists;
      case StatusCodes.PERMISSION_DENIED:
        return Loco.current.apiErrorPermission;
      case StatusCodes.RESOURCE_EXHAUSTED:
        return Loco.current.apiErrorResourceExhausted;
      case StatusCodes.FAILED_PRECONDITION:
        return Loco.current.apiErrorFailedPrecondition;
      case StatusCodes.ABORTED:
        return Loco.current.apiErrorAborted;
      case StatusCodes.OUT_OF_RANGE:
        return Loco.current.apiErrorOutOfRange;
      case StatusCodes.UNIMPLEMENTED:
        return Loco.current.apiErrorUnimplemented;
      case StatusCodes.INTERNAL:
        return Loco.current.apiErrorInternal;
      case StatusCodes.UNAVAILABLE:
        return Loco.current.apiErrorUnavailable;
      case StatusCodes.DATA_LOSS:
        return Loco.current.apiErrorDataLoss;
      case StatusCodes.UNAUTHENTICATED:
        return Loco.current.apiErrorUnauthenticated;
      default:
        return code ?? Loco.current.error;
    }
  }
}

class NotSupportedError extends GenericException {
  NotSupportedError(int code, {dynamic raw, String? error}) : super(code, raw: raw, error: error);
}

class PermissionError extends GenericException {
  PermissionError(int code, {dynamic raw, String? error}) : super(code, raw: raw, error: error);
}

class AuthenticationError extends GenericException {
  AuthenticationError(int code, {dynamic raw, String? error}) : super(code, raw: raw, error: error);
}

class InvalidRequestError extends GenericException {
  InvalidRequestError(int code, {dynamic raw, String? error}) : super(code, raw: raw, error: error);
}

class MultipleErrors extends GenericException {
  final List<GenericException> errors;

  MultipleErrors(this.errors) : super(0);
}

class MissingRequestError extends GenericException {
  MissingRequestError(int code, {dynamic raw, String? error}) : super(code, raw: raw, error: error);
}

dynamic getErrorFromRaw(dynamic raw) {
  if (raw == null) return Loco.current.unknownError;
  if (raw is! Map) return Loco.current.unknownError;
  if (raw["error"] != null) return raw["error"];
  if (raw["Message"] != null && raw["Message"]["error"] != null) return raw["Message"]["error"];
  if (raw["fault"] != null && raw["fault"]["errorcode"] != null) return raw["fault"]["errorcode"];
  return Loco.current.unknownError;
}

class CouldNotRefreshTokenError extends UserLevelError {
  final String? description;
  const CouldNotRefreshTokenError({this.description}) : super();

  @override
  RpcErrorData toErrorData() {
    return RpcErrorData(
      errorTitle: Loco.current.invalidAuthTitle,
      errorDescription: Loco.current.invalidAuthDescription,
    );
  }

  @override
  String toString() {
    return Loco.current.authError;
  }
}

class QuotaLimitUserError extends UserLevelError {
  final String _errorDescription;
  const QuotaLimitUserError({required String message})
      : _errorDescription = message,
        super();
  @override
  RpcErrorData toErrorData() {
    return RpcErrorData(
      errorTitle: Loco.current.invalidAuthTitle,
      errorDescription: Loco.current.invalidAuthDescription,
    );
  }

  @override
  String toString() {
    return _errorDescription;
  }
}

class RpcErrorData {
  final String errorTitle;
  final String errorDescription;
  const RpcErrorData({
    required this.errorTitle,
    required this.errorDescription,
  });
}

enum StatusCodes {
  OK,
  CANCELLED,
  UNKNOWN,
  INVALID_ARGUMENT,
  DEADLINE_EXCEEDED,
  NOT_FOUND,
  ALREADY_EXISTS,
  PERMISSION_DENIED,
  RESOURCE_EXHAUSTED,
  FAILED_PRECONDITION,
  ABORTED,
  OUT_OF_RANGE,
  UNIMPLEMENTED,
  INTERNAL,
  UNAVAILABLE,
  DATA_LOSS,
  UNAUTHENTICATED,
}

StatusCodes toStatusCodes(String code) {
  final int _code = int.parse(code);
  try {
    return StatusCodes.values[_code];
  } catch (e) {
    return StatusCodes.UNKNOWN;
  }
}
