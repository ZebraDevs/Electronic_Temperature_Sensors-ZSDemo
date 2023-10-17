part of 'create_task_view.dart';

class CreateTaskPreview extends StatelessWidget {
  final PageController controller;
  static const String routeName = "/create-task-3";

  const CreateTaskPreview({
    Key? key,
    required this.controller,
  }) : super(key: key);

  String degree(String string, num value) {
    return '$string (${Loco.current.taskDetailInfoDegree(value.toString())})';
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CreateTaskState>();
    return ListView(
      children: [
        const SizedBox(height: 20),
        ZSCreateTaskSectionWidget(
          title: Text(Loco.of(context).createTaskTitleReview),
          subTitle: Text(Loco.of(context).createTaskReviewText),
        ),
        const SizedBox(height: 20),
        Text(
          Loco.of(context).createTaskLblGeneralSettings,
          style: Theme.of(context).textTheme.title2,
        ),
        const SizedBox(height: 12),
        const Divider(height: 1),
        const SizedBox(
          height: 32,
        ),
        ZSCreateTaskSectionWidget(
          title: Text(Loco.of(context).createTaskLblName),
          subTitle: Text(
            state.taskDetails.name ?? '',
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Loco.of(context).createTaskHdlSensorConfiguration,
              style: Theme.of(context).textTheme.title2,
            ),
            TextButton(
              onPressed: () {
                controller.previousPage(duration: _kDuration, curve: _kCurve);
              },
              child: Text(Loco.of(context).edit),
            ),
          ],
        ),
        const Divider(height: 1),
        const SizedBox(
          height: 32,
        ),
        ZSCreateTaskSectionWidget(
          title: Text(Loco.of(context).createTaskLblReadingInterval),
          subTitle: Text(
            '${state.taskDetails.intervalMinutes ?? '0'} ${Loco.of(context).minutes}\n${state.taskDetails.intervalSeconds ?? '0'} ${Loco.of(context).seconds}',
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        ZSCreateTaskSectionWidget(
          title: Text(Loco.of(context).createTaskLblStartMode),
          subTitle: Text(
            state.startMode.startModeOverview(state.taskDetails.startDelayed?.delayedUntil),
          ),
        ),
        if (state.taskDetails.startDelayed != null && state.taskDetails.startDelayed?.onButtonPress != true) ...[
          const SizedBox(
            height: 16,
          ),
          ZSCreateTaskSectionWidget(
            title: Text(Loco.of(context).createTaskLblStartModeDelay),
            subTitle: DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyMedium!,
              child: Column(
                children: [
                  if (state.taskDetails.startDelayed?.delayedTempBelow != null)
                    Text(
                      degree(Loco.of(context).createTaskItmTempBelowText, state.taskDetails.startDelayed!.delayedTempBelow!),
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  if (state.taskDetails.startDelayed?.delayedTempAbove != null)
                    Text(
                      degree(Loco.of(context).createTaskItmTempAboveText, state.taskDetails.startDelayed!.delayedTempAbove!),
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  if (state.taskDetails.startDelayed?.delayedMinutes != null)
                    Text(
                      '${state.taskDetails.startDelayed!.delayedMinutes.toString()} ${Loco.of(context).minutes}',
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  if (state.taskDetails.startDelayed?.delayedUntil != null)
                    Text(
                      formatDateFilterMD24.format(state.taskDetails.startDelayed!.delayedUntil!.toLocal()),
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(
          height: 16,
        ),
        ZSCreateTaskSectionWidget(
          title: Text(Loco.of(context).createTaskLblAlarmSettings),
          subTitle: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyMedium!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.taskDetails.alarmLowTemp != null)
                  Text(
                    degree(Loco.of(context).taskDetailInfoLowLimit, state.taskDetails.alarmLowTemp!),
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                if (state.taskDetails.alarmHighTemp != null)
                  Text(
                    degree(Loco.of(context).taskDetailInfoHighLimit, state.taskDetails.alarmHighTemp!),
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                if (state.taskDetails.lowDurationMinutes != null || state.taskDetails.lowDurationSeconds != null)
                  Text(
                    "${Loco.of(context).taskDetailInfoLowDelay} (${Loco.of(context).minutesSeconds(
                      state.taskDetails.lowDurationMinutes ?? 0,
                      state.taskDetails.lowDurationSeconds ?? 0,
                    )})",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                if (state.taskDetails.highDurationMinutes != null || state.taskDetails.highDurationSeconds != null)
                  Text(
                    "${Loco.of(context).taskDetailInfoHighDelay} (${Loco.of(context).minutesSeconds(
                      state.taskDetails.highDurationMinutes ?? 0,
                      state.taskDetails.highDurationSeconds ?? 0,
                    )})",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }
}
