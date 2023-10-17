import 'package:flutter/material.dart';
import 'package:zsdemo_app/app.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/styles/icons.dart';
import 'package:zsdemo_app/components/dialogs/stop_task_dialog.dart';
import 'package:zsdemo_app/components/status_message.dart';
import 'package:zsdemo_app/components/view_widgets/empty_view.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/task.dart';
import 'package:zsdemo_app/states/task/task_details_state.dart';
import 'package:zsdemo_app/views/base_view.dart';
import 'package:zsdemo_app/views/task_details/task_event_view.dart';
import 'package:zsdemo_app/views/task_details/task_info_view.dart';
import 'package:zsdemo_app/views/task_details/task_overview_view.dart';
import 'package:zsdemo_app/views/task_details/task_sensors_view.dart';
import 'package:provider/provider.dart';

final _tabs = {
  Tab(text: Loco.current.taskDetailTabOverview): const TaskOverviewView(),
  Tab(text: Loco.current.taskDetailTabInfo): const TaskInfoView(),
  Tab(text: Loco.current.taskDetailTabEvents): const TaskEventsView(),
  Tab(text: Loco.current.taskDetailTabSensors): const TaskSensorsView(),
};

class TaskDetailsView extends StatefulWidget {
  static const String routeName = "/task-details";

  const TaskDetailsView({super.key});

  @override
  State<TaskDetailsView> createState() => _TaskDetailsViewState();
}

class _TaskDetailsViewState extends State<TaskDetailsView> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      state: context.watch<TaskDetailsState>(),
      onStateReady: (state) async {
        state.getTaskData(context);
      },
      builder: (context, state, _) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text(
            Loco.of(context).taskDetails,
            overflow: TextOverflow.ellipsis,
          ),
          leading: IconButton(
            color: ZSColors.neutralLight00,
            icon: const Icon(ZSIcons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            if (state.task != null)
              IconButton(
                icon: const Icon(Icons.stop_circle_rounded),
                color: ZSColors.primaryB25,
                onPressed: state.task!.isTaskStopped()
                    ? null
                    : () {
                        stopTask(context, state);
                      },
              )
          ],
        ),
        body: Column(
          children: [
            TabBar(
              controller: tabController,
              tabs: _tabs.keys.toList(),
              isScrollable: true,
              onTap: (index) {
                if (state.error != null || (state.task == null && !state.busy)) {
                  tabController.index = 0;
                }
              },
            ),
            Expanded(
              child: () {
                if (state.busy) {
                  return LoadingStatus(label: Loco.of(context).taskDetailsLoading);
                }
                if (state.stoppingTask) {
                  return LoadingStatus(label: Loco.of(context).stopTaskLoading);
                }
                if (state.error != null || (state.task == null && !state.busy)) {
                  return ZSEmptyView(
                    title: Text(state.error!.toErrorData().errorTitle),
                    subtitle: Text(state.error!.toErrorData().errorDescription),
                    button: OutlinedButton(
                      child: Text(Loco.of(context).tryAgain),
                      onPressed: () {
                        state.error = null;
                        state.getTaskData(context);
                      },
                    ),
                  );
                }
                return TabBarView(
                  controller: tabController,
                  children: _tabs.values.toList(),
                );
              }(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> stopTask(BuildContext context, TaskDetailsState state) async {
    await showDialog(
      context: context,
      builder: (_) => StopTaskDialog(
        onConfirm: () async {
          navigatorKey.currentState?.pop();
          await state.stopTask(context);
        },
      ),
    );
  }
}
