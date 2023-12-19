import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zsdemo_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zsdemo_app/pages/sensor_page.dart';
import 'package:zsdemo_app/services/shared_preferences_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundMessageHandler(RemoteMessage message) async {
  await SharedPreferencesService.initialize();
  WebhookNotificationService._internal()._showNotification(message);
}

class WebhookNotificationService {
  static final WebhookNotificationService _localNotificationService = WebhookNotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin(); //Used to initialize settings for Android/iOS and for other notification purposes
  final SharedPreferencesService _sharedPrefService = SharedPreferencesService();

  factory WebhookNotificationService() {
    return _localNotificationService;
  }

  void handleReceivedNotificationResponse(NotificationResponse response) {
    if (response.payload == null) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (navigatorKey.currentState != null) {
        navigatorKey.currentState!.pushNamed(
          SensorPage.routeName,
          arguments: response.payload,
        );
      }
    });
  }

  WebhookNotificationService._internal() {
    //Initialization logic
  }

  Future<void> init() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();

    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('ic_launcher_foreground');
    const InitializationSettings settings = InitializationSettings(android: androidSettings);
    await flutterLocalNotificationsPlugin.initialize(settings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
      handleReceivedNotificationResponse(response);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessageHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });
  }

  void _showNotification(RemoteMessage message) {
    List<String>? deviceTaskIds = _sharedPrefService.getTaskIds();
    List<String>? processedWebhookIds = _sharedPrefService.getProcessedWebhookEventIds();
    String notificationContent = message.data.values.toString();
    String webHookTaskId = _parseTaskId(notificationContent);
    String webHookEventId = _parseEventId(notificationContent);

    if (shouldSkipNotification(deviceTaskIds, webHookTaskId, processedWebhookIds, webHookEventId)) {
      return;
    }

    int notificationId = UniqueKey().hashCode;
    String alarmType = _parseAlarmType(notificationContent);
    String serialNumber = _parseSerialNumber(notificationContent);

    AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      "56789",
      "ZSDemoChannel",
      channelDescription: "Channel for pushing webhook alarm notifications",
      importance: Importance.max,
      priority: Priority.max,
      visibility: NotificationVisibility.private,
      autoCancel: false,
      timeoutAfter: 86400000,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.show(
        notificationId, "$alarmType alarm", "Sensor $serialNumber had an alarm", platformChannelSpecifics,
        payload: "$serialNumber:$webHookTaskId");
  }

  bool shouldSkipNotification(List<String>? deviceTaskIds, String webHookTaskId,  List<String>? ignoreWebhookEventIds, String currentWebHookEventId) {
    bool shouldSkip = true;
    //Show if the task was created from this device
    deviceTaskIds?.forEach((taskId) {
      if (taskId == webHookTaskId) {
        shouldSkip =  false;
      }
    });

    //Show if the webhook event hasn't already triggered a notification
    ignoreWebhookEventIds?.forEach((webHookEvent) {
      if (currentWebHookEventId == webHookEvent) {
        shouldSkip =  true;
      }
    });
    _sharedPrefService.storeProcessedWebhookEventId(currentWebHookEventId);
    debugPrint('should skip: $shouldSkip');
    return shouldSkip;
  }

  String _parseAlarmType(String webhookData) {
    String alarmTypeIdentifier = '"alarmType":"';
    String alarmTypeIdentifierTerminator = '"},"coordinates"';
    String alarmType = webhookData.substring(webhookData.indexOf(alarmTypeIdentifier) + alarmTypeIdentifier.length,
        webhookData.indexOf(alarmTypeIdentifierTerminator));
    if (alarmType == "HIGH_LIMIT_ALARM") {
      return "High limit";
    } else if (alarmType == "LOW_LIMIT_ALARM") {
      return "Low limit";
    } else {
      return "Too cold";
    }
  }

  String _parseSerialNumber(String webhookData) {
    String serNumIdentifier = 'beacon","id":"';
    String serNumIdentifierTerminator = '","rssi"';
    return webhookData.substring(webhookData.indexOf(serNumIdentifier) + serNumIdentifier.length,
        webhookData.indexOf(serNumIdentifierTerminator));
  }

  String _parseTaskId(String webhookData) {
    String taskIdIdentifier = 'taskId":"';
    String taskIdIdentifierTerminator = '","alert"';
    return webhookData.substring(webhookData.lastIndexOf(taskIdIdentifier) + taskIdIdentifier.length,
        webhookData.indexOf(taskIdIdentifierTerminator));
  }

  String _parseEventId(String webhookData) {
    String taskIdIdentifier = 'event":{"id":"';
    String taskIdIdentifierTerminator = '","timestamp"';
    debugPrint("Value of eventID: ${webhookData.substring(webhookData.lastIndexOf(taskIdIdentifier) + taskIdIdentifier.length,
        webhookData.indexOf(taskIdIdentifierTerminator))}");
    return webhookData.substring(webhookData.lastIndexOf(taskIdIdentifier) + taskIdIdentifier.length,
        webhookData.indexOf(taskIdIdentifierTerminator));
  }
}
