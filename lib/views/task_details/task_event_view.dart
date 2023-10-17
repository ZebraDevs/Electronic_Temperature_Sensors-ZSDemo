import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/enums/enums.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/styles/icons.dart';
import 'package:zsdemo_app/common/utils/date.dart';
import 'package:zsdemo_app/components/bottom_loader.dart';
import 'package:zsdemo_app/components/dialogs/snackbar.dart';
import 'package:zsdemo_app/components/error_widget.dart';
import 'package:zsdemo_app/components/is_loading_widget.dart';
import 'package:zsdemo_app/components/view_widgets/empty_view.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/task.dart';
import 'package:zsdemo_app/providers/task/task_event_provider.dart';
import 'package:zsdemo_app/states/task/task_details_state.dart';
import 'package:zsdemo_app/states/task/task_events_state.dart';
import 'package:zsdemo_app/views/base_view.dart';
import 'package:provider/provider.dart';

class TaskEventsView extends StatelessWidget {
  const TaskEventsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Task? task = context.watch<TaskDetailsState>().task;
    return TaskEventProvider(
      task: task!,
      child: Builder(builder: (context) {
        return BaseWidget<TaskEventState>(
          state: context.watch<TaskEventState>(),
          onStateReady: (state) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              state.getTaskEvents();
            });
          },
          builder: (context, state, child) {
            switch (state.taskEventState) {
              case ResponseState.isLoading:
                return IsLoadingView(
                  message: Loco.of(context).checkingForTaskEvents,
                );
              case ResponseState.error:
                return ErrorView(
                  error: state.error,
                  onTryAgain: state.getTaskEvents,
                );
              default:
                return LoadingWidget(
                  isLoading: state.busy,
                  child: state.events.isEmpty
                      ? Center(
                          child: Scaffold(
                            body: ZSEmptyView(
                              title: Text(Loco.of(context).taskDetailsNoEvents),
                              subtitle: Text(Loco.of(context).taskDetailsNoEventsDesc),
                              button: OutlinedButton(
                                onPressed: () => state.getTaskEvents(),
                                child: Text(Loco.of(context).tryAgain),
                              ),
                            ),
                            floatingActionButton: FloatingActionButton.extended(
                              icon: const Icon(ZSIcons.file_download),
                              label: Text(Loco.of(context).downloadCSV),
                              backgroundColor: ZSColors.neutralLight50,
                              foregroundColor: ZSColors.neutralLight00,
                              onPressed: null,
                            ),
                          ),
                        )
                      : const EventsFoundView(),
                );
            }
          },
        );
      }),
    );
  }
}

class EventsFoundView extends StatefulWidget {
  const EventsFoundView({super.key});

  @override
  State<EventsFoundView> createState() => _EventsFoundViewState();
}

class _EventsFoundViewState extends State<EventsFoundView> {
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
    final state = context.read<TaskEventState>();
    if (state.prevState == ResponseState.isLoadingMore && state.taskEventState == ResponseState.isDataFound) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.jumpTo(_scrollOffset);
      });
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final state = context.watch<TaskEventState>();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Flexible(
            child: RefreshIndicator.adaptive(
              onRefresh: state.refreshData,
              child: ScrollConfiguration(
                behavior: const ScrollBehavior()
                    .copyWith(physics: const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics())),
                child: DataTable2(
                  scrollController: _scrollController,
                  dataRowHeight: 74,
                  key: const Key('Task_events_table_key'),
                  minWidth: 50,
                  columns: [
                    DataColumn2(
                      label: Text(Loco.of(context).eventReading),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      label: Text(Loco.of(context).eventType),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      label: Text(Loco.of(context).eventTime),
                      size: ColumnSize.L,
                    ),
                  ],
                  rows: List.generate(state.events.length, (i) {
                    final event = state.events[i];
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            '${event.event!.data?.value.toString()}°C',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        DataCell(Text(
                          state.events[i].decode?.temperature?.eventType ?? '',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                        DataCell(Text(
                          formatDateFilterMD24.format(event.event!.timestamp!.toLocal()),
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                      ],
                    );
                  }),
                  bottomMargin: 60,
                ),
              ),
            ),
          ),
          if (state.taskEventState == ResponseState.isLoadingMore) const BottomLoader(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(ZSIcons.file_download),
        label: Text(Loco.of(context).downloadCSV),
        backgroundColor: state.busy ? ZSColors.neutralLight50 : ZSColors.primary,
        foregroundColor: ZSColors.neutralLight00,
        onPressed: state.busy
            ? null
            : () async {
                final res = await state.generateCsv();
                if (mounted) {
                  res.fold(
                    (error) => showZSSnackBar(
                      ZSSnackBar.icon(
                        label: Text(error.errorMessage() ?? Loco.of(context).error),
                        iconBackgroundColor: ZSColors.error,
                      ),
                    ),
                    (path) => showZSSnackBar(
                      ZSSnackBar.icon(
                        label: Text(Loco.of(context).downloadedSuccessfully),
                        iconBackgroundColor: ZSColors.success,
                      ),
                    ),
                  );
                }
              },
      ),
    );
  }

  void _onScroll() {
    if (_isBottom) {
      final state = context.read<TaskEventState>();
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
}
