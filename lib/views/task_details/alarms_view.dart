import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/enums/enums.dart';
import 'package:zsdemo_app/common/utils/date.dart';
import 'package:zsdemo_app/components/error_widget.dart';
import 'package:zsdemo_app/components/is_loading_widget.dart';
import 'package:zsdemo_app/components/view_widgets/empty_view.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/alarms.dart';
import 'package:zsdemo_app/states/task/alarms_state.dart';
import 'package:zsdemo_app/views/base_view.dart';
import 'package:provider/provider.dart';

class AlarmsView extends StatelessWidget {
  const AlarmsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TaskAlarmState>(
      state: context.watch<TaskAlarmState>(),
      onStateReady: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          state.refreshData();
        });
      },
      builder: (context, state, child) => Scaffold(
        body: Scaffold(
          appBar: AppBar(
            title: Text(Loco.of(context).alarms),
          ),
          body: checkAlarmsState(state, context),
        ),
      ),
    );
  }
}

checkAlarmsState(TaskAlarmState state, BuildContext context) {
  switch (state.taskAlarmState) {
    case ResponseState.isLoading:
      return IsLoadingView(
        message: Loco.of(context).checkingForTaskAlarms,
      );
    case ResponseState.error:
      return ErrorView(
        error: state.error,
        onTryAgain: state.refreshData,
      );
    default:
      if (state.alarms.isEmpty) {
        return Center(
          child: ZSEmptyView(
            title: Text(Loco.of(context).taskDetailsNoEvents),
            subtitle: Text(Loco.of(context).taskDetailsNoEventsDesc),
            button: OutlinedButton(
              onPressed: () => state.refreshData(),
              child: Text(Loco.current.tryAgain),
            ),
          ),
        );
      }
      return const AlarmsFoundView();
  }
}

class AlarmsFoundView extends StatefulWidget {
  const AlarmsFoundView({super.key});

  @override
  State<AlarmsFoundView> createState() => _AlarmsFoundViewState();
}

class _AlarmsFoundViewState extends State<AlarmsFoundView> {
  final _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = context.read<TaskAlarmState>();
    if (state.prevState == ResponseState.isLoadingMore && state.taskAlarmState == ResponseState.isDataFound) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.jumpTo(_scrollOffset);
      });
    }
  }

  @override
  build(context) {
    final state = context.watch<TaskAlarmState>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(Loco.of(context).alarmsCount(state.alarms.length, state.totalElements)),
        ),
        const SizedBox(height: 20),
        Flexible(
          child: RefreshIndicator.adaptive(
            onRefresh: state.refreshData,
            child: ScrollConfiguration(
              behavior: const ScrollBehavior()
                  .copyWith(physics: const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics())),
              child: DataTable2(
                scrollController: _scrollController,
                key: const Key('Task_alarms_table_key'),
                sortColumnIndex: 1,
                fixedLeftColumns: 0,
                dataRowHeight: 74,
                sortAscending: state.order == SortOrder.accending,
                columns: [
                  DataColumn(label: Text(Loco.of(context).alarmType)),
                  DataColumn(
                    label: Text(Loco.of(context).alarmTime),
                    onSort: (index, value) => sort(index, value, state),
                  ),
                  DataColumn(
                    label: Text(Loco.of(context).alarmTemperature),
                  ),
                ],
                rows: List<DataRow>.generate(state.alarms.length, (index) {
                  final item = state.alarms[index];
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          item.alarmType?.toStatus() ?? '',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      DataCell(Text(
                        item.occurred == null ? '' : formatDateFilterMD24.format(item.occurred!.toLocal()),
                        style: Theme.of(context).textTheme.bodyLarge,
                      )),
                      DataCell(
                        Text(
                          item.temperature == null ? '-' : '${item.temperature.toString()}°C',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
        if (state.taskAlarmState == ResponseState.isLoadingMore)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  void _onScroll() {
    if (_isBottom) {
      final state = context.read<TaskAlarmState>();
      state.loadData();
      _scrollOffset = _scrollController.position.pixels;
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.95);
  }

  void sort(int columnIndex, bool ascending, TaskAlarmState state) {
    state.onSort(
      columnIndex,
      ascending ? SortOrder.accending : SortOrder.descending,
    );
  }
}
