import 'package:equatable/equatable.dart';

import 'package:zsdemo_app/generated/l10n.dart';

class ListEventsResponse {
  String? nextCursor;
  List<EventsData> events;

  ListEventsResponse({this.nextCursor, required this.events});

  factory ListEventsResponse.fromMap(Map<String, dynamic> json) {
    return ListEventsResponse(
      nextCursor: json['nextCursor'],
      events: json['results'] != null ? (json['results'] as List).map((i) => EventsData.fromMap(i)).toList() : [],
    );
  }

  factory ListEventsResponse.parseEvents(dynamic data) {
    return ListEventsResponse.fromMap(data);
  }
}

class EventsData {
  String? type;
  Event? event;
  EventDecode? decode;
  Analytics? analytics;
  EventsData({
    this.event,
    this.type,
    this.decode,
    this.analytics,
  });

  EventsData copyWith({
    Event? event,
    String? type,
    EventDecode? decode,
    Analytics? analytics,
  }) {
    return EventsData(
      event: event ?? this.event,
      type: type ?? this.type,
      decode: decode ?? this.decode,
      analytics: analytics ?? this.analytics,
    );
  }

  factory EventsData.fromMap(Map<String, dynamic> map) {
    return EventsData(
      type: map['type'],
      event: map['event'] != null ? Event.fromMap(map['event']) : null,
      decode: map['decode'] != null ? EventDecode.fromMap(map['decode']) : null,
      analytics: map['analytics'] != null ? Analytics.fromMap(map['analytics']) : null,
    );
  }
}

class Event extends Equatable {
  final String? id;
  final DateTime? timestamp;
  final String? deviceId;
  final EventData? data;

  const Event({
    this.id,
    this.timestamp,
    this.deviceId,
    this.data,
  });

  Event copyWith({
    String? id,
    DateTime? timestamp,
    String? deviceId,
    EventData? data,
  }) {
    return Event(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      deviceId: deviceId ?? this.deviceId,
      data: data ?? this.data,
    );
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      timestamp: map['timestamp'] != null ? DateTime.tryParse(map['timestamp'] as String) : null,
      deviceId: map['deviceId'],
      data: map['data'] != null ? EventData.fromMap(map['data']) : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        timestamp,
        deviceId,
        data,
      ];
}

class EventData {
  String? format;
  String? id;
  String? value;
  int? rssi;

  EventData({this.format, this.id, this.value, this.rssi});

  factory EventData.fromMap(Map<String, dynamic> map) {
    return EventData(
      format: map['format'],
      id: map['id'],
      value: map['value'],
      rssi: map['rssi'],
    );
  }
}

class EventDecode {
  EventTemperature? temperature;

  EventDecode({this.temperature});

  EventDecode copyWith({
    EventTemperature? temperature,
  }) {
    return EventDecode(
      temperature: temperature ?? this.temperature,
    );
  }

  factory EventDecode.fromMap(Map<String, dynamic> map) {
    return EventDecode(
      temperature: EventTemperature.fromMap(map['temperature']),
    );
  }
}

class EventTemperature {
  bool? alert;
  num? deviation;
  String? format;
  String? taskId;
  num? sample;

  EventTemperature({this.alert, this.deviation, this.format, this.taskId, this.sample});

  EventTemperature copyWith({
    bool? alert,
    num? deviation,
    String? format,
    String? taskId,
    num? sample,
  }) {
    return EventTemperature(
      alert: alert ?? this.alert,
      deviation: deviation ?? this.deviation,
      format: format ?? this.format,
      taskId: taskId ?? this.taskId,
      sample: sample ?? this.sample,
    );
  }

  factory EventTemperature.fromMap(Map<String, dynamic> map) {
    return EventTemperature(
      alert: map['alert'],
      deviation: map['deviation'],
      format: map['format'],
      taskId: map['taskId'],
      sample: map['sample'],
    );
  }

  String get eventType => alert == true ? Loco.current.alarm : Loco.current.eventReading;
}

class Analytics {
  final DateTime? recordedTimestamp;
  final bool taskAlarm;

  Analytics({
    this.recordedTimestamp,
    required this.taskAlarm,
  });

  Analytics copyWith({
    DateTime? recordedTimestamp,
    bool? taskAlarm,
  }) {
    return Analytics(
      recordedTimestamp: recordedTimestamp ?? this.recordedTimestamp,
      taskAlarm: taskAlarm ?? this.taskAlarm,
    );
  }

  factory Analytics.fromMap(Map<String, dynamic> map) {
    return Analytics(
      recordedTimestamp: map['recordedTimestamp'] != null ? DateTime.parse(map['recordedTimestamp'] as String) : null,
      taskAlarm: map['meta']['data']['task_alarm'] != null ? map['meta']['data']['task_alarm'] as bool : false,
    );
  }
}
