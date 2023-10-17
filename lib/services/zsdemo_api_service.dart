import 'package:dio/dio.dart';
import 'package:either_option/either_option.dart';
import 'package:flutter/foundation.dart';
import 'package:zsdemo_app/common/constants/constants.dart';
import 'package:zsdemo_app/common/dio/dio_error.dart';
import 'package:zsdemo_app/common/dio/dio_mixin.dart';
import 'package:zsdemo_app/common/enums/enums.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/alarms.dart';
import 'package:zsdemo_app/models/associate_sensor.dart';
import 'package:zsdemo_app/models/error.dart';
import 'package:zsdemo_app/models/events.dart';
import 'package:zsdemo_app/models/page_response.dart';
import 'package:zsdemo_app/models/sensor.dart';
import 'package:zsdemo_app/models/task.dart';

abstract class IZSDemoAPIService {
  //Authentication
  Future<Either<ZSAPIError, String>> getAuthenticationToken();
  //SensorService
  Future<Either<ZSAPIError, ListSensorsResponse>> getSensors();
  Future<Either<ZSAPIError, Sensor?>> getSensorInfo(String serialNumber);
  Future<Option<ZSAPIError>> enrollSensor(String serialNumber);
  Future<Option<ZSAPIError>> unEnrollSensor(String serialNumber);
  //TaskService
  Future<Either<ZSAPIError, ListTasksResponse>> getTasks();
  Future<Either<ZSAPIError, String>> createTask(TaskDetails taskDetails);
  Future<Either<ZSAPIError, Task>> getTask(String taskId);
  Future<Option<ZSAPIError>> deleteTask(String taskId);
  Future<Either<ZSAPIError, ListAlarmsResponse>> getTaskAlarms({
    required String taskId,
    required int pageNumber,
    required int pageSize,
    required SortOrder order,
  });
  Future<Either<ZSAPIError, AssociateSensorResponse>> associateSensorsToTask(List<Sensor> sensors, String taskId);
  Future<Either<ZSAPIError, Task>> stopTask(String taskId);
  Future<Either<ZSAPIError, ListSensorsResponse>> getTaskAssociatedSensors(String taskId);
  Future<Either<ZSAPIError, ListEventsResponse>> getTaskEvents(String taskId, int limit, [String? cursor]);
}

mixin ZSDemoAPIServiceMixin {
  late ZSDemoAPIService apiService;
}

class ZSDemoAPIService with ZsDioMixin implements IZSDemoAPIService {
  @override
  Future<Either<ZSAPIError, String>> getAuthenticationToken() async {
    try {
      final Response response = await dio.post(authTokenEndpoint);
      if (response.statusCode == 200) {
        return Right(response.data['token']);
      }
      return Left(ZSAPIError(code: '400', message: Loco.current.unknownError));
    } on DioException catch (e) {
      debugPrint(e.toString());
      return Left(e.handleError());
    }
  }

  @override
  Future<Either<ZSAPIError, ListSensorsResponse>> getSensors() async {
    try {
      final Response response = await dio.get(getSensorsEndpoint);
      if (response.statusCode == 200) {
        final PageResponse pageResponse = PageResponse.fromMap(response.data['page_response']);
        final resList = response.data['sensors'] as List;
        if (resList.isEmpty) {
          return Right(ListSensorsResponse([], pageResponse));
        }
        final List<Sensor> sensors = resList.map((s) => Sensor.fromMap(s)).toList();

        return Right(ListSensorsResponse(sensors, pageResponse));
      }
      return Left(ZSAPIError(code: '400', message: Loco.current.unknownError));
    } on DioException catch (e) {
      debugPrint(e.toString());
      return Left(e.handleError());
    }
  }

