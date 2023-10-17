import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/styles/icons.dart';
import 'package:zsdemo_app/common/utils/validators.dart';
import 'package:zsdemo_app/components/buttons/square_icon_button.dart';
import 'package:zsdemo_app/components/error_field_widget.dart';
import 'package:zsdemo_app/components/input_fields/text_input_field.dart' hide FormField;
import 'package:zsdemo_app/generated/l10n.dart';

class ZSInputNumberStepperFormField extends FormField<String> {
  static String? nonNegative(String? value) {
    if (value == null) return Loco.current.errorNotEmpty;
    final numValue = double.tryParse(value);
    if (numValue == null) return Loco.current.errorNotEmpty;
    const additive = 0;
    if ((numValue + additive) >= 0 || additive > 0) {
      return null;
    }
    return Loco.current.errorPositiveNumber;
  }

  static String? alwaysValid(String? value) {
    if (value == null) return Loco.current.errorNotEmpty;
    final numValue = double.tryParse(value);
    if (numValue == null) {
      return Loco.current.errorNotEmpty;
    }
    return null;
  }

  final String? value;
  final ValueChanged<String>? onChanged;
  final bool Function(String value)? canGoUp;
  final bool Function(String value)? canGoDown;

  ZSInputNumberStepperFormField({
    required this.value,
    bool signed = false,
    FormFieldSetter<String>? onSaved,
    this.onChanged,
    FormFieldValidator<String>? validator,
    required FormFieldValidator<String>? onUserNotAbleToTypeValidator,
    String? label,
    Widget? title,
    Widget? subtitle,
    bool canType = true,
    bool hasButtons = true,
    required bool onlyInt,
    bool allowNegative = true,
    this.canGoUp,
    this.canGoDown,
    bool? isMinutes,
    bool? isSeconds,
    bool? isDoubleStepperMinutes,
    bool? isDoubleStepperSeconds,
    Key? key,
  }) : super(
          key: key,
          autovalidateMode: AutovalidateMode.always,
          onSaved: onSaved,
          validator: !canType && (value == null || value.isEmpty) ? onUserNotAbleToTypeValidator : validator,
          initialValue: value,
          enabled: canType,
          builder: (state) {
            return ZSInputNumberStepper<String>(
              value: value,
              signed: signed,
              label: Text(' ${label ?? ''}'),
              canType: canType,
              hasButtons: hasButtons,
              onlyInt: onlyInt,
              allowNegative: allowNegative,
              isMinutes: isMinutes,
              isSeconds: isSeconds,
              isDoubleStepperMinutes: isDoubleStepperMinutes,
              isDoubleStepperSeconds: isDoubleStepperSeconds,
              errorText: ErrorFieldWidget(state.errorText ?? ''),
              onChange: (value) {
                state.didChange(value);
                onChanged?.call(value);
              },
              canGoUp: canGoUp,
              canGoDown: canGoDown,
            );
          },
        );
  @override
  FormFieldState<String> createState() {
    return InputNumberStepperState();
  }
}

class InputNumberStepperState extends FormFieldState<String> {
  @override
  void didUpdateWidget(covariant ZSInputNumberStepperFormField oldWidget) {
    final inputWidget = (widget as ZSInputNumberStepperFormField);
    final value = inputWidget.value;
    final alreadyReset = value == null || value.isEmpty;
    if (!widget.enabled && !alreadyReset) {
      debugPrint('resetting');
      debugPrint(widget.initialValue?.toString());
      Future.microtask(() => reset());
    }
    if (oldWidget.value != (widget as ZSInputNumberStepperFormField).value) {
      setValue((widget as ZSInputNumberStepperFormField).value);
    }
    super.didUpdateWidget(oldWidget);
  }
}

class ZSInputNumberStepper<T extends String> extends StatefulWidget {
  final bool canType;
  // I have to go through strings because no way to differeciate between
  // when the user has typed "3." and wants this to mean "3"
  // and when he had typed "3.5" and deleted the last character and is not done yet
  final T? value;
  final void Function(T) onChange;
  final bool signed;
  final bool onlyInt;
  final bool allowNegative;
  final Widget? label;
  final Widget? errorText;
  final bool hasButtons;
  final bool Function(String value)? canGoUp;
  final bool Function(String value)? canGoDown;
  final bool? isMinutes;
  final bool? isSeconds;
  final bool? isDoubleStepperMinutes;
  final bool? isDoubleStepperSeconds;

  static bool nonNegative(double value, [double additive = 0]) {
    return (value + additive) >= 0 || additive > 0;
  }

  static bool alwaysValid(double value, [double additive = 0]) {
    return true;
  }

  const ZSInputNumberStepper({
    Key? key,
    required this.canType,
    required this.onChange,
    this.signed = true,
    required this.value,
    this.onlyInt = false,
    this.allowNegative = true,
    this.hasButtons = true,
    this.errorText,
    this.label,
    this.canGoUp,
    this.canGoDown,
    this.isMinutes = false,
    this.isSeconds = false,
    this.isDoubleStepperMinutes = false,
    this.isDoubleStepperSeconds = false,
  }) : super(key: key);
  String get getValue => value ?? '';

