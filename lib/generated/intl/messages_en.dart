// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(outOf, total) => "${outOf}/${total} alarm/s";

  static String m1(n, p) => "File with name \"${n}\" is located at \"${p}\"";

  static String m2(sn) => "Could not verify sensor (${sn}) enrollment";

  static String m3(sn) => "Sensor (${sn}) is pending enrollment";

  static String m4(sn) => "Sensor (${sn}) successfully enrolled";

  static String m5(sn) => "We need to enroll this sensor (${sn})";

  static String m6(sn) => "Sensor (${sn}) enrolled on another tenant";

  static String m7(minutes, seconds) =>
      "${minutes} minute/s and ${seconds} second/s";

  static String m8(val) => "(${val} seconds remaining)";

  static String m9(sn) =>
      "Please bring sensor (${sn}) within range of a bridge or your mobile device";

  static String m10(val) => "${val}°C";

  static String m11(val) => "View Alarms (${val})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addSensorEnterIdNumber":
            MessageLookupByLibrary.simpleMessage("Enter serial number"),
        "addSensorsRegisteredDescription": MessageLookupByLibrary.simpleMessage(
            "This sensor is already added to a different tenant."),
        "addSensorsRegisteredLowBatteryDescription":
            MessageLookupByLibrary.simpleMessage(
                "This sensor\'s battery is lower than 5% and cannot be onboarded."),
        "addSensorsRegisteredLowBatteryTitle":
            MessageLookupByLibrary.simpleMessage(
                "Error! Sensor has a low battery"),
        "addSensorsRegisteredTitle": MessageLookupByLibrary.simpleMessage(
            "Error! Sensor already has owner"),
        "addSensorsUnavailableDescription":
            MessageLookupByLibrary.simpleMessage(
                "This sensor is not available and cannot be added."),
        "addSensorsUnavailableTitle": MessageLookupByLibrary.simpleMessage(
            "Error! Sensor is unavailable"),
        "alarm": MessageLookupByLibrary.simpleMessage("Alarm"),
        "alarmHighLimit": MessageLookupByLibrary.simpleMessage("High limit: "),
        "alarmLowLimit": MessageLookupByLibrary.simpleMessage("Low limit: "),
        "alarmSettings": MessageLookupByLibrary.simpleMessage("Alarm Settings"),
        "alarmTemperature": MessageLookupByLibrary.simpleMessage("Temperature"),
        "alarmTime": MessageLookupByLibrary.simpleMessage("Time"),
        "alarmTitle": MessageLookupByLibrary.simpleMessage("Alarm"),
        "alarmType": MessageLookupByLibrary.simpleMessage("Alarm Type"),
        "alarmTypeBatterySaverPlusClear":
            MessageLookupByLibrary.simpleMessage("Battery saver plus clear"),
        "alarmTypeBatterySaverPlusSet":
            MessageLookupByLibrary.simpleMessage("Battery saver plus set"),
        "alarmTypeHighLimitAlarm":
            MessageLookupByLibrary.simpleMessage("High limit alarm"),
        "alarmTypeHighLimitAlarmClear":
            MessageLookupByLibrary.simpleMessage("High limit alarm clear"),
        "alarmTypeLowBattery":
            MessageLookupByLibrary.simpleMessage("Low battery alarm"),
        "alarmTypeLowLimitAlarm":
            MessageLookupByLibrary.simpleMessage("Low limit alarm"),
        "alarmTypeLowLimitAlarmClear":
            MessageLookupByLibrary.simpleMessage("Low limit alarm clear"),
        "alarmTypeTooCold":
            MessageLookupByLibrary.simpleMessage("Too cold alarm"),
        "alarmTypeUnspecified":
            MessageLookupByLibrary.simpleMessage("Unspecified"),
        "alarms": MessageLookupByLibrary.simpleMessage("Alarms"),
        "alarmsCount": m0,
        "alarmsTitle": MessageLookupByLibrary.simpleMessage("Alarms"),
        "and": MessageLookupByLibrary.simpleMessage("and"),
        "androidVersion":
            MessageLookupByLibrary.simpleMessage("Android Version"),
        "apiErrorAborted":
            MessageLookupByLibrary.simpleMessage("Request Aborted"),
        "apiErrorAlreadyExists":
            MessageLookupByLibrary.simpleMessage("Resource Already Exists"),
        "apiErrorCancelled":
            MessageLookupByLibrary.simpleMessage("User Cancelled Operation"),
        "apiErrorDataLoss":
            MessageLookupByLibrary.simpleMessage("Data Loss or Corruption"),
        "apiErrorDeadlineExceeded":
            MessageLookupByLibrary.simpleMessage("Deadline Exceeded"),
        "apiErrorFailedPrecondition": MessageLookupByLibrary.simpleMessage(
            "Operation Rejected Due to Failed Precondition"),
        "apiErrorInternal":
            MessageLookupByLibrary.simpleMessage("Internal Server Error"),
        "apiErrorInvalidArgument":
            MessageLookupByLibrary.simpleMessage("Invalid Argument"),
        "apiErrorNotFound":
            MessageLookupByLibrary.simpleMessage("Entity Not Found"),
        "apiErrorOk": MessageLookupByLibrary.simpleMessage("All Good"),
        "apiErrorOutOfRange":
            MessageLookupByLibrary.simpleMessage("Invalid Range"),
        "apiErrorPermission":
            MessageLookupByLibrary.simpleMessage("Permission Denied"),
        "apiErrorResourceExhausted":
            MessageLookupByLibrary.simpleMessage("Resource Exhausted"),
        "apiErrorUnauthenticated":
            MessageLookupByLibrary.simpleMessage("Authentication Required"),
        "apiErrorUnavailable": MessageLookupByLibrary.simpleMessage(
            "Service is currently unavailable"),
        "apiErrorUnimplemented": MessageLookupByLibrary.simpleMessage(
            "Operation Not Implemented Yet"),
        "appVersionNumber":
            MessageLookupByLibrary.simpleMessage("App Version Number"),
        "associateSensorErrorActive": MessageLookupByLibrary.simpleMessage(
            "Could not associate sensor to task because it is on another task."),
        "associateSensorErrorGeneralTitle":
            MessageLookupByLibrary.simpleMessage("Sensor cannot be used"),
        "associateSensorErrorLowBattery": MessageLookupByLibrary.simpleMessage(
            "Could not associate sensor to task because of a low battery."),
        "associateSensorErrorPendingUnenrollment":
            MessageLookupByLibrary.simpleMessage(
                "Sensor has a pending unenrollment. Bring it in range of a bridge to complete the unenrollment, then scan its QR code again to re-enroll it."),
        "associateSensorErrorTitle": MessageLookupByLibrary.simpleMessage(
            "Failed to associate sensor to task"),
        "associateSensorErrorUnspecified": MessageLookupByLibrary.simpleMessage(
            "Unspecified error associating sensor to task."),
        "associateSensorPendingDescription": MessageLookupByLibrary.simpleMessage(
            "Please wake up the sensor again by pressing its button for 3 seconds before continuing"),
        "associateSensorPendingTitle": MessageLookupByLibrary.simpleMessage(
            "Sensor is in start pending for its task"),
        "associateSensorSendToTaskAttempt":
            MessageLookupByLibrary.simpleMessage(
                "Attempting to send task to sensor..."),
        "associateSensorTaskCreated":
            MessageLookupByLibrary.simpleMessage("Task successfully created"),
        "authError":
            MessageLookupByLibrary.simpleMessage("Authentication error"),
        "available": MessageLookupByLibrary.simpleMessage("Available"),
        "backendError": MessageLookupByLibrary.simpleMessage("Backend Error"),
        "batteryLevel": MessageLookupByLibrary.simpleMessage("Battery level"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "checkingForTaskAlarms":
            MessageLookupByLibrary.simpleMessage("Checking for task alarms"),
        "checkingForTaskEvents":
            MessageLookupByLibrary.simpleMessage("Checking for task events"),
        "checkingForTaskSensors":
            MessageLookupByLibrary.simpleMessage("Checking for task sensors"),
        "close": MessageLookupByLibrary.simpleMessage("close"),
        "connected": MessageLookupByLibrary.simpleMessage("Connected"),
        "connectionErrorMesssage": MessageLookupByLibrary.simpleMessage(
            "Failed host lookup: check your Internet connection and try again"),
        "continueLabel": MessageLookupByLibrary.simpleMessage("Continue"),
        "copyrightDate": MessageLookupByLibrary.simpleMessage("Copyright ©"),
        "couldNotFetchSensorInformationText": MessageLookupByLibrary.simpleMessage(
            "Please rescan the QR code or re-enter the sensor\'s serial number and try again."),
        "couldNotFetchSensorInformationTitle":
            MessageLookupByLibrary.simpleMessage(
                "Could not fetch the sensor information"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Create Account"),
        "createTaskCreateErrorTitle":
            MessageLookupByLibrary.simpleMessage("Error creating task"),
        "createTaskDelayedError": MessageLookupByLibrary.simpleMessage(
            "Delayed until date/time is required when Start mode is Delay until.."),
        "createTaskErrorMustBe15s": MessageLookupByLibrary.simpleMessage(
            "Interval value must be at least 15 seconds"),
        "createTaskExitDescription": MessageLookupByLibrary.simpleMessage(
            "If you choose to exit the Create Task page, your changes will not be saved. Are you sure you want to exit?"),
        "createTaskExitTitle":
            MessageLookupByLibrary.simpleMessage("Exit Create Task"),
        "createTaskHdlNew": MessageLookupByLibrary.simpleMessage("Create task"),
        "createTaskHdlSensorConfiguration":
            MessageLookupByLibrary.simpleMessage("Sensor configuration"),
        "createTaskHntAlarmSettings": MessageLookupByLibrary.simpleMessage(
            "Alarm will be triggered when temperature is outside the configured threshold."),
        "createTaskHntGeneralDetails": MessageLookupByLibrary.simpleMessage(
            "Enter or edit the task details below"),
        "createTaskHntName":
            MessageLookupByLibrary.simpleMessage("Unique auto generated name"),
        "createTaskHntPassword": MessageLookupByLibrary.simpleMessage(
            "Set a password to stop the task"),
        "createTaskHntPlaceholder":
            MessageLookupByLibrary.simpleMessage("Placeholder"),
        "createTaskHntReadingInterval": MessageLookupByLibrary.simpleMessage(
            "How often the sensor records temperature (minimum of 15 seconds)."),
        "createTaskHntReview": MessageLookupByLibrary.simpleMessage(
            "Leo tortor ornare blandit mollis tristique tortor eu lectus. Etiam semper non a elementum in."),
        "createTaskHntSensorConfiguration":
            MessageLookupByLibrary.simpleMessage("Configure the sensor below"),
        "createTaskHntSensorType": MessageLookupByLibrary.simpleMessage(
            "Select the type of sensor required for this task"),
        "createTaskHntSensorsAmmount": MessageLookupByLibrary.simpleMessage(
            "Set the number of sensors required for the task"),
        "createTaskHntStartMode": MessageLookupByLibrary.simpleMessage(
            "Configure sensor when to start logging"),
        "createTaskHntStartModeDelay": MessageLookupByLibrary.simpleMessage(
            "Delay the start when a sensor reaches a certain temperature, or when a desired amount of time has passed."),
        "createTaskItemButtonPress":
            MessageLookupByLibrary.simpleMessage("On sensor button press"),
        "createTaskItmButtonPress":
            MessageLookupByLibrary.simpleMessage("On sensor button press"),
        "createTaskItmDelayTimeStart": MessageLookupByLibrary.simpleMessage(
            "Delay time to start (minutes)"),
        "createTaskItmDelayUntil":
            MessageLookupByLibrary.simpleMessage("Delay until..."),
        "createTaskItmDelayedUntil":
            MessageLookupByLibrary.simpleMessage("Delayed until date/time"),
        "createTaskItmHighDelay": MessageLookupByLibrary.simpleMessage(
            "High delay in minutes/seconds (optional)"),
        "createTaskItmHighLimit":
            MessageLookupByLibrary.simpleMessage("High limit (°C)"),
        "createTaskItmImmediately":
            MessageLookupByLibrary.simpleMessage("Immediately"),
        "createTaskItmLowDelay": MessageLookupByLibrary.simpleMessage(
            "Low delay in minutes/seconds (optional)"),
        "createTaskItmLowLimit":
            MessageLookupByLibrary.simpleMessage("Low limit (°C)"),
        "createTaskItmTempAbove":
            MessageLookupByLibrary.simpleMessage("Temperature above (°C)"),
        "createTaskItmTempAboveText":
            MessageLookupByLibrary.simpleMessage("Temperature above"),
        "createTaskItmTempBelow":
            MessageLookupByLibrary.simpleMessage("Temperature below (°C)"),
        "createTaskItmTempBelowText":
            MessageLookupByLibrary.simpleMessage("Temperature below"),
        "createTaskLabel":
            MessageLookupByLibrary.simpleMessage("Create a Task"),
        "createTaskLblAlarmSettings":
            MessageLookupByLibrary.simpleMessage("Alarm Settings"),
        "createTaskLblBack": MessageLookupByLibrary.simpleMessage("Back"),
        "createTaskLblComplete":
            MessageLookupByLibrary.simpleMessage("Complete"),
        "createTaskLblCreate": MessageLookupByLibrary.simpleMessage("Create"),
        "createTaskLblCreateTask":
            MessageLookupByLibrary.simpleMessage("Create task"),
        "createTaskLblEnabled": MessageLookupByLibrary.simpleMessage("Enabled"),
        "createTaskLblGeneralDetails":
            MessageLookupByLibrary.simpleMessage("General details"),
        "createTaskLblGeneralSettings":
            MessageLookupByLibrary.simpleMessage("General settings"),
        "createTaskLblName": MessageLookupByLibrary.simpleMessage("Task name"),
        "createTaskLblPassword":
            MessageLookupByLibrary.simpleMessage("Password (optional)"),
        "createTaskLblReadingInterval":
            MessageLookupByLibrary.simpleMessage("Reading interval"),
        "createTaskLblReview": MessageLookupByLibrary.simpleMessage("Review"),
        "createTaskLblSensorType":
            MessageLookupByLibrary.simpleMessage("Sensor type"),
        "createTaskLblSensorsAmmount": MessageLookupByLibrary.simpleMessage(
            "Number of sensors (optional)"),
        "createTaskLblStartMode":
            MessageLookupByLibrary.simpleMessage("Start mode"),
        "createTaskLblStartModeDelay":
            MessageLookupByLibrary.simpleMessage("Start delay"),
        "createTaskReviewText": MessageLookupByLibrary.simpleMessage(
            "Review the task details below"),
        "createTaskSaveCreate":
            MessageLookupByLibrary.simpleMessage("Save and create task"),
        "createTaskSaved":
            MessageLookupByLibrary.simpleMessage("New task created!"),
        "createTaskStep2ErrorMinOne":
            MessageLookupByLibrary.simpleMessage("Minimum delay is 1 second"),
        "createTaskTitleReview":
            MessageLookupByLibrary.simpleMessage("Review & save"),
        "createTaskTxtPassword":
            MessageLookupByLibrary.simpleMessage("Enter a strong password"),
        "dataAPIs":
            MessageLookupByLibrary.simpleMessage("Data and Management APIs"),
        "dataAPIs1": MessageLookupByLibrary.simpleMessage(
            "Note: there are no versions for the API – both individually and collectively"),
        "dataAPIs2": MessageLookupByLibrary.simpleMessage(
            "However, there is a version number (e.g. v2) in the URL path for the REST APIs"),
        "dateTitle": MessageLookupByLibrary.simpleMessage("Date"),
        "done": MessageLookupByLibrary.simpleMessage("Done"),
        "downloadCSV": MessageLookupByLibrary.simpleMessage("Download CSV"),
        "downloadFromGooglePlay":
            MessageLookupByLibrary.simpleMessage("Download from Google Play"),
        "downloadMessageSuccess":
            MessageLookupByLibrary.simpleMessage("File downloaded succesfully"),
        "downloadedCSVpath": m1,
        "downloadedErrored":
            MessageLookupByLibrary.simpleMessage("Downloading failed."),
        "downloadedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "File successfully downloaded."),
        "downloading": MessageLookupByLibrary.simpleMessage("Downloading.."),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "enrollSensolText": MessageLookupByLibrary.simpleMessage(
            "Please wake it up by pressing its button for 3 seconds before continuing."),
        "enrollSensolTextDetailed": MessageLookupByLibrary.simpleMessage(
            "Please wake it up by pressing its button for 3 seconds before continuing.\n\nExiting will leave the sensor unenrolled."),
        "enrollSensorLabel":
            MessageLookupByLibrary.simpleMessage("Enroll Sensor"),
        "enrollSensorNotVerifiedText": MessageLookupByLibrary.simpleMessage(
            "Please wake up the sensor by pressing its button for 3 seconds before trying again.\n\nExiting will leave the sensor enrollment pending."),
        "enrollSensorNotVerifiedTitle": m2,
        "enrollSensorPendingText": MessageLookupByLibrary.simpleMessage(
            "Please wake it up by pressing its button for 3 seconds before continuing.\n\nExiting will leave the sensor enrollment pending."),
        "enrollSensorPendingTitle": m3,
        "enrollSensorSuccessText": MessageLookupByLibrary.simpleMessage(
            "Now that it\'s enrolled, we can create and add it to a task.\n\nExiting will leave the sensor enrolled."),
        "enrollSensorSuccessTitle": m4,
        "enrollSensorTitle": m5,
        "enrollSensorVerify": MessageLookupByLibrary.simpleMessage(
            "Verifying sensor enrollment..."),
        "enrollSensorVerifyDesc":
            MessageLookupByLibrary.simpleMessage("This may take 1-2 minutes."),
        "enrolledSensorText": MessageLookupByLibrary.simpleMessage(
            "This sensor is already enrolled on another tenant and cannot be used.\n\nPlease unenroll it or try another sensor."),
        "enrolledSensorTitle": m6,
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "errorCamera": MessageLookupByLibrary.simpleMessage("Camera error"),
        "errorEmptyNonNegative":
            MessageLookupByLibrary.simpleMessage("Values must be non negative"),
        "errorEmptyNotANumber":
            MessageLookupByLibrary.simpleMessage("Value is not a number"),
        "errorEmptyValue": MessageLookupByLibrary.simpleMessage("Empty value"),
        "errorInvalidQrCode":
            MessageLookupByLibrary.simpleMessage("Invalid QR code"),
        "errorInvalidQrCodeDescription": MessageLookupByLibrary.simpleMessage(
            "Make sure you are scanning the QR code on top of the sensor"),
        "errorLocation": MessageLookupByLibrary.simpleMessage(
            "Couldn\'t get current location"),
        "errorNoInternetConnection": MessageLookupByLibrary.simpleMessage(
            "Request failed. Please check your internet connection and try again."),
        "errorNotEmpty":
            MessageLookupByLibrary.simpleMessage("Value must not be empty"),
        "errorPerformingFirmwareUpdate": MessageLookupByLibrary.simpleMessage(
            "There was an issue performing the firmware update..."),
        "errorPositiveNumber": MessageLookupByLibrary.simpleMessage(
            "Value must be more or equal to zero"),
        "errorServerConneciton": MessageLookupByLibrary.simpleMessage(
            "We are having trouble connecting to the server. Please try again."),
        "errorSettingDeviceOtaMode": MessageLookupByLibrary.simpleMessage(
            "There was an issue setting the device in OTA mode..."),
        "errorTimeout": MessageLookupByLibrary.simpleMessage(
            "Request timed out. Please try again."),
        "event": MessageLookupByLibrary.simpleMessage("Event"),
        "eventReading": MessageLookupByLibrary.simpleMessage("Reading"),
        "eventTaskDetailHighLimit":
            MessageLookupByLibrary.simpleMessage("High limit"),
        "eventTaskDetailLowLimit":
            MessageLookupByLibrary.simpleMessage("Low limit"),
        "eventTaskDetailNoLimits":
            MessageLookupByLibrary.simpleMessage("No limits set"),
        "eventTime": MessageLookupByLibrary.simpleMessage("Time"),
        "eventType": MessageLookupByLibrary.simpleMessage("Event Type"),
        "exceptionCamera":
            MessageLookupByLibrary.simpleMessage("Camera exception"),
        "exit": MessageLookupByLibrary.simpleMessage("Exit"),
        "findViaId": MessageLookupByLibrary.simpleMessage("Find via ID"),
        "firmwareVersion":
            MessageLookupByLibrary.simpleMessage("Firmware Version"),
        "homePageLabel": MessageLookupByLibrary.simpleMessage(
            "Scan the QR code of a sensor to begin"),
        "invalidAuthDescription": MessageLookupByLibrary.simpleMessage(
            "Your refresh token has expired. Try logging in again"),
        "invalidAuthTitle":
            MessageLookupByLibrary.simpleMessage("Session Expired"),
        "labelAbove": MessageLookupByLibrary.simpleMessage("Above"),
        "labelAll": MessageLookupByLibrary.simpleMessage("All"),
        "labelBelow": MessageLookupByLibrary.simpleMessage("Below"),
        "labelEvents": MessageLookupByLibrary.simpleMessage("Events"),
        "labelReadings": MessageLookupByLibrary.simpleMessage("Readings"),
        "labelUntil": MessageLookupByLibrary.simpleMessage("Until"),
        "lastUpdated": MessageLookupByLibrary.simpleMessage("Last Updated"),
        "lblGood": MessageLookupByLibrary.simpleMessage("Good"),
        "lblHigh": MessageLookupByLibrary.simpleMessage("High"),
        "lblLow": MessageLookupByLibrary.simpleMessage("Low"),
        "lblOk": MessageLookupByLibrary.simpleMessage("OK"),
        "license": MessageLookupByLibrary.simpleMessage("License"),
        "logout": MessageLookupByLibrary.simpleMessage("Sign Out"),
        "loopOverride": MessageLookupByLibrary.simpleMessage("Loop Override"),
        "macAddress": MessageLookupByLibrary.simpleMessage("MAC Address"),
        "menuAbout": MessageLookupByLibrary.simpleMessage("About"),
        "menuUpdateFW": MessageLookupByLibrary.simpleMessage("Update Sensor"),
        "minutes": MessageLookupByLibrary.simpleMessage("Minutes"),
        "minutesSeconds": m7,
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "newSensor": MessageLookupByLibrary.simpleMessage("New sensor"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "noEventsFoundMessage": MessageLookupByLibrary.simpleMessage(
            "Please check back in a few minutes"),
        "noEventsFoundTitle": MessageLookupByLibrary.simpleMessage(
            "No events have been recorded"),
        "notAvailable": MessageLookupByLibrary.simpleMessage("Not available"),
        "notSpecified": MessageLookupByLibrary.simpleMessage("Not Specified"),
        "numberOfSensors":
            MessageLookupByLibrary.simpleMessage("Number of Sensors"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "open": MessageLookupByLibrary.simpleMessage("Open"),
        "ossAttributions":
            MessageLookupByLibrary.simpleMessage("OSS Attributions"),
        "permissionCamera":
            MessageLookupByLibrary.simpleMessage("Camera permission"),
        "permissionsNotGranted":
            MessageLookupByLibrary.simpleMessage("Permission not granted"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy policy"),
        "qrScanAgain": MessageLookupByLibrary.simpleMessage("Scan again"),
        "qrScanBusyTryAgain": MessageLookupByLibrary.simpleMessage(
            "Scanner is busy. Please go back and try again."),
        "qrScanCantTakePicture": MessageLookupByLibrary.simpleMessage(
            "Can\'t take picture from camera"),
        "qrScanCouldNotDetect":
            MessageLookupByLibrary.simpleMessage("Could not detect any camera"),
        "qrScanDetectedNothing":
            MessageLookupByLibrary.simpleMessage("Detected Nothing"),
        "qrScanDetecting": MessageLookupByLibrary.simpleMessage("Detecting..."),
        "qrScanPointAtQrcode": MessageLookupByLibrary.simpleMessage(
            "Position the QR code inside the square to capture"),
        "readingInterval":
            MessageLookupByLibrary.simpleMessage("Reading Interval"),
        "registered": MessageLookupByLibrary.simpleMessage("Registered"),
        "retry": MessageLookupByLibrary.simpleMessage("Retry"),
        "scanAnotherSensorLabel":
            MessageLookupByLibrary.simpleMessage("Scan Another Sensor"),
        "scanSensorLabel": MessageLookupByLibrary.simpleMessage("Scan Sensor"),
        "scanTimeRemaining": m8,
        "searching": MessageLookupByLibrary.simpleMessage("Searching..."),
        "seconds": MessageLookupByLibrary.simpleMessage("Seconds"),
        "sensorDetailGraph1D": MessageLookupByLibrary.simpleMessage("1D"),
        "sensorDetailGraph1M": MessageLookupByLibrary.simpleMessage("1M"),
        "sensorDetailGraph5d": MessageLookupByLibrary.simpleMessage("5D"),
        "sensorDetailGraphDateRange":
            MessageLookupByLibrary.simpleMessage("Date range"),
        "sensorDetailGraphFromStart":
            MessageLookupByLibrary.simpleMessage("All"),
        "sensorDetailGraphHintDesc1": MessageLookupByLibrary.simpleMessage(
            "Note, graph contains real data, but it is "),
        "sensorDetailGraphHintDesc2":
            MessageLookupByLibrary.simpleMessage("not"),
        "sensorDetailGraphHintDesc3":
            MessageLookupByLibrary.simpleMessage(" live.\n"),
        "sensorDetailGraphHintDesc4": MessageLookupByLibrary.simpleMessage(
            "To see it live, upload the sensor data to the cloud and refresh"),
        "sensorDetailGraphNoDataFiltersButton":
            MessageLookupByLibrary.simpleMessage("View for all time"),
        "sensorDetailGraphNoDataFiltersSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "There is no data at this period"),
        "sensorDetailGraphNoDataSubtitle": MessageLookupByLibrary.simpleMessage(
            "There is no data as of this moment"),
        "sensorDetailGraphNoDataTitle":
            MessageLookupByLibrary.simpleMessage("No readings"),
        "sensorFWVersion":
            MessageLookupByLibrary.simpleMessage("Sensor FW Version supported"),
        "sensorID":
            MessageLookupByLibrary.simpleMessage("Serial Number of Sensor"),
        "sensorLastUpdated":
            MessageLookupByLibrary.simpleMessage("Last Updated"),
        "sensorName": MessageLookupByLibrary.simpleMessage("Sensor Name"),
        "sensorSdkCannotConnect":
            MessageLookupByLibrary.simpleMessage("Could not connect to sensor"),
        "sensorSdkCannotDecommission": MessageLookupByLibrary.simpleMessage(
            "Could not decommission sensor"),
        "sensorSdkCannotDisconnect": MessageLookupByLibrary.simpleMessage(
            "Could not disconnect from sensor"),
        "sensorSdkCannotDiscover":
            MessageLookupByLibrary.simpleMessage("Could not discover sensors"),
        "sensorSdkCannotFind":
            MessageLookupByLibrary.simpleMessage("Could not find sensors"),
        "sensorSdkCannotWriteAlert": MessageLookupByLibrary.simpleMessage(
            "Could not write immediate alert"),
        "sensorSerialNumber":
            MessageLookupByLibrary.simpleMessage("Sensor Serial Number"),
        "sensorStatus": MessageLookupByLibrary.simpleMessage("Sensor Status"),
        "sensorTaskStatus":
            MessageLookupByLibrary.simpleMessage("Sensor Task Status"),
        "sensorTypeHumidity": MessageLookupByLibrary.simpleMessage("Humidity"),
        "sensorTypeInertial": MessageLookupByLibrary.simpleMessage("Inertial"),
        "sensorTypeLight": MessageLookupByLibrary.simpleMessage("Light"),
        "sensorTypePressure": MessageLookupByLibrary.simpleMessage("Pressure"),
        "sensorTypeTemperature":
            MessageLookupByLibrary.simpleMessage("Temperature"),
        "serialNumber": MessageLookupByLibrary.simpleMessage("Serial Number"),
        "signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
        "signInPageLabel": MessageLookupByLibrary.simpleMessage(
            "Electronic Sensors Demo Mobile Application"),
        "startMode": MessageLookupByLibrary.simpleMessage("Start Mode"),
        "stopTask": MessageLookupByLibrary.simpleMessage("Stop task"),
        "stopTaskError":
            MessageLookupByLibrary.simpleMessage("Error while stopping a task"),
        "stopTaskLoading":
            MessageLookupByLibrary.simpleMessage("Stopping a task"),
        "stopTaskPending":
            MessageLookupByLibrary.simpleMessage("Stopping task"),
        "stopTaskPendingDesc": m9,
        "stopTaskPromptMessage": MessageLookupByLibrary.simpleMessage(
            "This will stop all sensors on this task and will mark it as complete."),
        "stopTaskSuccess": MessageLookupByLibrary.simpleMessage(
            "The task was successfully stopped"),
        "success": MessageLookupByLibrary.simpleMessage("Success"),
        "taskCreateAlarmNotSet": MessageLookupByLibrary.simpleMessage(
            "At least one alarm should be set to continue"),
        "taskCreateDelayMinutes": MessageLookupByLibrary.simpleMessage(
            "Delay time to start can be between 1 and 240 minutes"),
        "taskCreateHighLimits": MessageLookupByLibrary.simpleMessage(
            "Temperature cannot be lower than -39°C and higher than 85°C"),
        "taskCreateHigher": MessageLookupByLibrary.simpleMessage(
            "The High limit must be greater than the Low limit."),
        "taskCreateLowHigher": MessageLookupByLibrary.simpleMessage(
            "The Low limit must be less than the High limit."),
        "taskCreateLowLimits": MessageLookupByLibrary.simpleMessage(
            "Temperature cannot be lower than -40°C and higher than 84°C"),
        "taskCreateSetAlarm":
            MessageLookupByLibrary.simpleMessage("Set at least one"),
        "taskDashboardListFieldTaskEnd":
            MessageLookupByLibrary.simpleMessage("Task end"),
        "taskDashboardListFieldTaskStart":
            MessageLookupByLibrary.simpleMessage("Task start"),
        "taskDetailAlertHighLimitClearLong":
            MessageLookupByLibrary.simpleMessage("High limit clear"),
        "taskDetailAlertHighLimitClearLongVariant":
            MessageLookupByLibrary.simpleMessage("High limit clear"),
        "taskDetailAlertHighLimitClearShort":
            MessageLookupByLibrary.simpleMessage("high limit clear"),
        "taskDetailAlertHighLimitLong":
            MessageLookupByLibrary.simpleMessage("High limit alarms"),
        "taskDetailAlertHighLimitLongVariant":
            MessageLookupByLibrary.simpleMessage("High limit"),
        "taskDetailAlertHighLimitShort":
            MessageLookupByLibrary.simpleMessage("high limit"),
        "taskDetailAlertLowBatteryLong":
            MessageLookupByLibrary.simpleMessage("Low battery"),
        "taskDetailAlertLowBatteryLongVariant":
            MessageLookupByLibrary.simpleMessage("Low battery"),
        "taskDetailAlertLowBatteryShort":
            MessageLookupByLibrary.simpleMessage("low battery"),
        "taskDetailAlertLowLimitClearLong":
            MessageLookupByLibrary.simpleMessage("Low limit clear"),
        "taskDetailAlertLowLimitClearLongVariant":
            MessageLookupByLibrary.simpleMessage("Low limit clear"),
        "taskDetailAlertLowLimitClearShort":
            MessageLookupByLibrary.simpleMessage("low limit clear"),
        "taskDetailAlertLowLimitLong":
            MessageLookupByLibrary.simpleMessage("Low limit alarms"),
        "taskDetailAlertLowLimitLongVariant":
            MessageLookupByLibrary.simpleMessage("Low limit"),
        "taskDetailAlertLowLimitShort":
            MessageLookupByLibrary.simpleMessage("low limit"),
        "taskDetailInfoAddNotes":
            MessageLookupByLibrary.simpleMessage("Add notes"),
        "taskDetailInfoDegree": m10,
        "taskDetailInfoDisabled":
            MessageLookupByLibrary.simpleMessage("Disabled"),
        "taskDetailInfoEnabled":
            MessageLookupByLibrary.simpleMessage("Enabled"),
        "taskDetailInfoHighDelay":
            MessageLookupByLibrary.simpleMessage("High delay:"),
        "taskDetailInfoHighLimit":
            MessageLookupByLibrary.simpleMessage("High limit"),
        "taskDetailInfoLoopOverwrite":
            MessageLookupByLibrary.simpleMessage("Overwrite readings"),
        "taskDetailInfoLowDelay":
            MessageLookupByLibrary.simpleMessage("Low delay:"),
        "taskDetailInfoLowLimit":
            MessageLookupByLibrary.simpleMessage("Low limit"),
        "taskDetailInfoNotSet":
            MessageLookupByLibrary.simpleMessage("Not specified"),
        "taskDetailInfoNumberOfSensors":
            MessageLookupByLibrary.simpleMessage("Number of sensors"),
        "taskDetailInfoReadingInterval":
            MessageLookupByLibrary.simpleMessage("Reading interval"),
        "taskDetailInfoSensorType":
            MessageLookupByLibrary.simpleMessage("Sensor type"),
        "taskDetailInfoStartDelay":
            MessageLookupByLibrary.simpleMessage("Start delay"),
        "taskDetailInfoStartMode":
            MessageLookupByLibrary.simpleMessage("Start mode"),
        "taskDetailInfoStartModeDelayed":
            MessageLookupByLibrary.simpleMessage("Delayed"),
        "taskDetailInfoStartModeImmediately":
            MessageLookupByLibrary.simpleMessage("Immediately"),
        "taskDetailInfoViewEditNotes":
            MessageLookupByLibrary.simpleMessage("View/edit notes"),
        "taskDetailNoNotes":
            MessageLookupByLibrary.simpleMessage("Task has no notes"),
        "taskDetailSensorActiveLong":
            MessageLookupByLibrary.simpleMessage("Active"),
        "taskDetailSensorActiveLongVariant":
            MessageLookupByLibrary.simpleMessage("Active"),
        "taskDetailSensorActiveShort":
            MessageLookupByLibrary.simpleMessage("active"),
        "taskDetailSensorActiveWithAlarmLong":
            MessageLookupByLibrary.simpleMessage("Active with alarm"),
        "taskDetailSensorActiveWithAlarmLongVariant":
            MessageLookupByLibrary.simpleMessage("Active with alarm"),
        "taskDetailSensorActiveWithAlarmShort":
            MessageLookupByLibrary.simpleMessage("active w alarm"),
        "taskDetailSensorActiveWithTechAlarmLong":
            MessageLookupByLibrary.simpleMessage("Active with tech alarm"),
        "taskDetailSensorActiveWithTechAlarmLongVariant":
            MessageLookupByLibrary.simpleMessage("Active with tech alarm"),
        "taskDetailSensorActiveWithTechAlarmShort":
            MessageLookupByLibrary.simpleMessage("active w tech alarm"),
        "taskDetailSensorStoppedPendingColdLong":
            MessageLookupByLibrary.simpleMessage("Stop pending cold"),
        "taskDetailSensorStoppedPendingColdShort":
            MessageLookupByLibrary.simpleMessage("stop pending cold"),
        "taskDetailSensorStoppedPendingLong":
            MessageLookupByLibrary.simpleMessage("Stop pending"),
        "taskDetailSensorStoppedPendingLongColdVariant":
            MessageLookupByLibrary.simpleMessage("Stop pending cold"),
        "taskDetailSensorStoppedPendingLongVariant":
            MessageLookupByLibrary.simpleMessage("Stop pending"),
        "taskDetailSensorStoppedPendingShort":
            MessageLookupByLibrary.simpleMessage("stop pending"),
        "taskDetailSensorUnspecifiedLong":
            MessageLookupByLibrary.simpleMessage("Unspecified"),
        "taskDetailSensorUnspecifiedLongVariant":
            MessageLookupByLibrary.simpleMessage("Unspecified"),
        "taskDetailSensorUnspecifiedShort":
            MessageLookupByLibrary.simpleMessage("unspecified"),
        "taskDetailStartModeDelayed": MessageLookupByLibrary.simpleMessage(
            "Start mode is %1\$, but delayed until is present"),
        "taskDetailStatusActiveLong":
            MessageLookupByLibrary.simpleMessage("Active"),
        "taskDetailStatusActiveLongVariant":
            MessageLookupByLibrary.simpleMessage("Active"),
        "taskDetailStatusActiveShort":
            MessageLookupByLibrary.simpleMessage("active"),
        "taskDetailStatusActiveWithAlarmLong":
            MessageLookupByLibrary.simpleMessage("Active with alarm"),
        "taskDetailStatusActiveWithAlarmShort":
            MessageLookupByLibrary.simpleMessage("active w alarm"),
        "taskDetailStatusActiveWithTechAlarmLong":
            MessageLookupByLibrary.simpleMessage("Active with tech alarm"),
        "taskDetailStatusActiveWithTechAlarmShort":
            MessageLookupByLibrary.simpleMessage("active w tech alarm"),
        "taskDetailStatusSensorsCompletedLong":
            MessageLookupByLibrary.simpleMessage("Completed"),
        "taskDetailStatusSensorsCompletedShort":
            MessageLookupByLibrary.simpleMessage("completed"),
        "taskDetailStatusSensorsRequiredLong":
            MessageLookupByLibrary.simpleMessage("Sensors required"),
        "taskDetailStatusSensorsRequiredShort":
            MessageLookupByLibrary.simpleMessage("sensors required"),
        "taskDetailStatusSensorsStoppedLong":
            MessageLookupByLibrary.simpleMessage("Stopped"),
        "taskDetailStatusSensorsStoppedShort":
            MessageLookupByLibrary.simpleMessage("stopped"),
        "taskDetailStatusStartPendingLong":
            MessageLookupByLibrary.simpleMessage("Start pending"),
        "taskDetailStatusStartPendingLongVariant":
            MessageLookupByLibrary.simpleMessage("Start pending"),
        "taskDetailStatusStartPendingShort":
            MessageLookupByLibrary.simpleMessage("start pending"),
        "taskDetailStatusStopPendingLong":
            MessageLookupByLibrary.simpleMessage("Stop pending"),
        "taskDetailStatusStopPendingLongVariant":
            MessageLookupByLibrary.simpleMessage("Stop pending"),
        "taskDetailStatusStopPendingShort":
            MessageLookupByLibrary.simpleMessage("stop pending"),
        "taskDetailTabEvents": MessageLookupByLibrary.simpleMessage("Events"),
        "taskDetailTabInfo": MessageLookupByLibrary.simpleMessage("Info"),
        "taskDetailTabOverview":
            MessageLookupByLibrary.simpleMessage("Overview"),
        "taskDetailTabSensors": MessageLookupByLibrary.simpleMessage("Sensors"),
        "taskDetailTimeEndInProgress":
            MessageLookupByLibrary.simpleMessage("In Progress"),
        "taskDetails": MessageLookupByLibrary.simpleMessage("Task Details"),
        "taskDetailsLoading":
            MessageLookupByLibrary.simpleMessage("Getting task details"),
        "taskDetailsNoEvents":
            MessageLookupByLibrary.simpleMessage("No events"),
        "taskDetailsNoEventsDesc": MessageLookupByLibrary.simpleMessage(
            "There are no events for this task"),
        "taskDetailsNoSensors":
            MessageLookupByLibrary.simpleMessage("No sensors"),
        "taskDetailsNoSensorsDesc": MessageLookupByLibrary.simpleMessage(
            "There are no sensors for this task"),
        "taskEnd": MessageLookupByLibrary.simpleMessage("Task End"),
        "taskFilter": MessageLookupByLibrary.simpleMessage("All"),
        "taskFilterCustomRange":
            MessageLookupByLibrary.simpleMessage("Custom range"),
        "taskFilterDate": MessageLookupByLibrary.simpleMessage("By date"),
        "taskFilterDateFilterAllTime":
            MessageLookupByLibrary.simpleMessage("All time"),
        "taskFilterDateFilterLast30Days":
            MessageLookupByLibrary.simpleMessage("last 30 days"),
        "taskFilterDateFilterLast7Days":
            MessageLookupByLibrary.simpleMessage("last 7 days"),
        "taskFilterDateFilterLastDay":
            MessageLookupByLibrary.simpleMessage("last day"),
        "taskFilterDateFilterNotSet":
            MessageLookupByLibrary.simpleMessage("Not set"),
        "taskFilterFilter": MessageLookupByLibrary.simpleMessage("Filter"),
        "taskFilterNotOnTask":
            MessageLookupByLibrary.simpleMessage("Not on task"),
        "taskFilterStatus": MessageLookupByLibrary.simpleMessage("Status"),
        "taskFilterStatusField": MessageLookupByLibrary.simpleMessage("All"),
        "taskFilterView": MessageLookupByLibrary.simpleMessage("List view"),
        "taskFilterViewFieldDetailed":
            MessageLookupByLibrary.simpleMessage("Detailed"),
        "taskFilterViewFieldSlim": MessageLookupByLibrary.simpleMessage("Slim"),
        "taskName": MessageLookupByLibrary.simpleMessage("Task Name"),
        "taskStart": MessageLookupByLibrary.simpleMessage("Task Start"),
        "taskStatus": MessageLookupByLibrary.simpleMessage("Task Status"),
        "termsAndConditions":
            MessageLookupByLibrary.simpleMessage("Terms and conditions"),
        "tokenError":
            MessageLookupByLibrary.simpleMessage("Your session has expired."),
        "tryAgain": MessageLookupByLibrary.simpleMessage("Try again"),
        "type": MessageLookupByLibrary.simpleMessage("Type"),
        "unknownError": MessageLookupByLibrary.simpleMessage("Unknown error"),
        "unverifiedData":
            MessageLookupByLibrary.simpleMessage("Unverified Data"),
        "url": MessageLookupByLibrary.simpleMessage("url"),
        "validateSN":
            MessageLookupByLibrary.simpleMessage("Checking Serial Number"),
        "view": MessageLookupByLibrary.simpleMessage("View"),
        "viewAlarms": m11,
        "yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "zsFinderVersion":
            MessageLookupByLibrary.simpleMessage("ZSFinder version supported"),
        "zsfinderBindFailed":
            MessageLookupByLibrary.simpleMessage("ZSFinder failed to bind"),
        "zsfinderGrantPermissions":
            MessageLookupByLibrary.simpleMessage("Grant Permissions"),
        "zsfinderIncompatible": MessageLookupByLibrary.simpleMessage(
            "Incompatible version of ZSFinder"),
        "zsfinderNotInstalled":
            MessageLookupByLibrary.simpleMessage("ZSFinder is not installed"),
        "zsfinderOpen": MessageLookupByLibrary.simpleMessage("Open ZSFinder"),
        "zsfinderPermissionsDenied": MessageLookupByLibrary.simpleMessage(
            "ZSFinder permissions not granted"),
        "zsfinderPermissionsRequired": MessageLookupByLibrary.simpleMessage(
            "This application requires that the ZSFinder service has all necessary permissions."),
        "zsfinderRebind": MessageLookupByLibrary.simpleMessage(
            "Try opening ZSFinder service to ensure it is running and then open this application again."),
        "zsfinderRequired": MessageLookupByLibrary.simpleMessage(
            "This application requires that the ZSFinder service is installed and running."),
        "zsfinderUpdateRequired": MessageLookupByLibrary.simpleMessage(
            "This application requires that a newer version of ZSFinder service is installed.")
      };
}
