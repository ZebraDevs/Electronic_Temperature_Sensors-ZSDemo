import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/enums/enums.dart';
import 'package:zsdemo_app/common/utils/date.dart';
import 'package:zsdemo_app/common/utils/files.dart';
import 'package:zsdemo_app/models/models.dart';
import 'package:zsdemo_app/services/zsdemo_api_service.dart';
import 'package:zsdemo_app/states/base_state.dart';

class TaskEventState extends BaseState with ZSDemoAPIServiceMixin {
  final Task task;
  TaskEventState(this.task) : super(busy: false);

  List<EventsData> _events = [];
  List<EventsData> get events => _events;
  set events(List<EventsData> events) {
    _events = events;
    notifyListeners();
  }

  List<EventsData> _allEvents = [];

  String? _cursor;

  int get batchSize => 100;

  Future<void> loadData() async {
    if (taskEventState == ResponseState.isLoading || taskEventState == ResponseState.isLoadingMore || _cursor == null) {
      return;
    }
    await getTaskEvents();
  }

  Future<void> refreshData() async {
    events = [];
    _cursor = null;
    getTaskEvents();
  }

  ZSAPIError? _error;
  ZSAPIError? get error => _error;
  set error(ZSAPIError? error) {
    _error = error;
    notifyListeners();
  }

  ResponseState _taskEventState = ResponseState.isLoading;
  ResponseState get taskEventState => _taskEventState;
  ResponseState prevState = ResponseState.isLoading;
  set taskEventState(ResponseState value) {
    if (value == _taskEventState) {
      return;
    }
    prevState = _taskEventState;
    _taskEventState = value;
    notifyListeners();
  }

  Future<void> getTaskEvents() async {
    if (task.id == null) {
      return;
    }
    taskEventState = _cursor == null ? ResponseState.isLoading : ResponseState.isLoadingMore;
    final Either<ZSAPIError, ListEventsResponse> res = await apiService.getTaskEvents(task.id!, batchSize, _cursor);
    res.fold((ZSAPIError error) {
      taskEventState = ResponseState.error;
      _error = error;
    }, (response) {
      events = [...events, ...response.events];
      _cursor = response.nextCursor;
      taskEventState = ResponseState.isDataFound;
    });
  }

  Future<void> getAllEvents() async {
    if (task.id == null) {
      busy = false;
      return;
    }
    _allEvents = List.of(events);
    while (_cursor != null) {
      final Either<ZSAPIError, ListEventsResponse> res = await apiService.getTaskEvents(task.id!, 1000, _cursor);
      res.fold((ZSAPIError error) {
        busy = false;
        taskEventState = ResponseState.error;
        _error = error;
      }, (response) {
        _allEvents = [..._allEvents, ...response.events];
        _cursor = response.nextCursor;
      });
    }
    events = List.of(_allEvents);
  }

  Future<Either<GenericException, String?>> generateCsv() async {
    try {
      busy = true;
      await getAllEvents();
      final List<String> header = [
        'event.timestamp',
        'event.data.id',
        'analytics.recordedTimestamp',
        'analytics.meta.data.task_alarm',
        'decode.temperature.sample',
        'decode.temperature.format',
        'decode.temperature.alert',
      ];
      final _allCSVEvents = _allEvents.map((EventsData item) {
        return [
          csvFormat.format(item.event!.timestamp!.toLocal()),
          item.event!.data!.id,
          csvFormat.format(item.analytics!.recordedTimestamp!.toLocal()),
          item.analytics!.taskAlarm.toString(),
          item.event?.data?.value.toString(),
          item.decode?.temperature?.format,
          item.decode?.temperature?.alert,
        ];
      }).toList();
      _allCSVEvents.insert(0, header);
      final String csvData = const ListToCsvConverter().convert(_allCSVEvents);
      final String fileName = '${task.taskDetails!.name} - ${formatDateDashes.format(DateTime.now().toLocal())}.csv';

      final res = await pickFileDirectory();
      return res.fold(
        (error) {
          return Left(error);
        },
        (dir) async {
          if (dir == null) {
            return Left(GenericException(500, error: 'You haven\'t selected any directory.'));
          }
          final List<int> codeUnits = csvData.codeUnits;
          final Uint8List data = Uint8List.fromList(codeUnits);
          final res = await saveFileToDirectory(mimeType: 'text/csv', data: data, directory: dir, fileName: fileName);
          return res.fold(
            (error) {
              return Left(error);
            },
            (filePath) {
              busy = false;

              return Right(filePath);
            },
          );
        },
      );
    } catch (e) {
      busy = false;
      debugPrint('GENERATE CSV Exception: ${e.toString()}');
      return Left(GenericException(500, error: 'GENERATE CSV Exception: ${e.toString()}'));
    } finally {
      busy = false;
    }
  }
}
