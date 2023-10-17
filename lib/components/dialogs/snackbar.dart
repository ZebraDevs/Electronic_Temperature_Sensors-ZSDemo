import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/constants/constants.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/styles/icons.dart';
import 'package:zsdemo_app/components/dialogs/banner.dart';

class ZSSnackBar extends SnackBar {
  final Widget label;

  const ZSSnackBar({
    Key? key,
    required this.label,
    Duration? duration,
  }) : super(
          key: key,
          content: label,
          backgroundColor: ZSColors.neutralLight00,
          duration: duration ?? const Duration(seconds: 5),
        );

  factory ZSSnackBar.basic({
    Key? key,
    required Widget label,
    int? maxLines,
    Duration? duration,
  }) {
    return ZSSnackBar(
      key: key,
      label: ZSSnackBarContent(
        label: label,
        maxLines: maxLines,
      ),
      duration: duration,
    );
  }

  factory ZSSnackBar.icon({
    Key? key,
    required Widget label,
    Color iconBackgroundColor = ZSColors.success,
    int? maxLines,
    Duration? duration,
  }) {
    return ZSSnackBar(
      key: key,
      label: ZSSnackBarContent.icon(
        label: label,
        iconBackgroundColor: iconBackgroundColor,
        maxLines: maxLines,
      ),
      duration: duration,
    );
  }

  factory ZSSnackBar.action({
    Key? key,
    required Widget label,
    required Function(BuildContext) buttonAction,
    required Widget buttonText,
    int? maxLines,
    Duration? duration,
  }) {
    return ZSSnackBar(
      key: key,
      label: Builder(
        builder: (context) => ZSSnackBarContent.action(
          label: label,
          buttonAction: () => buttonAction(context),
          buttonText: buttonText,
          maxLines: maxLines,
        ),
      ),
      duration: duration,
    );
  }
  factory ZSSnackBar.actionSuccess({
    Key? key,
    required Widget label,
    required Function(BuildContext) buttonAction,
    required Widget buttonText,
    int? maxLines,
    Duration? duration,
  }) {
    return ZSSnackBar(
      key: key,
      label: Builder(
        builder: (context) => ZSSnackBarContent.actionSuccess(
          label: label,
          buttonAction: () => buttonAction(context),
          buttonText: buttonText,
          maxLines: maxLines,
        ),
      ),
      duration: duration,
    );
  }
}

class ZSSnackBarContent extends StatelessWidget {
  final Widget label;
  final Widget? icon;
  final Function? buttonAction;
  final Widget? buttonText;
  final double height;
  final Color snackBarColor;
  final ZSBannerVariant bannerVariant;
  final int? maxLines;

  const ZSSnackBarContent({
    Key? key,
    required this.label,
    this.icon,
    this.buttonAction,
    this.buttonText,
    this.height = 52,
    this.snackBarColor = ZSColors.neutralN900,
    this.bannerVariant = ZSBannerVariant.success,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: height),
      decoration: BoxDecoration(
        color: snackBarColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: ZSBanner(
        variant: bannerVariant,
        icon: icon,
        mainText: label,
        cornerRadius: 4,
        buttonAction: buttonAction,
        buttonText: buttonText,
        maxLines: maxLines,
      ),
    );
  }

  factory ZSSnackBarContent.icon({
    required Widget label,
    Color iconBackgroundColor = ZSColors.success,
    int? maxLines,
  }) {
    return ZSSnackBarContent(
      label: label,
      icon: CircleAvatar(
        radius: 16.66 / 2,
        backgroundColor: iconBackgroundColor,
        child: const Icon(
          Icons.check,
          size: 11.67,
          color: ZSColors.neutralLight00,
        ),
      ),
      maxLines: maxLines,
    );
  }

  factory ZSSnackBarContent.action({
    required Widget label,
    required Function buttonAction,
    required Widget buttonText,
    int? maxLines,
  }) {
    return ZSSnackBarContent(
      label: label,
      icon: const Icon(
        ZSIcons.info,
        size: 16.67,
        color: ZSColors.neutralLight00,
      ),
      buttonAction: buttonAction,
      buttonText: buttonText,
      height: 56,
      snackBarColor: ZSColors.error,
      bannerVariant: ZSBannerVariant.error,
      maxLines: maxLines,
    );
  }
  factory ZSSnackBarContent.actionSuccess({
    required Widget label,
    required Function buttonAction,
    required Widget buttonText,
    int? maxLines,
  }) {
    return ZSSnackBarContent(
      label: label,
      icon: const Icon(
        ZSIcons.info,
        size: 16.67,
        color: ZSColors.neutralLight00,
      ),
      buttonAction: buttonAction,
      buttonText: buttonText,
      height: 56,
      maxLines: maxLines,
      // snackBarColor: ZSColors.error,
      // bannerVariant: ZSBannerVariant.error,
    );
  }
}

void showZSSnackBar(
   ZSSnackBar snackBar,
) {
  scaffoldMessengerKey.currentState
    ?..clearSnackBars
    ..showSnackBar(
      snackBar,
    );
}
