import 'package:dio/dio.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/error.dart';

extension DioErrorExt on DioException {
  ZSAPIError handleError() {
    if (response != null) {
      if (response?.data['error'] != null) {
        return ZSAPIError(
          code: response?.data['error']['code'],
          message: response?.data['error']['message'],
          info: response?.data['error']['info'],
        );
      }
      if (response?.data['errorResponse'] != null) {
        return ZSAPIError(
          code: response?.data['errorResponse']['code'],
          message: response?.data['errorResponse']['message'],
          info: response?.data['errorResponse']['info'],
        );
      }
      if (response?.data['fault'] != null) {
        return ZSAPIError(
          message: response?.data['fault']['faultstring'],
          info: response?.data['fault']['detail']['errorcode'],
        );
      }
      return ZSAPIError(
        code: response?.data['code'].toString(),
        message: response?.data['message'],
        info: response?.data['info'],
      );
    }
    if (error.toString().contains('SocketException')) {
      return ZSAPIError(code: '400', message: Loco.current.errorNoInternetConnection);
    }
    if (type == DioExceptionType.connectionTimeout) {
      return ZSAPIError(code: '408', message: Loco.current.errorTimeout);
    }
    if (type == DioExceptionType.connectionError) {
      return ZSAPIError(code: '500', message: Loco.current.errorServerConneciton);
    }
    if (message != null && message != '') {
      return ZSAPIError(code: '400', message: message);
    }
    return ZSAPIError(code: '400', message: error.toString());
  }

  ZSAPIError handleEnrollError() {
    if (response?.data['message'] == 'sensor already has pending enrollment') {
      return ZSAPIError(
        code: response?.data['code'].toString(),
        message:
            'The Sensor is at pending enrollment state. Please make sure ZSFinder "sees" it and Pair with it in order to fully enrol it.',
        info: response?.data['info'],
      );
    } else if (response?.data['message'] == 'sensor already enrolled on tenant') {
      return ZSAPIError(
        code: response?.data['code'].toString(),
        message: 'The Sensor is already enrolled on another tenant.',
        info: response?.data['info'],
      );
    }
    return ZSAPIError(code: '400', message: error.toString());
  }
}
