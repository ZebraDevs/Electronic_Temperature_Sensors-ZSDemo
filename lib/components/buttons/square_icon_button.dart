import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';

class ZSSquareIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final bool colorful;
  const ZSSquareIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.colorful = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(4);
    return Material(
      color: background,
      borderRadius: borderRadius,
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        height: 44,
        width: 44,
        child: InkWell(
          onTap: onPressed,
          splashColor: ZSColors.neutralLight50,
          child: Container(
            alignment: Alignment.center,
            child: IconTheme(
              data: IconThemeData(color: foreground),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }

  Color get background {
    if (onPressed != null) {
      if (colorful) return ZSColors.primaryB400;
      return ZSColors.neutralLight20;
    }
    return ZSColors.neutralLight30;
  }

  Color get foreground {
    if (onPressed != null) {
      if (colorful) return ZSColors.neutralLight00;
      return ZSColors.neutralLight300;
    }
    return ZSColors.neutralLight50;
  }
}
