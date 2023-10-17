import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';

class ZSEmptyView extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget button;

  get _titleTextStyle => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: ZSColors.primaryDark,
      );

  get _subTitleTextStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.2,
        height: 1.5,
        color: ZSColors.secondaryDark,
      );

  const ZSEmptyView({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style: _titleTextStyle,
            maxLines: 1,
            child: title,
          ),
          const SizedBox(
            height: 8,
          ),
          DefaultTextStyle(
            style: _subTitleTextStyle,
            textAlign: TextAlign.center,
            child: subtitle,
          ),
          const SizedBox(
            height: 16,
          ),
          button,
        ],
      ),
    );
  }
}
