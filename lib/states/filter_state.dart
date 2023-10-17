import 'package:flutter/material.dart';
import 'package:zsdemo_app/app.dart';
import 'package:zsdemo_app/generated/l10n.dart';

final kDefaultDateFilter = DateFilter.allTime;

enum DateFilterKey { allTime, lastDay, last7Days, last30Days, custom }

class FilterData<C, R, A> {
  final Set<C> selectedChips;
  final Set<A>? selectedAdditional;
  final R? picker;
  final String? filterSearch;
  final bool isDefault;

  const FilterData({
    required this.selectedChips,
    required this.selectedAdditional,
    required this.picker,
    required this.isDefault,
    this.filterSearch,
  });

  @override
  int get hashCode => Object.hash(selectedChips, selectedAdditional, picker);

  @override
  operator ==(Object other) =>
      other is FilterData<C, R, A> &&
      other.selectedChips == selectedChips &&
      other.selectedAdditional == selectedAdditional &&
      other.picker == picker &&
      other.filterSearch == filterSearch;
}

class DateFilter {
  final String Function(BuildContext) text;
  final DateFilterKey key;
  final DateTimeRange? Function() range;

  const DateFilter({required this.text, required this.range, required this.key});
  DateFilter.customRange({required this.range})
      : text = ((_) => Loco.current.taskFilterCustomRange),
        key = DateFilterKey.custom;

  static final allTime = DateFilter(
    range: () => null,
    text: ((_) => Loco.current.taskFilterDateFilterAllTime),
    key: DateFilterKey.allTime,
  );
  static final lastDay = DateFilter(
    range: () => DateTimeRange(start: DateTime.now().subtract(const Duration(days: 1)), end: DateTime.now()),
    text: ((_) => Loco.current.taskFilterDateFilterLastDay),
    key: DateFilterKey.lastDay,
  );
  static final last7Days = DateFilter(
    range: () => DateTimeRange(start: DateTime.now().subtract(const Duration(days: 7)), end: DateTime.now()),
    text: ((_) => Loco.current.taskFilterDateFilterLast7Days),
    key: DateFilterKey.last7Days,
  );
  static final last30Days = DateFilter(
    range: () => DateTimeRange(start: DateTime.now().subtract(const Duration(days: 30)), end: DateTime.now()),
    text: ((_) => Loco.current.taskFilterDateFilterLast30Days),
    key: DateFilterKey.last30Days,
  );

  static List<DateFilter> get values {
    return List.unmodifiable(
      [
        allTime,
        lastDay,
        last7Days,
        last30Days,
        DateFilter.customRange(range: () => null),
      ],
    );
  }

  String textDefault(BuildContext context) => this == kDefaultDateFilter ? '${text(context)} (default)' : text(context);

  @override
  int get hashCode => text.hashCode;

  @override
  operator ==(Object other) =>
      identical(other, this) || (other is DateFilter && other.text == text && other.key == key && other.range == range);

  @override
  String toString() {
    return text(navigatorKey.currentContext!);
  }
}
