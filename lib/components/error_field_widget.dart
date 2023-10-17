import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';

class ErrorFieldWidget extends StatelessWidget {
  final String text;

  const ErrorFieldWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      width: double.infinity,
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ZSColors.error),
      ),
    );
  }
}
