import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/styles/icons.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/states/task/task_details_state.dart';
import 'package:zsdemo_app/views/base_view.dart';
import 'package:provider/provider.dart';

class ZSAlarmTile extends StatelessWidget {
  final VoidCallback onPressed;
  const ZSAlarmTile({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      state: context.watch<TaskDetailsState>(),
      builder: (context, state, _) {
        final int alarms = state.sensor.mostRecent?.alarmCount ?? 0;
        return ListTile(
          onTap: alarms > 0 ? onPressed : null,
          tileColor: Colors.transparent,
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          title: DefaultTextStyle(
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            child: Text(Loco.current.viewAlarms(alarms)),
          ),
          trailing: alarms > 0
              ? Icon(
                  ZSIcons.navigate_next,
                  color: alarms > 0 ? ZSColors.primary : ZSColors.neutralLight40,
                )
              : const SizedBox(width: 16, height: 16),
        );
      },
    );
  }
}
