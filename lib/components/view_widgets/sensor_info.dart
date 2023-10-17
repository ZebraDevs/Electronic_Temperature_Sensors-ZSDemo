import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/styles/theme.dart';

enum AddSensorStatus {
  info,
  error,
}

extension AddSensorStatusExt on AddSensorStatus {
  Color getBackgroundColor() {
    switch (this) {
      case AddSensorStatus.info:
        return ZSColors.neutralLight10;
      case AddSensorStatus.error:
        return ZSColors.errorLightBG;
    }
  }
}

class AddSensorStatusBox extends StatelessWidget {
  final AddSensorStatus status;
  final Widget title;
  final Widget subtitle;

  const AddSensorStatusBox({
    Key? key,
    required this.status,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: status.getBackgroundColor(),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style: Theme.of(context).textTheme.title1!,
            textAlign: TextAlign.center,
            child: title,
          ),
          const SizedBox(height: 16),
          DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyLarge!,
            textAlign: TextAlign.center,
            child: subtitle,
          ),
        ],
      ),
    );
  }
}
