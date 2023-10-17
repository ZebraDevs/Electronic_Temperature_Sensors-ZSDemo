// import 'dart:math' as math;

// import 'package:collection/src/list_extensions.dart';
// import 'package:either_option/either_option.dart';
// import 'package:fixnum/fixnum.dart' as $fixnum;
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:zsdemo_app/common/constants/mock_data.dart';
// import 'package:zsdemo_app/common/utils/chart.dart';
// import 'package:zsdemo_app/components/charts/line_chart.dart';
// import 'package:zsdemo_app/generated/l10n.dart';
// import 'package:zsdemo_app/models/error.dart';
// import 'package:zsdemo_app/services/grpcs/envirovue/common/messages.pb.dart';
// import 'package:zsdemo_app/services/grpcs/google/protobuf/timestamp.pb.dart';
// import 'package:zsdemo_app/services/grpcs/google/protobuf/wrappers.pb.dart';
// import 'package:zsdemo_app/states/base_handler_state.dart';
// import 'package:zsdemo_app/states/base_state.dart';
// import 'package:zsdemo_app/states/filter_state.dart';
// ;

// DateTimeRange getDefaultRange() {
//   return DateTimeRange(start: DateTime.now().subtract(const Duration(days: 1)), end: DateTime.now());
// }

// DateTimeRange getRange(List<Reading> readings) {
//   if (readings.isEmpty)
//     return DateTimeRange(start: DateTime.now(), end: DateTime.now().add(const Duration(minutes: 1)));
//   final first = readings.first.time.toDateTime();
//   final last = readings.last.time.toDateTime();
//   return DateTimeRange(start: first, end: last);
// }

// const kMaxGraphPoints = 400.0;

// typedef DateTimeBuilder = DateTimeRange Function();
// typedef DateTimeLabelBuilder = String Function({required DateTimeRange range});

// class ZSReadingParser extends ZSChartTypeParser<Reading> {
//   @override
//   Reading fromOffset(Offset offset) {
//     return Reading(time: Timestamp(seconds: $fixnum.Int64(offset.dx.toInt())), data: FloatValue(value: offset.dy));
//   }

//   @override
//   Offset toOffset(Reading value) {
//     return Offset(value.time.seconds.toDouble(), value.data.value);
//   }

//   /// Gets the X axis labels for the graph. For example, 5:12   5:16    5:20    05:25
//   ///
//   ///
//   /// complexity:
//   ///
//   /// O(1)
//   @override
//   List<String> getXAxisLabels(List<Reading> values, List<Reading> firstLast) {
//     // this function is super intensive, call rarely and don't depend on it
//     singleGetXAxisLabel(Reading value, DateTimeRange range) {
//       // evalueate for one reading, the range is passed becasuse I don't want to calculate 6 times
//       // because it is super expensive
//       final dateTime = value.time.toDateTime().toLocal();
//       final duration = range.duration;
//       if (duration.inDays < 1) {
//         return formatMinutesSeconds.format(dateTime);
//       }
//       return formatMonthDate.format(dateTime);
//     }

//     late final DateTimeRange range;
//     if (firstLast.isEmpty) {
//       range = getDefaultRange();
//     } else {
//       range = getRange(firstLast);
//     }
//     // values is 6 elements
//     // all is 16,000 elements
//     // Note for performance
//     return values
//         .map((value) => singleGetXAxisLabel(value, range))
//         .toList(); // O(1), since there are only about 6 values on the X axis
//   }

//   @override
//   List<String> getYAxisLabels(List<Reading> values) {
//     return values.map((reading) => '${reading.data.value.toStringAsFixed(1)}°C').toList();
//   }

//   @override
//   Color getColorForLineIndex(int index) {
//     return getGraphColorByIndex(index);
//   }
// }

// class GraphReadingsUIData {
//   final Text text;
//   final Icon? icon;

//   const GraphReadingsUIData({required this.text, this.icon});

//   @override
//   bool operator ==(Object other) => other is GraphReadingsUIData && text == other.text && icon == other.icon;
//   @override
//   int get hashCode => Object.hash(text, icon);
// }

