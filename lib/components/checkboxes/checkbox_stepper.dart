import 'package:flutter/material.dart';
import 'package:zsdemo_app/components/checkboxes/checkbox_text.dart';
import 'package:zsdemo_app/components/input_fields/input_number_stepper.dart';

class ZSCheckboxStepper extends StatefulWidget {
  final String label;
  final bool initialChecked;
  final void Function(String?) onChange;
  final String? value;
  final String? Function(String?) validator;
  final FormFieldValidator<String>? onUserNotAbleToTypeValidator;
  final bool onlyInt;
  final bool signed;
  final bool canType;
  final bool hasButtons;
  final bool Function(String value) canGoUp;
  final bool Function(String value) canGoDown;
  final String? initValue;
  const ZSCheckboxStepper({
    Key? key,
    required this.label,
    this.initialChecked = false,
    required this.onChange,
    required this.value,
    required this.canType,
    required this.validator,
    this.onlyInt = false,
    this.signed = true,
    this.onUserNotAbleToTypeValidator,
    this.hasButtons = true,
    required this.canGoUp,
    required this.canGoDown,
    this.initValue,
  }) : super(key: key);

  @override
  State<ZSCheckboxStepper> createState() => _ZSCheckboxStepperState();
}

class _ZSCheckboxStepperState<T extends String> extends State<ZSCheckboxStepper> with AutomaticKeepAliveClientMixin {
  late bool _checked;

  bool get checked => _checked || staticValue;

  set checked(bool checked) {
    _checked = checked;
  }

  bool get staticValue => widget.value != null && !widget.canType;

  @override
  void initState() {
    super.initState();
    checked = widget.initialChecked;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ZSCheckboxText(
          title: Text(widget.label),
          value: widget.value != null ? true : checked,
          onChanged: widget.canType
              ? (value) {
                  setState(() {
                    checked = value!;
                  });
                  // if we change to not checked, then we emit null to show
                  // nothing is selected
                  if (!checked) widget.onChange(null);
                  if (checked) widget.onChange(widget.initValue ?? '0');
                }
              : null,
        ),
        ZSInputNumberStepperFormField(
          // value: widget.readonly ? Some('') : widget.value,
          value: widget.value,
          canType: checked,
          onChanged: widget.onChange,
          validator: widget.validator,
          onUserNotAbleToTypeValidator: widget.onUserNotAbleToTypeValidator,
          onlyInt: widget.onlyInt,
          signed: widget.signed,
          hasButtons: widget.hasButtons,
          canGoUp: widget.canGoUp,
          canGoDown: widget.canGoDown,
        ),
      ],
    );
  }

  // the marked state is disposed when the page moves
  // since this state is only here, we wanna save it
  @override
  bool get wantKeepAlive => true;
}
