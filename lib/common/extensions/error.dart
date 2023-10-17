import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/components/dialogs/dialog_widget.dart';
import 'package:zsdemo_app/components/dialogs/snackbar.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/error.dart';

extension ErrorHandlingExtension on Option<UserLevelError> {
  Future<void> handleOptionError({
    required String onErrorTitle,
    void Function(BuildContext ctx)? onCameraPermissionsErrorTryAgain,
  }) async {
    await fold(() async {
      // success
      showZSSnackBar(
        ZSSnackBar.icon(
          label: Text(Loco.current.success),
          iconBackgroundColor: ZSColors.success,
        ),
      );
    }, (error) async {
      showZSSnackBar(
        ZSSnackBar.action(
          label: Text(onErrorTitle),
          buttonText: Text(Loco.current.retry),
          buttonAction: (context) {
            showDialog(
              context: context,
              builder: (context) {
                return ZSDialogWidget(
                  title: Text(onErrorTitle),
                  button: ElevatedButton(
                    child: Text(Loco.current.ok),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  content: [
                    Text(error.toString()),
                  ],
                );
              },
            );
          },
        ),
      );
    });
  }
}
