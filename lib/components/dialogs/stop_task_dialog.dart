import 'package:flutter/material.dart';
import 'package:zsdemo_app/app.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/components/dialogs/dialog_widget.dart';
import 'package:zsdemo_app/generated/l10n.dart';

class StopTaskDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const StopTaskDialog({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZSDialogWidget(
      title: Text(Loco.current.stopTask),
      content: [
        Text(
          Loco.current.stopTaskPromptMessage,
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
      button: TextButton(
        child: Text(Loco.current.cancel),
        onPressed: () => navigatorKey.currentState?.pop(),
      ),
      optionalButton: TextButton(
        onPressed: onConfirm,
        child: Text(
          Loco.current.stopTask,
          style: const TextStyle(
            color: ZSColors.error,
          ),
        ),
      ),
    );
  }
}
