import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/styles/theme.dart';

class ZSBanner extends StatelessWidget {
  final ZSBannerVariant? variant;
  final Widget mainText;
  final Widget? infoText;
  final Widget? buttonText;
  final Function? buttonAction;
  final Widget? icon;
  final double? cornerRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final int? maxLines;

  // Task info
  factory ZSBanner.taskInfo({
    Key? key,
    required Widget mainText,
    Widget? infoText,
    Widget? buttonText,
    Function? buttonAction,
    double? cornerRadius,
    int? maxLines,
  }) {
    return ZSBanner(
      key: key,
      variant: ZSBannerVariant.taskInfo,
      mainText: mainText,
      infoText: infoText,
      buttonText: buttonText,
      buttonAction: buttonAction,
      cornerRadius: cornerRadius,
      maxLines: maxLines,
    );
  }

  //Basic
  factory ZSBanner.basic({
    Key? key,
    Widget? icon,
    required Widget mainText,
    Widget? buttonText,
    Function? buttonAction,
    double? cornerRadius,
    Color? backgroundColor,
    Color? textColor,
    int? maxLines,
  }) {
    return ZSBanner(
      key: key,
      variant: ZSBannerVariant.basic,
      icon: icon,
      mainText: mainText,
      buttonText: buttonText,
      buttonAction: buttonAction,
      cornerRadius: cornerRadius,
      backgroundColor: backgroundColor,
      textColor: textColor,
      maxLines: maxLines,
    );
  }

  //Warning
  factory ZSBanner.warning({
    Key? key,
    Widget? icon,
    required Widget mainText,
    Widget? buttonText,
    Function? buttonAction,
    double? cornerRadius,
    int? maxLines,
  }) {
    return ZSBanner(
      key: key,
      variant: ZSBannerVariant.warning,
      icon: icon,
      mainText: mainText,
      buttonText: buttonText,
      buttonAction: buttonAction,
      cornerRadius: cornerRadius,
      maxLines: maxLines,
    );
  }

  //Error
  factory ZSBanner.error({
    Key? key,
    Widget? icon,
    required Widget mainText,
    Widget? buttonText,
    Function? buttonAction,
    double? cornerRadius,
    int? maxLines,
  }) {
    return ZSBanner(
      key: key,
      variant: ZSBannerVariant.error,
      icon: icon,
      mainText: mainText,
      buttonText: buttonText,
      buttonAction: buttonAction,
      cornerRadius: cornerRadius,
      maxLines: maxLines,
    );
  }

  //Success
  factory ZSBanner.success({
    Key? key,
    Widget? icon,
    required Widget mainText,
    Widget? buttonText,
    Function? buttonAction,
    double? cornerRadius,
    int? maxLines,
  }) {
    return ZSBanner(
      key: key,
      variant: ZSBannerVariant.success,
      icon: icon,
      mainText: mainText,
      buttonText: buttonText,
      buttonAction: buttonAction,
      cornerRadius: cornerRadius,
      maxLines: maxLines,
    );
  }

  const ZSBanner({
    Key? key,
    this.buttonAction,
    required this.mainText,
    this.infoText,
    this.buttonText,
    this.icon,
    this.variant,
    this.cornerRadius,
    this.backgroundColor,
    this.textColor,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? variant?.getBackgroundColor(),
        borderRadius: BorderRadius.circular(cornerRadius ?? 0),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconTheme(
                data: IconThemeData(
                  color: textColor ?? variant?.getContentColor(),
                  size: 17,
                ),
                child: icon!,
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: DefaultTextStyle(
                      style: variant!.getTextStyle(variant, context).copyWith(
                            color: textColor ?? variant?.getContentColor(),
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: variant == ZSBannerVariant.taskInfo ? 1 : (maxLines ?? 2),
                      child: mainText,
                    ),
                  ),
                  if (infoText != null)
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white.withOpacity(0.6),
                          ),
                      child: infoText!,
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          if (buttonText != null)
            TextButton(
              onPressed: () => buttonAction!(),
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: variant?.getContentColor(),
                ),
                maxLines: 1,
                child: buttonText!,
              ),
            ),
        ],
      ),
    );
  }
}

enum ZSBannerVariant { taskInfo, basic, warning, error, success }

extension ZSBannerVariantExtension on ZSBannerVariant {
  Color getBackgroundColor() {
    switch (this) {
      case ZSBannerVariant.taskInfo:
        return ZSColors.neutralN600;
      case ZSBannerVariant.basic:
        return ZSColors.neutralN600;
      case ZSBannerVariant.warning:
        return ZSColors.warning;
      case ZSBannerVariant.error:
        return ZSColors.error;
      case ZSBannerVariant.success:
        return ZSColors.neutralN900;
    }
  }

  Color getContentColor() {
    switch (this) {
      case ZSBannerVariant.warning:
        return ZSColors.primaryDark;
      default:
        return ZSColors.neutralLight00;
    }
  }

  TextStyle getTextStyle(variant, context) {
    switch (this) {
      case ZSBannerVariant.taskInfo:
        return Theme.of(context).textTheme.title3!;
      default:
        return Theme.of(context).textTheme.bodyMedium!;
    }
  }
}
