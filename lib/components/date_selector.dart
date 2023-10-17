import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/styles/icons.dart';
import 'package:zsdemo_app/common/utils/date.dart';

class ZSDateSelector extends StatelessWidget {
  final double width;
  final double height;
  final DateTime initialDate;
  final Function(DateTime) onSelect;
  final DateTimeRange range;
  final bool readonly;

  String get _dateAsString => formatDateFilterMD24.format(initialDate.toLocal());

  const ZSDateSelector({
    Key? key,
    required this.width,
    this.height = 44,
    this.readonly = false,
    required this.initialDate,
    required this.onSelect,
    required this.range,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: readonly
          ? null
          : () async {
              final date = await showDatePicker(
                  context: context,
                  initialDate: initialDate,
                  firstDate: range.start,
                  lastDate: range.end,
                  selectableDayPredicate: (date) =>
                      date.isAfter(range.start.subtract(const Duration(days: 1))) && date.isBefore(range.end.add(const Duration(days: 1))),
                  builder: (context, widget) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                          colorScheme: ThemeData.light().colorScheme.copyWith(
                                primary: ZSColors.primary,
                              )),
                      child: widget!,
                    );
                  });
              if (date != null && context.mounted) {
                final DateTime now = DateTime.now().toUtc();
                final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(initialDate.toLocal()),
                    builder: (context, widget) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                            colorScheme: ThemeData.light().colorScheme.copyWith(
                                  primary: ZSColors.primary,
                                )),
                        child: widget!,
                      );
                    });
                if (time != null) {
                  onSelect(DateTime(date.year, date.month, date.day, time.hour, time.minute));
                  final DateTime chosenDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
                  if (chosenDateTime.isAfter(now)) {
                    onSelect(chosenDateTime);
                  } else if (initialDate.isAfter(now)) {
                    onSelect(initialDate);
                  } else {
                    onSelect(now.add(const Duration(minutes: 5)).toUtc());
                  }
                }
              }
            },
      child: ZSDateTimeSelector(
        width: width,
        height: height,
        dateTimeString: _dateAsString,
      ),
    );
  }
}

class ZSTimeSelector extends StatelessWidget {
  final double width;
  final double height;
  final TimeOfDay? selectedTime;
  final Function(TimeOfDay) onSelect;
  final bool readonly;

  String get _timeAsString => selectedTime != null ? '${selectedTime!.hour} : ${selectedTime!.minute}' : '';

  const ZSTimeSelector({
    Key? key,
    required this.width,
    this.height = 44,
    required this.selectedTime,
    required this.onSelect,
    required this.readonly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            builder: (context, widget) {
              return Theme(
                data: ThemeData.light().copyWith(
                    colorScheme: ThemeData.light().colorScheme.copyWith(
                          primary: ZSColors.primary,
                        )),
                child: widget!,
              );
            });
        if (time != null) onSelect(time);
      },
      child: ZSDateTimeSelector(
        width: width,
        height: height,
        dateTimeString: _timeAsString,
        readonly: readonly,
      ),
    );
  }
}

class ZSDateTimeSelector extends StatelessWidget {
  final double width;
  final double height;
  final String dateTimeString;
  final bool readonly;

  const ZSDateTimeSelector({
    Key? key,
    required this.width,
    this.readonly = false,
    this.height = 44,
    required this.dateTimeString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: ZSColors.neutralLight40),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        color: readonly ? ZSColors.neutralLight20 : ZSColors.neutralLight10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: readonly ? ZSColors.neutralN80 : ZSColors.secondaryDark),
              child: Text(dateTimeString)),
          const Icon(
            ZSIcons.calendar,
            color: ZSColors.neutralN80,
            size: 18,
          )
        ],
      ),
    );
  }
}
