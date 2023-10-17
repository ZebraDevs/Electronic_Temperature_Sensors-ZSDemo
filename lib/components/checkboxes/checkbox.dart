import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';

const kScale = 1.3;

class ZSCheckbox extends StatelessWidget {
  final bool value;
  final void Function(bool)? onChanged;
  const ZSCheckbox({Key? key, this.value = false, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: kScale,
      child: Checkbox(
        value: value,
        side: const BorderSide(
          width: 2,
          color: ZSColors.neutralLight40,
        ).scale(1 / kScale),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4 / kScale),
        ),
        tristate: false,
        onChanged: (value) {
          onChanged?.call(value!);
        },
      ),
    );
  }
}
