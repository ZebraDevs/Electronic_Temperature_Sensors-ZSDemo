import 'package:flutter/material.dart';
import 'package:zsdemo_app/components/checkboxes/checkbox_text.dart';
import 'package:zsdemo_app/components/input_fields/input_double_field.dart';

// I wanna pass Some and None also sometimes, aka without the Option
class ZSDoubleCheckboxStepper extends StatefulWidget {
  final String label;
  final bool initialChecked;
  final ValueChanged<DoubleValue<String>?> onChange;
  final DoubleValue<String>? value;
  final bool onlyInt;
  final String minutesLabel;
  final String secondsLabel;
  final bool canType;
  final Widget? title;
  final Widget? subtitle;
  final bool canCheck;

  const ZSDoubleCheckboxStepper({
    Key? key,
    required this.label,
    this.initialChecked = false,
    required this.onChange,
    required this.value,
    this.onlyInt = false,
    this.canType = true,
    required this.minutesLabel,
    required this.secondsLabel,
    this.canCheck = true,
    this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  State<ZSDoubleCheckboxStepper> createState() => _ZSCheckboxStepperState();
}

class _ZSCheckboxStepperState<T extends String?> extends State<ZSDoubleCheckboxStepper> with AutomaticKeepAliveClientMixin {
  late bool _checked;

  bool get checked => _checked || staticValue;

  set checked(bool checked) {
    _checked = checked;
  }

  final key = GlobalKey<FormFieldState<DoubleValue<String>>>();
  @override
  void initState() {
    super.initState();
    checked = widget.initialChecked;
  }

  @override
  void didUpdateWidget(ZSDoubleCheckboxStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.canCheck != oldWidget.canCheck) {
      Future.microtask(() {
        if (widget.canCheck == false) {
          uncheckAndResetValue(false);
        }
      });
    }
  }

  // bool get effectiveChecked => (widget.value.fold(() => true, (value) => value != '')) ? true : checked;
  bool get staticValue => widget.value != null && !widget.canType;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ZSCheckboxText(
          title: Flexible(
            child: Text(
              widget.label,
              maxLines: 2,
            ),
          ),
          value: checked,
          onChanged: widget.canType && widget.canCheck
              ? (value) {
                  uncheckAndResetValue(value!);
                }
              : null,
        ),
        InputDoubleField(
          minutesLabel: widget.minutesLabel,
          secondsLabel: widget.secondsLabel,
          value: widget.value ?? const DoubleValue<String>('', ''),
          canType: checked,
          onChanged: (value) {
            widget.onChange(value);
          },
        ),
      ],
    );
  }

  /// When you unselect a block, you wanna delete the value as well
  /// The way to do that is to emit None(), which will go through the state and come back
  /// to the same component in the next cycle and, since it is None, it will disappear from the text field
  void uncheckAndResetValue(bool value) {
    debugPrint('chanign value');
    setState(() {
      checked = value;
    });

    // if we change to not checked, then we emit null to show
    // nothing is selected
    debugPrint(checked.toString());
    if (!checked) widget.onChange(null);
    if (checked) widget.onChange(const DoubleValue<String>('0', '0'));
  }

  // the marked state is disposed when the page moves
  // since this state is only here, we wanna save it
  @override
  bool get wantKeepAlive => true;
}
