import 'package:flutter/material.dart';

class SheetStateSection {
  // This is a function, so that it doesn't calculate the Loco right away
  // Only when the widget tree is initialized and there is a context
  // Used to throw error when put directly in the root, so now it is not precomputed immediatelly
  final String Function(BuildContext) title;

  const SheetStateSection({required this.title});
}

class SheetStateDateSection extends SheetStateSection {
  const SheetStateDateSection(
      {required String Function(BuildContext) title, required this.startDate, required this.endDate})
      : super(title: title);
  final DateTime startDate;
  final DateTime endDate;
}

class SheetStateChipSection<C> extends SheetStateSection {
  const SheetStateChipSection({
    required String Function(BuildContext) title,
    required this.allFilterStatuses,
    required this.getText,
  }) : super(title: title);

  final Set<C> allFilterStatuses;
  final String Function(BuildContext) Function(C) getText;
}

class SheetStateRadioSection<R> extends SheetStateSection {
  const SheetStateRadioSection({
    required String Function(BuildContext) title,
    required this.options,
    required this.getText,
    this.canShowInHeader,
    required this.getTextDefault,
    required this.defaultValue,
    String Function(BuildContext) Function(R)? getValueText,
  })  : getValueText = getValueText ?? getText,
        super(title: title);

  final Set<R> options;
  final bool Function(R)? canShowInHeader;
  final String Function(BuildContext) Function(R) getText;
  final String Function(BuildContext) Function(R) getTextDefault;
  final String Function(BuildContext) Function(R) getValueText;
  final R defaultValue;
}

class SheetStateDateRadioSection<R> extends SheetStateRadioSection<R> {
  const SheetStateDateRadioSection({
    required String Function(BuildContext) title,
    required Set<R> allFilterStatuses,
    required String Function(BuildContext) Function(R) getText,
    required String Function(BuildContext) Function(R) getTextDefault,
    // same as getText, but with actualy value for R.custom type, instead of just "Custom"
    String Function(BuildContext) Function(R)? getValueText,
    required this.getInitialOptionValue,
    required R defaultOption,
    required this.getDatePicker,
    required this.dateFilterShouldBeApplied,
    required this.equalTheSameOption,
    bool Function(R)? canShowInHeader,
  }) : super(
          title: title,
          options: allFilterStatuses,
          getText: getText,
          defaultValue: defaultOption,
          getTextDefault: getTextDefault,
          canShowInHeader: canShowInHeader,
          getValueText: getValueText,
        );
  final bool Function(R) dateFilterShouldBeApplied;
  final bool Function(R, R) equalTheSameOption;
  final Widget? Function(R, void Function(R)) getDatePicker; // gives the values and a setter
  // give the option, maybe show a dialog and then tell the option if it was selected depending on the user dialog interaction
  // if returns null, nothing, if returns an option, then the option
  final Future<R> Function(BuildContext, R) getInitialOptionValue;
  SheetStateDateRadioSection<R> copyWith({required Set<R> allFilterStatuses}) {
    return SheetStateDateRadioSection<R>(
      title: title,
      allFilterStatuses: allFilterStatuses,
      getText: getText,
      getTextDefault: getTextDefault,
      defaultOption: defaultValue,
      getDatePicker: this.getDatePicker,
      getInitialOptionValue: this.getInitialOptionValue,
      dateFilterShouldBeApplied: this.dateFilterShouldBeApplied,
      equalTheSameOption: this.equalTheSameOption,
      canShowInHeader: canShowInHeader,
      getValueText: getValueText,
    );
  }

  SheetStateDateRadioSection<R> updatedWithOption(R newOption) {
    final oldOption = options.toList().firstWhere((element) => equalTheSameOption(element, newOption));

    final index = options.toList().indexOf(oldOption);
    final updateOptions = {...options}.toList()
      ..removeAt(index)
      ..insert(index, newOption);
    return copyWith(allFilterStatuses: updateOptions.toSet());
  }
}

class SheetStateRadioIconSection<R> extends SheetStateRadioSection<R> {
  SheetStateRadioIconSection({
    required String Function(BuildContext) title,
    required Set<R> allFilterStatuses,
    required String Function(BuildContext) Function(R) getText,
    required String Function(BuildContext) Function(R) getTextDefault,
    required this.getIcon,
    required R defaultValue,
  }) : super(
          title: title,
          options: allFilterStatuses,
          getText: getText,
          defaultValue: defaultValue,
          getTextDefault: getTextDefault,
        );
  final IconData Function(R) getIcon;
}

class SheetStateChipExtraTextsSection<R> extends SheetStateChipSection<R> {
  SheetStateChipExtraTextsSection({
    required String Function(BuildContext) title,
    required Set<R> allFilterStatuses,
    required String Function(BuildContext) Function(R) getText,
    required this.getExtraText,
  }) : super(
          title: title,
          allFilterStatuses: allFilterStatuses,
          getText: getText,
        );
  final String Function(R) getExtraText;
}

class FilterSheetStateData<C, R, A> {
  final SheetStateChipSection<C> chipSection;
  final SheetStateRadioSection<R>? radioSection;
  final SheetStateChipExtraTextsSection<A>? chipAdditionSection;
  final bool isExpandable;

  const FilterSheetStateData({
    required this.chipSection,
    this.radioSection,
    this.chipAdditionSection,
    this.isExpandable = true,
  });

  FilterSheetStateData<C, R, A> copyWith({required SheetStateDateRadioSection<R> radioSection}) {
    return FilterSheetStateData<C, R, A>(
      chipSection: this.chipSection,
      radioSection: radioSection,
      chipAdditionSection: this.chipAdditionSection,
      isExpandable: this.isExpandable,
    );
  }
}

class SortSheetStateData<S, O> {
  final SheetStateRadioSection<S> sortSection;
  final SheetStateRadioIconSection<O> orderSection;

  const SortSheetStateData({required this.sortSection, required this.orderSection});
}
