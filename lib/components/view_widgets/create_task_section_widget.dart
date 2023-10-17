import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/styles/theme.dart';

class ZSCreateTaskSectionWidget extends StatelessWidget {
  final Widget title;
  final Widget? subTitle;
  final List<Widget>? content;
  final Widget? alert;

  const ZSCreateTaskSectionWidget({
    Key? key,
    required this.title,
    this.subTitle,
    this.content,
    this.alert,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle(
          style: Theme.of(context).textTheme.title2!,
          child: title,
        ),
        const SizedBox(
          height: 8,
        ),
        if (subTitle != null)
          DefaultTextStyle(
            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ZSColors.secondaryDark),
            maxLines: 3,
            child: subTitle!,
          ),
        const SizedBox(
          height: 8,
        ),
        if (alert != null)
          DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyMedium!,
            child: alert!,
          ),
        const SizedBox(
          height: 8,
        ),
        if (content != null) ...content!,
      ],
    );
  }
}
