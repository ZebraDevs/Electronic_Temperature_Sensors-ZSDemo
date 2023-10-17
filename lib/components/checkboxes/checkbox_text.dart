import 'package:flutter/material.dart';
import 'package:zsdemo_app/components/checkboxes/checkbox.dart';

class ZSCheckboxText extends StatelessWidget {
  final Widget? title;
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const ZSCheckboxText({
    Key? key,
    this.title,
    this.value = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ZSCheckbox(
              value: value,
              onChanged: onChanged,
            ),
            if (title != null) DefaultTextStyle(style: Theme.of(context).textTheme.bodyLarge!, child: title!),
          ],
        ),
      ],
    );
  }
}
