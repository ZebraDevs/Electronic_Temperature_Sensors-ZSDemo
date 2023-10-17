import 'package:flutter/material.dart';
import 'package:zsdemo_app/components/view_widgets/empty_view.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/error.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.error,
    required this.onTryAgain,
    super.key,
  });
  final ZSAPIError? error;
  final VoidCallback onTryAgain;
  @override
  build(context) {
    return Center(
      child: ZSEmptyView(
        title: Text(error!.toErrorData().errorTitle),
        subtitle: Text(error!.toErrorData().errorDescription),
        button: OutlinedButton(
          onPressed: onTryAgain,
          child: Text(Loco.current.tryAgain),
        ),
      ),
    );
  }
}
