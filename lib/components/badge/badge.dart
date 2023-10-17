import 'package:flutter/material.dart';

class ZSBadge extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final bool compact;

  const ZSBadge({
    Key? key,
    required this.child,
    required this.backgroundColor,
    this.compact = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 6 : 12,
          vertical: 2,
        ),
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!,
          child: child,
        ),
      ),
    );
  }
}
