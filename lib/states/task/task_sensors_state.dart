import 'package:either_option/either_option.dart';
import 'package:zsdemo_app/common/enums/enums.dart';
import 'package:zsdemo_app/models/models.dart';
import 'package:zsdemo_app/services/zsdemo_api_service.dart';
import 'package:zsdemo_app/states/base_state.dart';

class TaskSensorsState extends BaseState with ZSDemoAPIServiceMixin {
  final String taskId;
  TaskSensorsState(this.taskId) : super(busy: true);

  List<Sensor> _sensors = [];
  List<Sensor> get sensors => _sensors;
  set sensors(List<Sensor> sensors) {
    _sensors = sensors;
    notifyListeners();
  }

  int get batchSize => 20;
  int _totalSensors = 0;
  int get totalSensors => _totalSensors;
  ZSAPIError? _error;
  ZSAPIError? get error => _error;
  set error(ZSAPIError? error) {
    _error = error;
    notifyListeners();
  }

  ResponseState _taskSensorsState = ResponseState.isLoading;
  ResponseState get taskSensorsState => _taskSensorsState;
  set taskSensorsState(ResponseState value) {
    if (value == _taskSensorsState) {
      return;
    }
    _taskSensorsState = value;
    notifyListeners();
  }

  Future<void> getTaskSensors() async {
    taskSensorsState = ResponseState.isLoading;
    final Either<ZSAPIError, ListSensorsResponse> res = await apiService.getTaskAssociatedSensors(taskId);
    res.fold((ZSAPIError error) {
      taskSensorsState = ResponseState.error;
      _error = error;
    }, (response) {
      taskSensorsState = ResponseState.isDataFound;
      sensors = response.sensors;
      _totalSensors = response.pageResponse.totalElements;
    });
  }
}