  @override
  Future<Either<ZSAPIError, Sensor?>> getSensorInfo(String serialNumber) async {
    try {
      Map<String, String>? queryParameters = {
        'page': '0',
        'size': '2500',
        'text_filter': serialNumber,
      };
      final Response response = await dio.get(getSensorsEndpoint, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        final sensors = response.data['sensors'] as List;
        if (sensors.isEmpty) {
          return Right(null);
        } else {
          // THis will be fixed in the model class PR is done
          final Sensor sensor = Sensor.fromMap(sensors.first);
          return Right(sensor);
        }
      }
      return Left(ZSAPIError(code: '400', message: Loco.current.unknownError));
    } on DioException catch (e) {
      debugPrint(e.toString());
      return Left(e.handleError());
    } catch (e) {
      debugPrint(e.toString());
      return Left(ZSAPIError(code: '400', message: Loco.current.unknownError, info: e.toString()));
    }
  }

  @override
  Future<Option<ZSAPIError>> enrollSensor(String serialNumber) async {
    try {
      final Map<String, String> bodyData = {'serial_number': serialNumber};
      final Response response = await dio.post(sensorEnrollmentEndpoint, data: bodyData);
      if (response.statusCode == 200) {
        return None();
      }
      return Some(ZSAPIError(code: '400', message: Loco.current.unknownError));
    } on DioException catch (e) {
      debugPrint(e.toString());
      return Some(e.handleError());
    }
  }

  @override
  Future<Option<ZSAPIError>> unEnrollSensor(String serialNumber) async {
    try {
      final Response response = await dio.delete('$sensorEnrollmentEndpoint/$serialNumber');
      if (response.statusCode == 200) {
        return None();
      }
      return Some(ZSAPIError(code: '400', message: Loco.current.unknownError));
    } on DioException catch (e) {
      debugPrint(e.toString());
      return Some(e.handleError());
    }
  }

  @override
  Future<Either<ZSAPIError, ListTasksResponse>> getTasks() async {
    try {
      Map<String, String>? queryParameters = {
        'page': '0',
        'size': '2500',
      };
      final Response response = await dio.get(taskEndpoint, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        final PageResponse pageResponse = PageResponse.fromMap(response.data['page_response']);
        final resList = response.data['tasks'] as List;
        if (resList.isEmpty) {
          return Right(ListTasksResponse([], pageResponse));
        }
        final List<Task> tasks = resList.map((t) => Task.fromMap(t)).toList();

        return Right(ListTasksResponse(tasks, pageResponse));
      }
      return Left(ZSAPIError(code: '400', message: Loco.current.unknownError));
    } on DioException catch (e) {
      debugPrint(e.toString());
      return Left(e.handleError());
    }
  }

  @override
  Future<Either<ZSAPIError, String>> createTask(TaskDetails taskDetails) async {
    try {
      final Map<String, dynamic> requestData = {
        'task_from_details': {
          'task_details': taskDetails.toMap(),
        }
      };
      final Response response = await dio.post(taskEndpoint, data: requestData);
      if (response.statusCode == 200) {
        return Right(response.data['id']);
      }
      return Left(ZSAPIError(code: '400', message: Loco.current.unknownError));
    } on DioException catch (e) {
      debugPrint(e.toString());
      return Left(e.handleError());
    }
  }

  @override
  Future<Either<ZSAPIError, Task>> getTask(String taskId) async {
    try {
      final Response response = await dio.get('$taskEndpoint/$taskId');
      if (response.statusCode == 200) {
        return Right(Task.fromMap(response.data['task']));
      }
      return Left(ZSAPIError(code: '400', message: Loco.current.unknownError));
    } on DioException catch (e) {
      debugPrint(e.toString());
      return Left(e.handleError());
    }
  }

  @override
  Future<Option<ZSAPIError>> deleteTask(String taskId) async {
    try {
      final Response response = await dio.delete('$taskEndpoint/$taskId');
      if (response.statusCode == 200) {
        return None();
      }
      return Some(ZSAPIError(code: '400', message: Loco.current.unknownError));
    } on DioException catch (e) {
      debugPrint(e.toString());
      return Some(e.handleError());
    }
  }

