import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/styles/icons.dart';

class ZSTextFormField extends StatefulWidget {
  final Widget? title;
  final Widget? description;
  final String? hint;
  final String? helper;
  final String? initialValue;
  final bool? obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final String? Function(String?)? validator;
  final bool isMandatory;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onTap;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final FormField? formField;
  final TextAlign textAlign;
  final bool enabled;
  final bool? isTextArea;
  final ValueChanged<String>? onFieldSubmitted;
  final int? maxLength;
  final AutovalidateMode? autovalidateMode;
  final bool showCounter;
  final String? errorText;

  const ZSTextFormField({
    Key? key,
    this.title,
    this.description,
    this.hint,
    this.helper,
    this.initialValue,
    this.obscureText,
    this.controller,
    this.keyboardType,
    this.inputAction,
    this.validator,
    this.isMandatory = false,
    this.onSaved,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.inputFormatters,
    this.formField,
    this.textAlign = TextAlign.start,
    this.enabled = true,
    this.isTextArea = false,
    this.onFieldSubmitted,
    this.maxLength,
    this.autovalidateMode,
    this.showCounter = true,
    this.errorText,
  }) : super(key: key);

  // Name Field
  factory ZSTextFormField.name({
    Key? key,
    Widget? title,
    Widget? description,
    String? hint,
    String? helper,
    String? initialValue,
    bool isMandatory = false,
    Icon? prefixIcon,
    Icon? suffixIcon,
    TextEditingController? controller,
    String? Function(String?)? validator,
    TextInputAction? inputAction,
    Function(String?)? onSaved,
    Function(String)? onChanged,
    VoidCallback? onEditingComplete,
    VoidCallback? onTap,
    bool enabled = true,
    int? maxLength,
    AutovalidateMode? autovalidateMode,
  }) {
    return ZSTextFormField(
      key: key,
      title: title,
      description: description,
      hint: hint,
      helper: helper,
      initialValue: initialValue,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      controller: controller,
      inputAction: inputAction,
      onSaved: onSaved,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onTap: onTap,
      obscureText: false,
      keyboardType: TextInputType.name,
      validator: validator,
      isMandatory: isMandatory,
      formField: FormField.name,
      // inputFormatters: [FilteringTextInputFormatter.deny(RegExp(" "))],
      enabled: enabled,
      maxLength: maxLength,
      autovalidateMode: autovalidateMode,
    );
  }

  @override
  State<ZSTextFormField> createState() => _ZSTextFormFieldState();
}

class _ZSTextFormFieldState extends State<ZSTextFormField> {
  bool isValid = true;

  @override
  Widget build(BuildContext context) {
    Widget? prefixWidget = widget.prefixIcon != null
        ? IconTheme.merge(
            data: Theme.of(context).iconTheme.copyWith(color: ZSColors.neutralN200),
            child: widget.prefixIcon!,
          )
        : null;

    Widget? suffixWidget = widget.suffixIcon != null
        ? IconTheme.merge(
            data: Theme.of(context).iconTheme.copyWith(color: ZSColors.neutralN200),
            child: widget.suffixIcon!,
          )
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.labelLarge!,
              maxLines: 2,
              child: widget.title!,
            ),
          ),
        if (widget.description != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyMedium!,
              maxLines: 10,
              child: widget.description!,
            ),
          ),
        TextFormField(
          controller: widget.controller,
          style: Theme.of(context).textTheme.bodyLarge!,
          initialValue: widget.initialValue,
          maxLines: widget.isTextArea == true ? 3 : 1,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          obscureText: widget.obscureText ?? false,
          textAlign: widget.textAlign,
          decoration: InputDecoration(
            enabled: widget.enabled,
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ZSColors.neutralLight300),
            hintText: widget.hint,
            hintMaxLines: 1,
            prefixIcon: prefixWidget,
            prefix: prefixWidget != null ? null : Container(width: 12),
            suffixIcon: isValid ? suffixWidget : errorIcon,
            contentPadding: const EdgeInsets.only(left: 0, top: 10, bottom: 10, right: 12),
            prefixIconConstraints: iconConstraints,
            suffixIconConstraints: iconConstraints,
            // we specify the sizing, not the Material spec
            isDense: true,
            errorMaxLines: 2,
            errorText: widget.errorText,
            counterText: widget.showCounter ? null : '',
          ),
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          textInputAction: widget.inputAction,
          validator: widget.validator ??
              (value) {
                String? returnValue;

                setState(() {
                  isValid = returnValue != null ? false : true;
                });
                return returnValue;
              },
          autovalidateMode: widget.autovalidateMode,
          onTap: widget.onTap,
          onSaved: widget.onSaved,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onFieldSubmitted,
          readOnly: widget.readOnly,
        ),
        if (isValid && widget.helper != null)
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: DefaultTextStyle(
              style: Theme.of(context).inputDecorationTheme.errorStyle!.copyWith(color: ZSColors.secondaryDark),
              child: Text(widget.helper!),
            ),
          ),
      ],
    );
  }

  BoxConstraints get iconConstraints => BoxConstraints.tight(const Size.square(44));

  Widget? get errorIcon {
    if (widget.prefixIcon != null || widget.suffixIcon != null) {
      return IconTheme.merge(
        data: Theme.of(context).iconTheme.copyWith(color: ZSColors.error),
        child: const Icon(
          ZSIcons.error,
          size: 22,
        ),
      );
    } else {
      return null;
    }
  }
}

enum FormField { name }