// class GraphReadingsInterval extends DateFilter {
//   GraphReadingsInterval(
//       {required String Function(BuildContext) text, required DateTimeRange? range, required DateFilterKey key})
//       : super(key: key, text: text, range: () => range);
//   static final fromStart = GraphReadingsInterval(
//     range:
//         DateTimeRange(start: DateTime.fromMicrosecondsSinceEpoch(0), end: DateTime.now().add(const Duration(days: 10))),
//     text: (context) => Loco.current.sensorDetailGraphFromStart,
//     key: DateFilterKey.allTime,
//   );
//   static final days7Ago = GraphReadingsInterval(
//     range: DateTimeRange(start: DateTime.now().subtract(const Duration(days: 7)), end: DateTime.now()),
//     text: (context) => Loco.current.sensorDetailGraph5d,
//     key: DateFilterKey.last7Days,
//   );

//   static GraphReadingsInterval get defaultAgo => fromStart;
//   GraphReadingsInterval.dateRange({DateTime? from, DateTime? to})
//       : this(
//           range: from == null || to == null ? null : DateTimeRange(start: from, end: to),
//           text: (context) => () {
//             if (from != null && to != null) {
//               return '${formatShort.format(from)} - ${formatShort.format(to)}';
//             }
//             return Loco.current.sensorDetailGraphDateRange;
//           }(),
//           key: DateFilterKey.custom,
//         );

//   @override
//   bool operator ==(Object other) {
//     return other is GraphReadingsInterval && key == other.key;
//   }

//   @override
//   int get hashCode {
//     return key.hashCode;
//   }
// }

// class SensorDetailGraphState extends BaseState
//     with
//         BaseHandlerState<List<ColoredPoints<Reading, PointsFilterMetadata>>>,
//         BaseHandlerListMixin<ColoredPoints<Reading, PointsFilterMetadata>,
//             List<ColoredPoints<Reading, PointsFilterMetadata>>>,
//         BaseHandlerSimpleListMixin<ColoredPoints<Reading, PointsFilterMetadata>> {
//   final Map<DateFilterKey, GraphReadingsInterval> intervalValues = {
//     DateFilterKey.allTime: GraphReadingsInterval.fromStart,
//     DateFilterKey.custom: GraphReadingsInterval.dateRange(),
//   };
//   Map<SensorDetail, bool> sensors = {};

//   void setNewFilterValue(DateFilterKey key, GraphReadingsInterval value) {
//     intervalValues[key] = value;
//     interval = key;
//   }

//   @override
//   bool get isDataEmpty => data.every((element) => element.isEmpty);

//   MatchedSelection<Reading>? _selectedReading;

//   MatchedSelection<Reading>? get selectedReading => _selectedReading;

//   set selectedReading(MatchedSelection<Reading>? selectedReading) {
//     _selectedReading = selectedReading;
//     notifyListeners();
//   }

//   LineChartLimits? _limits;

//   LineChartLimits? get limits => _limits;

//   final Map<double, double> _readingsData = {};

//   Map<double, double> get readingsData => _readingsData;

//   DateFilterKey _interval = DateFilterKey.allTime;

//   DateFilterKey get interval => _interval;

//   set interval(DateFilterKey interval) {
//     _interval = interval;
//     busyFetch();
//   }

//   // The ?? is to suppress the warning
//   GraphReadingsInterval get intervalValue => intervalValues[interval] ?? GraphReadingsInterval.defaultAgo;

//   SensorDetailGraphState() : super(busy: true);

//   set sensorDetail(List<SensorDetail> sensorDetails) {
//     bool diff = false;
//     final list = sensors.entries.toList();
//     if (list.length != sensorDetails.length) {
//       diff = true;
//     }
//     // no diff yet, go through it then
//     if (!diff) {
//       for (int i = 0; i < list.length; i++) {
//         final elementDiff = list[i].key.sensorTaskDetail.sensorTask.readings.length !=
//             sensorDetails[i].sensorTaskDetail.sensorTask.readings.length;
//         if (elementDiff) {
//           diff = true;
//         }
//       }
//     }
//     // if after thorough checking, still no diff, don't refresh the graph
//     if (!diff) {
//       return;
//     }
//     sensors = {for (final sensor in sensorDetails) sensor: true};
//     _limits = LineChartLimits(
//       lowerLimit: sensorDetails[0].sensorTaskDetail.sensorTask.details.hasAlarmLowTemp()
//           ? sensorDetails[0].sensorTaskDetail.sensorTask.details.ensureAlarmLowTemp().value
//           : null,
//       upperLimit: sensorDetails[0].sensorTaskDetail.sensorTask.details.hasAlarmHighTemp()
//           ? sensorDetails[0].sensorTaskDetail.sensorTask.details.alarmHighTemp.value
//           : null,
//     );
//     busyFetch();
//   }

