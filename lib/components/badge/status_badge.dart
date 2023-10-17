import 'package:flutter/material.dart';
import 'package:zsdemo_app/components/badge/dot_decorator.dart';
import 'package:zsdemo_app/components/badge/dot_indicator.dart';

class ZSStatusBadge extends StatelessWidget {
  final Color dotColor;
  final Color backgroundColor;
  final String label;

  const ZSStatusBadge({
    Key? key,
    required this.dotColor,
    required this.backgroundColor,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DotIndicator(
              decorator: DotDecorator(activeColor: dotColor, activeSize: const Size.square(8)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 2, 8, 2),
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
          ),
        ],
      ),
    );
  }
}