  @override
  State<ZSInputNumberStepper<T>> createState() => _ZSInputNumberStepperState<T>();
}

class _ZSInputNumberStepperState<T extends String> extends State<ZSInputNumberStepper<T>> {
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.getValue);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ZSInputNumberStepper<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (controller.text != widget.getValue) {
      // [...].value = ...
      // calls setState, which cannot be called here, so we call it the next frame
      Future.microtask(() {
        controller.value = controller.value.copyWith(
          text: widget.getValue,
          selection: TextSelection.collapsed(offset: widget.getValue.length),
          composing: TextRange.empty,
        );
      });
    }
  }

  RegExp get regex {
    if (widget.onlyInt && widget.allowNegative) {
      return RegExp(r'(^-?\d*)');
    }
    if (widget.onlyInt && !widget.allowNegative) {
      return RegExp(r'^[0-9]+$');
    }
    return RegExp(r'(^-?\d*\.?\d{0,2})');
  }

  @override
  Widget build(BuildContext context) {
    final num? value = widget.onlyInt ? int.tryParse(widget.value ?? '') : double.tryParse(widget.value ?? '');

    final bool canTapMinus = widget.canType && (widget.canGoDown?.call(((value ?? 0) - 1).toString()) ?? true);
    final bool canTapPlus = widget.canType && (widget.canGoUp?.call(((value ?? 0) + 1).toString()) ?? true);

    late final TextInputType keyboardType;
    if (widget.signed) {
      keyboardType = TextInputType.numberWithOptions(
        decimal: !widget.onlyInt,
        signed: widget.signed,
      );
    } else {
      keyboardType = TextInputType.numberWithOptions(
        decimal: !widget.onlyInt,
      );
    }
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.hasButtons)
          ZSSquareIconButton(
            onPressed: canTapMinus
                ? () {
                    if (value == null) return widget.onChange('-1' as T);
                    final num number = parse(widget.value ?? '0', widget.onlyInt);
                    if (number is double) {
                      final num decimalNumber =
                          double.parse('0.${number.toStringAsFixed(2).split('.').last.substring(0, 1)}');
                      if ((number + decimalNumber) > 0) {
                        widget.onChange(((number.toInt() - 1) + decimalNumber).toStringAsFixed(1) as T);
                      } else {
                        widget.onChange(((number.toInt() - 1) - decimalNumber).toStringAsFixed(1) as T);
                      }
                    } else {
                      widget.onChange((number - 1).toString() as T);
                    }
                  }
                : null,
            icon: const Icon(ZSIcons.remove),
          ),
        Flexible(
          child: Container(
            width: 80,
            height: 44,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: ZSTextFormField(
              controller: controller,
              enabled: widget.canType,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(regex),
                // disable dash (-) when not signed input
                if (!widget.signed)
                  FilteringTextInputFormatter.deny(
                    RegExp(r'-'),
                  ),
                if (widget.isMinutes == true) TextInputFormatterWithLimit(240),
                if (widget.isSeconds == true || widget.isDoubleStepperSeconds == true) TextInputFormatterWithLimit(59),
                if (widget.isDoubleStepperMinutes == true) TextInputFormatterWithLimit(60),
              ],
              textAlign: TextAlign.center,
              keyboardType: keyboardType,
              onChanged: (keyboardValue) {
                widget.onChange(keyboardValue as T);
              },
            ),
          ),
        ),
        if (widget.hasButtons)
          ZSSquareIconButton(
            icon: const Icon(ZSIcons.add),
            onPressed: canTapPlus
                ? () {
                    if (value == null) return widget.onChange('1' as T);
                    final num number = parse(widget.value ?? '0', widget.onlyInt);
                    if (number is double) {
                      final num decimalNumber =
                          double.parse('0.${number.toStringAsFixed(2).split('.').last.substring(0, 1)}');
                      if (number > 0 && (number + decimalNumber) > 0) {
                        widget.onChange(((number.toInt() + 1) + decimalNumber).toStringAsFixed(1) as T);
                      } else {
                        widget.onChange(((number.toInt() + 1) - decimalNumber).toStringAsFixed(1) as T);
                      }
                    } else {
                      widget.onChange((number + 1).toString() as T);
                    }
                  }
                : null,
          ),
      ],
    );

    if (widget.label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            style: const TextStyle(
              fontSize: 16,
              letterSpacing: -0.2,
              fontWeight: FontWeight.w500,
              height: 1.22,
              color: ZSColors.secondaryDark,
            ),
            child: widget.label!,
          ),
          row,
          if (widget.errorText != null) widget.errorText!,
        ],
      );
    }
    return row;
  }

  num parse(String value, bool isInt) {
    if (isInt) return value.isEmpty ? 0 : int.parse(value);
    return value.isEmpty ? 0 : double.parse(value);
  }
}
