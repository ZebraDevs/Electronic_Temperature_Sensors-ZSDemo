import 'package:flutter/material.dart';

const String urlOSSAttributions =
    'https://www.zebra.com/us/en/about-zebra/company-information/legal/open-source-usage.html';

const String managementServiceInfoEndpoint = '/internal/management/info';
const String baseSensorEndpoint = '/devices';
const String getSensorsEndpoint = '$baseSensorEndpoint/environmental-sensors';
const String sensorEnrollmentEndpoint = '$baseSensorEndpoint/sensor-enrollments';
const String taskEndpoint = '/environmental/tasks';
const String datalakeAPI = '/data/environmental/tasks';
const String authTokenEndpoint = '/devices/credentials/token';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
