import 'package:either_option/either_option.dart';
import 'package:zsdemo_app/common/enums/enums.dart';
import 'package:zsdemo_app/models/alarms.dart';
import 'package:zsdemo_app/models/error.dart';
import 'package:zsdemo_app/services/zsdemo_api_service.dart';
import 'package:zsdemo_app/states/base_state.dart';

class TaskAlarmState extends BaseState with ZSDemoAPIServiceMixin {
  final String taskId;
  TaskAlarmState(this.taskId) : super(busy: true);

  List<SensorAlarm> _alarms = [];
  List<SensorAlarm> get alarms => _alarms;
  set alarms(List<SensorAlarm> alarms) {
    _alarms = alarms;
    notifyListeners();
  }

  int _currentPage = 0;
  int _totalElements = 0;
  int _lastPage = 0;
  int get batchSize => 20;
  int get totalElements => _totalElements;

  void onSort(int sortColumn, SortOrder order) {
    _order = order;
    _currentPage = 0;
    _alarms = [];
    getTaskAlarms();
  }

  SortOrder _order = SortOrder.descending;

  SortOrder get order => _order;

  ZSAPIError? _error;
  ZSAPIError? get error => _error;

  set error(ZSAPIError? error) {
    _error = error;
    notifyListeners();
  }

  ResponseState _taskAlarmState = ResponseState.isLoading;
  ResponseState get taskAlarmState => _taskAlarmState;
  ResponseState prevState = ResponseState.isLoading;
  set taskAlarmState(ResponseState value) {
    if (value == _taskAlarmState) {
      return;
    }
    prevState = _taskAlarmState;
    _taskAlarmState = value;
    notifyListeners();
  }

  Future<void> loadData() async {
    if (taskAlarmState == ResponseState.isLoading ||
        taskAlarmState == ResponseState.isLoadingMore ||
        _lastPage == _currentPage + 1) {
      return;
    }
    _currentPage++;
    getTaskAlarms();
  }

  Future<void> refreshData() async {
    alarms = [];
    _currentPage = 0;
    _order = SortOrder.descending;
    getTaskAlarms();
  }

  Future<void> getTaskAlarms() async {
    taskAlarmState = _currentPage == 0 ? ResponseState.isLoading : ResponseState.isLoadingMore;
    final Either<ZSAPIError, ListAlarmsResponse> res =
        await apiService.getTaskAlarms(taskId: taskId, pageNumber: _currentPage, pageSize: batchSize, order: _order);
    res.fold((ZSAPIError error) {
      taskAlarmState = ResponseState.error;
      _error = error;
    }, (response) {
      _totalElements = response.pageResponse.totalElements;
      _lastPage = response.pageResponse.totalPages;

      alarms = [
        ...alarms,
        ..._filterOutAlarms(response.sensorAlarms),
      ];
      taskAlarmState = ResponseState.isDataFound;
    });
  }

  List<SensorAlarm> _filterOutAlarms(List<SensorAlarm> alarms) {
    return alarms.where((element) => element.alarmType != AlarmType.ALARM_TYPE_UNSPECIFIED).toList();
  }
}
