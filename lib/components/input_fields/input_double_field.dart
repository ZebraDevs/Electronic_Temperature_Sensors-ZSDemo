import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/styles/theme.dart';
import 'package:zsdemo_app/components/error_field_widget.dart';
import 'package:zsdemo_app/components/input_fields/input_number_stepper.dart';
import 'package:intersperse/intersperse.dart';

class DoubleValue<T> {
  final T minutes;
  final T seconds;

  const DoubleValue(this.minutes, this.seconds);

  DoubleValue<T> copyWith({T? minutes, T? seconds}) {
    return DoubleValue<T>(minutes ?? this.minutes, seconds ?? this.seconds);
  }

  @override
  String toString() {
    return '(minutes=$minutes, seconds=$seconds)';
  }
}

// readonly if has template - also may have value readonly + enabled + value or readonly + disabled + value
class InputDoubleField extends FormField<DoubleValue<String>> {
  final DoubleValue<String> value;
  InputDoubleField({
    required this.value,
    DoubleValue<bool> signed = const DoubleValue(false, false),
    FormFieldSetter<DoubleValue<String>>? onSaved,
    ValueChanged<DoubleValue<String>>? onChanged,
    required String minutesLabel,
    required String secondsLabel,
    Widget? title,
    Widget? subtitle,
    bool canType = true,
    Key? key,
  }) : super(
            key: key,
            autovalidateMode: AutovalidateMode.always,
            onSaved: onSaved,
            initialValue: value,
            enabled: canType,
            builder: (state) {
              final doubleState = state; // as InputDoubleFieldState;
              // TextFormField
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...[
                    if (title != null)
                      DefaultTextStyle(
                        style: Theme.of(state.context).textTheme.title2!,
                        child: title,
                      ),
                    if (subtitle != null)
                      DefaultTextStyle(
                        style: Theme.of(state.context).textTheme.bodyMedium!.copyWith(color: ZSColors.secondaryDark),
                        maxLines: 3,
                        child: subtitle,
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    ZSInputNumberStepperFormField(
                      hasButtons: true,
                      // I char to the right pls
                      label: minutesLabel,
                      canType: canType,
                      signed: signed.minutes,
                      value: doubleState.value!.minutes,
                      onChanged: (String value) {
                        doubleState.didChange(doubleState.value!.copyWith(
                          minutes: value,
                        ));
                        if (value == '60') {
                          doubleState.didChange(doubleState.value!.copyWith(
                            seconds: '0',
                          ));
                        }
                        onChanged?.call(doubleState.value!);
                      },
                      onUserNotAbleToTypeValidator: (value) => null,
                      onlyInt: true,
                      isDoubleStepperMinutes: true,
                      canGoDown: (value) {
                        if (doubleState.value!.minutes.isEmpty) {
                          return false;
                        }
                        return doubleState.value?.minutes != '0';
                      },
                      canGoUp: (value) {
                        if (doubleState.value!.minutes.isNotEmpty && doubleState.value!.seconds.isNotEmpty) {
                          if (doubleState.value?.minutes == '59' && int.parse(doubleState.value!.seconds) > 0) {
                            return false;
                          } else {
                            return int.parse(doubleState.value!.minutes) < 60;
                          }
                        }
                        if (doubleState.value!.minutes.isEmpty || doubleState.value!.seconds.isEmpty) {
                          return true;
                        }
                        return false;
                      },
                    ),
                    ZSInputNumberStepperFormField(
                      hasButtons: true,
                      label: secondsLabel,
                      canType: doubleState.value!.minutes.isNotEmpty ? int.parse(doubleState.value!.minutes) != 60 : true,
                      signed: signed.seconds,
                      value: doubleState.value!.seconds,
                      onChanged: (String value) {
                        doubleState.didChange(doubleState.value!.copyWith(
                          seconds: value,
                        ));
                        onChanged?.call(doubleState.value!);
                      },
                      onUserNotAbleToTypeValidator: (value) => null,
                      onlyInt: true,
                      isDoubleStepperSeconds: true,
                      canGoDown: (value) {
                        if (doubleState.value!.seconds.isEmpty) {
                          return false;
                        }
                        return doubleState.value?.seconds != '0';
                      },
                      canGoUp: (value) {
                        if (doubleState.value?.minutes == '60') {
                          return false;
                        }
                        if (doubleState.value!.minutes.isNotEmpty && doubleState.value!.seconds.isNotEmpty) {
                          return int.parse(doubleState.value!.seconds) < 59;
                        }

                        return false;
                      },
                    ),
                    if (state.hasError) ErrorFieldWidget(state.errorText ?? ''),
                  ].intersperse(const SizedBox(height: 8)),
                ],
              );
            });

  @override
  FormFieldState<DoubleValue<String>> createState() {
    return InputDoubleFieldState();
  }
}

class InputDoubleFieldState extends FormFieldState<DoubleValue<String>> {
  @override
  void didUpdateWidget(covariant InputDoubleField oldWidget) {
    if (!widget.enabled && value != oldWidget.value) {
      Future.microtask(() => reset());
    }
    if (oldWidget.value != (widget as InputDoubleField).value) {
      setValue((widget as InputDoubleField).value);
    }
    super.didUpdateWidget(oldWidget);
  }
}