//   Future<void> getDataFromService() async {
//     return whileBusy(() async {
//       await Future.delayed(const Duration(seconds: 3));
//       sensorDetail = [mockSensorDetailObject()];
//     });
//   }

//   // @override
//   // Future<Either<UserLevelError, List<ColoredPoints<Reading, PointsFilterMetadata>>>> fetchData() async {
//   //   try {
//   //     return Right(await compute(computeProcessReadings, FilterArguments(sensors, intervalValue, limits)));
//   //   } catch (e) {
//   //     return Left(GenericUserError(message: e.toString()));
//   //   }
//   // }

//   // void setSensorDetailEnabled(SensorDetail key, int index, bool value) {
//   //   sensors[key] = value;
//   //   data[index] = ColoredPoints.withData(data[index], data[index].additionalData!.copyWith(enabled: value));
//   //   notifyListeners();
//   // }
// }

// class FilterArguments {
//   // Map<SensorDetail, bool> readings;
//   GraphReadingsInterval intervalValue;
//   LineChartLimits? limits;

//   FilterArguments(/*this.readings,*/ this.intervalValue, this.limits);
// }

// Future<List<ColoredPoints<Reading, PointsFilterMetadata>>> filterReadings(FilterArguments args) async {
//   // we assume the sets of points lie on top of each other
//   final range = args.intervalValue.range();
//   if (range == null) {
//     // edge case range is null for some reason
//     return args.readings.entries
//         .map((readings) => ColoredPoints<Reading, PointsFilterMetadata>.withData(
//             readings.key.sensorTaskDetail.sensorTask.readings,
//             PointsFilterMetadata(0, readings.key.sensorTaskDetail.sensorTask.readings.length, 1, true)))
//         .toList();
//   }
//   return addFilterMetadata(args.readings.entries, range);
// }

// List<ColoredPoints<Reading, PointsFilterMetadata>> groupReadings(
//     List<ColoredPoints<Reading, PointsFilterMetadata>> readings, LineChartLimits? _) {
//   return readings.map((data) {
//     // because of min and max, we are adding twice as many points
//     const actualMaxGraphPoints = kMaxGraphPoints / 2;
//     if (data.length <= actualMaxGraphPoints) {
//       return data;
//     }
//     final k = (data.length / actualMaxGraphPoints).ceil();
//     final first = data.first;
//     final last = data.last;
//     return data.reduceToList(
//       (i, acc, _) {
//         if (i % k == 0) {
//           final page = (i / k).floor();

//           final isFirstPage = page == 0;
//           final isLastPage = page == actualMaxGraphPoints - 1;
//           final firstIndex = page * k + (isFirstPage ? 1 : 0); // remove first element on first page
//           final lastIndex = page * k + k - (isLastPage ? 1 : 0); // remove last element on last page
//           final sample = data.slice(firstIndex, math.min(lastIndex, data.length - 1));
//           var min = sample[0];
//           var max = sample[0];

//           for (var item in sample) {
//             if (item.data.value < min.data.value) {
//               min = item;
//             }

//             if (item.data.value > max.data.value) {
//               max = item;
//             }
//           }

//           return acc..addAll(min.time.toDateTime().isAfter(max.time.toDateTime()) ? [max, min] : [min, max]);
//         }
//         return acc;
//       },
//       ColoredPoints.withData([first], data.additionalData!),
//       data.additionalData!.filterStartIndex,
//       data.additionalData!.filterEndIndex,
//     )..add(last);
//   }).toList();
// }

// Future<List<ColoredPoints<Reading, PointsFilterMetadata>>> computeProcessReadings(FilterArguments args) async {
//   // Always sorted
//   return groupReadings(await filterReadings(args), args.limits);
// }
