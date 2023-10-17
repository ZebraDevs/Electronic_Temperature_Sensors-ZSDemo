import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';

class ZSDialogWidget extends StatelessWidget {
  final Widget title;
  final List<Widget>? content;
  final Widget button;
  final Widget? optionalButton;

  const ZSDialogWidget({
    Key? key,
    required this.title,
    this.content,
    required this.button,
    this.optionalButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: ZSColors.neutralLight00,
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DefaultTextStyle(
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                child: title,
              ),
              const SizedBox(height: 8),
              if (content != null) ...content!,
              const SizedBox(height: 42),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.end,
                  runAlignment: WrapAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 10,
                  children: [
                    button,
                    if (optionalButton != null) ...[
                      const SizedBox(
                        width: 32,
                      ),
                      optionalButton!,
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
