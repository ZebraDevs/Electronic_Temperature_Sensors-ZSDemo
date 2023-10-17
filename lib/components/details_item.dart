import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';

class TaskDetailsItem extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Widget? child;
  const TaskDetailsItem({
    Key? key,
    required this.title,
    this.subTitle,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ZSColors.secondaryDark, fontSize: 16),
        ),
        const SizedBox(
          height: 4,
        ),
        child ??
            Text(subTitle ?? '-',
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ZSColors.secondaryDark,
                      fontSize: 16,
                    )),
      ],
    );
  }
}