  @override
  Future<Either<ZSAPIError, ListAlarmsResponse>> getTaskAlarms({
    required String taskId,
    required int pageNumber,
    required int pageSize,
    required SortOrder order,
  }) async {
    try {
      Map<String, String>? queryParameters = {
        'page.page': '$pageNumber',
        'page.size': '$pageSize',
        'sort_order': order.value,
      };
      final Response response = await dio.get('$taskEndpoint/$taskId/alarms', queryParameters: queryParameters);
      if (response.statusCode == 200) {
        final PageResponse pageResponse = PageResponse.fromMap(response.data['page_response']);
        final resList = response.data['sensors_alarms'] as List;
        if (resList.isEmpty) {
          return Right(ListAlarmsResponse([], pageResponse));
        }
        final List<SensorAlarm> sensorAlarms = resList.map((a) => SensorAlarm.fromMap(a)).toList();
        return Right(ListAlarmsResponse(sensorAlarms, pageResponse));
      }
      return Left(ZSAPIError(code: '400', message: Loco.current.unknownError));
    } on DioException catch (e) {
      debugPrint(e.toString());
      return Left(e.handleError());
    }
  }

  @override
  Future<Either<ZSAPIError, AssociateSensorResponse>> associateSensorsToTask(
      List<Sensor> sensors, String taskId) async {
    try {
      final List<String> sensorsIds = sensors.map((s) => s.id!).toList();
      final Map<String, dynamic> requestData = {'sensor_ids': sensorsIds};
      final Response response = await dio.post('$taskEndpoint/$taskId/sensors', data: requestData);
      if (response.statusCode == 200) {
        return Right(AssociateSensorResponse.fromMap(response.data));
      }
      return Left(ZSAPIError(code: '400', message: Loco.current.unknownError));
    } on DioException catch (e) {
      debugPrint(e.toString());
      return Left(e.handleError());
    }
  }

  @override
  Future<Either<ZSAPIError, Task>> stopTask(String taskId) async {
    try {
      final Response response = await dio.post('$taskEndpoint/$taskId/stop');
      if (response.statusCode == 200) {
        return Right(Task.fromMap(response.data['task']));
      }
      return Left(ZSAPIError(code: '400', message: Loco.current.unknownError));
    } on DioException catch (e) {
      debugPrint(e.toString());
      return Left(e.handleError());
    }
  }

  @override
  Future<Either<ZSAPIError, ListSensorsResponse>> getTaskAssociatedSensors(String taskId) async {
    try {
      Map<String, String>? queryParameters = {
        'page': '0',
        'size': '2500',
        'task_id': taskId,
      };
      final Response response = await dio.get(getSensorsEndpoint, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        final PageResponse pageResponse = PageResponse.fromMap(response.data['page_response']);
        final resList = response.data['sensors'] as List;
        if (resList.isEmpty) {
          return Right(ListSensorsResponse([], pageResponse));
        }
        final List<Sensor> sensors = resList.map((s) => Sensor.fromMap(s)).toList();

        return Right(ListSensorsResponse(sensors, pageResponse));
      }
      return Left(ZSAPIError(code: '400', message: Loco.current.unknownError));
    } on DioException catch (e) {
      debugPrint(e.toString());
      return Left(e.handleError());
    }
  }

  @override
  Future<Either<ZSAPIError, ListEventsResponse>> getTaskEvents(String taskId, int limit, [String? cursor]) async {
    try {
      Map<String, String>? queryParameters = {
        'limit': '$limit',
      };
      if (cursor != null) {
        queryParameters['cursor'] = cursor;
      }
      final Response response = await dio.get('$datalakeAPI/$taskId/log', queryParameters: queryParameters);
      if (response.statusCode == 200) {
        return Right(await compute(ListEventsResponse.parseEvents, response.data));
      }
      return Left(ZSAPIError(code: '400', message: Loco.current.unknownError));
    } on DioException catch (e) {
      debugPrint(e.toString());
      return Left(e.handleError());
    }
  }
}
