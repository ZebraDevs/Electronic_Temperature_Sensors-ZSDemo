// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Loco {
  Loco();

  static Loco? _current;

  static Loco get current {
    assert(_current != null,
        'No instance of Loco was loaded. Try to initialize the Loco delegate before accessing Loco.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Loco> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Loco();
      Loco._current = instance;

      return instance;
    });
  }

  static Loco of(BuildContext context) {
    final instance = Loco.maybeOf(context);
    assert(instance != null,
        'No instance of Loco present in the widget tree. Did you add Loco.delegate in localizationsDelegates?');
    return instance!;
  }

  static Loco? maybeOf(BuildContext context) {
    return Localizations.of<Loco>(context, Loco);
  }

  /// `Scan the QR code of a sensor to begin`
  String get homePageLabel {
    return Intl.message(
      'Scan the QR code of a sensor to begin',
      name: 'homePageLabel',
      desc: '',
      args: [],
    );
  }

  /// `Scan Sensor`
  String get scanSensorLabel {
    return Intl.message(
      'Scan Sensor',
      name: 'scanSensorLabel',
      desc: '',
      args: [],
    );
  }

  /// `Scan Another Sensor`
  String get scanAnotherSensorLabel {
    return Intl.message(
      'Scan Another Sensor',
      name: 'scanAnotherSensorLabel',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get menuAbout {
    return Intl.message(
      'About',
      name: 'menuAbout',
      desc: '',
      args: [],
    );
  }

  /// `Update Sensor`
  String get menuUpdateFW {
    return Intl.message(
      'Update Sensor',
      name: 'menuUpdateFW',
      desc: '',
      args: [],
    );
  }

  /// `Copyright ©`
  String get copyrightDate {
    return Intl.message(
      'Copyright ©',
      name: 'copyrightDate',
      desc: '',
      args: [],
    );
  }

  /// `App Version Number`
  String get appVersionNumber {
    return Intl.message(
      'App Version Number',
      name: 'appVersionNumber',
      desc: '',
      args: [],
    );
  }

  /// `Android Version`
  String get androidVersion {
    return Intl.message(
      'Android Version',
      name: 'androidVersion',
      desc: '',
      args: [],
    );
  }

  /// `ZSFinder version supported`
  String get zsFinderVersion {
    return Intl.message(
      'ZSFinder version supported',
      name: 'zsFinderVersion',
      desc: '',
      args: [],
    );
  }

  /// `Data and Management APIs`
  String get dataAPIs {
    return Intl.message(
      'Data and Management APIs',
      name: 'dataAPIs',
      desc: '',
      args: [],
    );
  }

  /// `Note: there are no versions for the API – both individually and collectively`
  String get dataAPIs1 {
    return Intl.message(
      'Note: there are no versions for the API – both individually and collectively',
      name: 'dataAPIs1',
      desc: '',
      args: [],
    );
  }

  /// `However, there is a version number (e.g. v2) in the URL path for the REST APIs`
  String get dataAPIs2 {
    return Intl.message(
      'However, there is a version number (e.g. v2) in the URL path for the REST APIs',
      name: 'dataAPIs2',
      desc: '',
      args: [],
    );
  }

  /// `Sensor FW Version supported`
  String get sensorFWVersion {
    return Intl.message(
      'Sensor FW Version supported',
      name: 'sensorFWVersion',
      desc: '',
      args: [],
    );
  }

  /// `OSS Attributions`
  String get ossAttributions {
    return Intl.message(
      'OSS Attributions',
      name: 'ossAttributions',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `License`
  String get license {
    return Intl.message(
      'License',
      name: 'license',
      desc: '',
      args: [],
    );
  }

  /// `url`
  String get url {
    return Intl.message(
      'url',
      name: 'url',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get logout {
    return Intl.message(
      'Sign Out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Searching...`
  String get searching {
    return Intl.message(
      'Searching...',
      name: 'searching',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get tryAgain {
    return Intl.message(
      'Try again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message(
      'Exit',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Event`
  String get event {
    return Intl.message(
      'Event',
      name: 'event',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get open {
    return Intl.message(
      'Open',
      name: 'open',
      desc: '',
      args: [],
    );
  }

  /// `close`
  String get close {
    return Intl.message(
      'close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueLabel {
    return Intl.message(
      'Continue',
      name: 'continueLabel',
      desc: '',
      args: [],
    );
  }

  /// `Firmware Version`
  String get firmwareVersion {
    return Intl.message(
      'Firmware Version',
      name: 'firmwareVersion',
      desc: '',
      args: [],
    );
  }

  /// `Terms and conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms and conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signIn {
    return Intl.message(
      'Sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Electronic Sensors Demo Mobile Application`
  String get signInPageLabel {
    return Intl.message(
      'Electronic Sensors Demo Mobile Application',
      name: 'signInPageLabel',
      desc: '',
      args: [],
    );
  }

  /// `Camera error`
  String get errorCamera {
    return Intl.message(
      'Camera error',
      name: 'errorCamera',
      desc: '',
      args: [],
    );
  }

  /// `Camera exception`
  String get exceptionCamera {
    return Intl.message(
      'Camera exception',
      name: 'exceptionCamera',
      desc: '',
      args: [],
    );
  }

  /// `Permission not granted`
  String get permissionsNotGranted {
    return Intl.message(
      'Permission not granted',
      name: 'permissionsNotGranted',
      desc: '',
      args: [],
    );
  }

  /// `Camera permission`
  String get permissionCamera {
    return Intl.message(
      'Camera permission',
      name: 'permissionCamera',
      desc: '',
      args: [],
    );
  }

  /// `Can't take picture from camera`
  String get qrScanCantTakePicture {
    return Intl.message(
      'Can\'t take picture from camera',
      name: 'qrScanCantTakePicture',
      desc: '',
      args: [],
    );
  }

  /// `Position the QR code inside the square to capture`
  String get qrScanPointAtQrcode {
    return Intl.message(
      'Position the QR code inside the square to capture',
      name: 'qrScanPointAtQrcode',
      desc: '',
      args: [],
    );
  }

  /// `Detected Nothing`
  String get qrScanDetectedNothing {
    return Intl.message(
      'Detected Nothing',
      name: 'qrScanDetectedNothing',
      desc: '',
      args: [],
    );
  }

  /// `Could not detect any camera`
  String get qrScanCouldNotDetect {
    return Intl.message(
      'Could not detect any camera',
      name: 'qrScanCouldNotDetect',
      desc: '',
      args: [],
    );
  }

  /// `Scanner is busy. Please go back and try again.`
  String get qrScanBusyTryAgain {
    return Intl.message(
      'Scanner is busy. Please go back and try again.',
      name: 'qrScanBusyTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Detecting...`
  String get qrScanDetecting {
    return Intl.message(
      'Detecting...',
      name: 'qrScanDetecting',
      desc: '',
      args: [],
    );
  }

  /// `Scan again`
  String get qrScanAgain {
    return Intl.message(
      'Scan again',
      name: 'qrScanAgain',
      desc: '',
      args: [],
    );
  }

  /// `Invalid QR code`
  String get errorInvalidQrCode {
    return Intl.message(
      'Invalid QR code',
      name: 'errorInvalidQrCode',
      desc: '',
      args: [],
    );
  }

  /// `Make sure you are scanning the QR code on top of the sensor`
  String get errorInvalidQrCodeDescription {
    return Intl.message(
      'Make sure you are scanning the QR code on top of the sensor',
      name: 'errorInvalidQrCodeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't get current location`
  String get errorLocation {
    return Intl.message(
      'Couldn\'t get current location',
      name: 'errorLocation',
      desc: '',
      args: [],
    );
  }

  /// `Checking Serial Number`
  String get validateSN {
    return Intl.message(
      'Checking Serial Number',
      name: 'validateSN',
      desc: '',
      args: [],
    );
  }

  /// `Serial Number of Sensor`
  String get sensorID {
    return Intl.message(
      'Serial Number of Sensor',
      name: 'sensorID',
      desc: '',
      args: [],
    );
  }

  /// `Enter serial number`
  String get addSensorEnterIdNumber {
    return Intl.message(
      'Enter serial number',
      name: 'addSensorEnterIdNumber',
      desc: '',
      args: [],
    );
  }

  /// `Find via ID`
  String get findViaId {
    return Intl.message(
      'Find via ID',
      name: 'findViaId',
      desc: '',
      args: [],
    );
  }

  /// `Could not disconnect from sensor`
  String get sensorSdkCannotDisconnect {
    return Intl.message(
      'Could not disconnect from sensor',
      name: 'sensorSdkCannotDisconnect',
      desc: '',
      args: [],
    );
  }

  /// `Could not connect to sensor`
  String get sensorSdkCannotConnect {
    return Intl.message(
      'Could not connect to sensor',
      name: 'sensorSdkCannotConnect',
      desc: '',
      args: [],
    );
  }

  /// `Could not find sensors`
  String get sensorSdkCannotFind {
    return Intl.message(
      'Could not find sensors',
      name: 'sensorSdkCannotFind',
      desc: '',
      args: [],
    );
  }

  /// `Could not discover sensors`
  String get sensorSdkCannotDiscover {
    return Intl.message(
      'Could not discover sensors',
      name: 'sensorSdkCannotDiscover',
      desc: '',
      args: [],
    );
  }

  /// `Could not decommission sensor`
  String get sensorSdkCannotDecommission {
    return Intl.message(
      'Could not decommission sensor',
      name: 'sensorSdkCannotDecommission',
      desc: '',
      args: [],
    );
  }

  /// `Could not write immediate alert`
  String get sensorSdkCannotWriteAlert {
    return Intl.message(
      'Could not write immediate alert',
      name: 'sensorSdkCannotWriteAlert',
      desc: '',
      args: [],
    );
  }

  /// `There was an issue setting the device in OTA mode...`
  String get errorSettingDeviceOtaMode {
    return Intl.message(
      'There was an issue setting the device in OTA mode...',
      name: 'errorSettingDeviceOtaMode',
      desc: '',
      args: [],
    );
  }

  /// `There was an issue performing the firmware update...`
  String get errorPerformingFirmwareUpdate {
    return Intl.message(
      'There was an issue performing the firmware update...',
      name: 'errorPerformingFirmwareUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get unknownError {
    return Intl.message(
      'Unknown error',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Backend Error`
  String get backendError {
    return Intl.message(
      'Backend Error',
      name: 'backendError',
      desc: '',
      args: [],
    );
  }

  /// `Permission Denied`
  String get apiErrorPermission {
    return Intl.message(
      'Permission Denied',
      name: 'apiErrorPermission',
      desc: '',
      args: [],
    );
  }

  /// `Request Aborted`
  String get apiErrorAborted {
    return Intl.message(
      'Request Aborted',
      name: 'apiErrorAborted',
      desc: '',
      args: [],
    );
  }

  /// `Resource Already Exists`
  String get apiErrorAlreadyExists {
    return Intl.message(
      'Resource Already Exists',
      name: 'apiErrorAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `User Cancelled Operation`
  String get apiErrorCancelled {
    return Intl.message(
      'User Cancelled Operation',
      name: 'apiErrorCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Data Loss or Corruption`
  String get apiErrorDataLoss {
    return Intl.message(
      'Data Loss or Corruption',
      name: 'apiErrorDataLoss',
      desc: '',
      args: [],
    );
  }

  /// `Deadline Exceeded`
  String get apiErrorDeadlineExceeded {
    return Intl.message(
      'Deadline Exceeded',
      name: 'apiErrorDeadlineExceeded',
      desc: '',
      args: [],
    );
  }

  /// `Operation Rejected Due to Failed Precondition`
  String get apiErrorFailedPrecondition {
    return Intl.message(
      'Operation Rejected Due to Failed Precondition',
      name: 'apiErrorFailedPrecondition',
      desc: '',
      args: [],
    );
  }

  /// `Internal Server Error`
  String get apiErrorInternal {
    return Intl.message(
      'Internal Server Error',
      name: 'apiErrorInternal',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Argument`
  String get apiErrorInvalidArgument {
    return Intl.message(
      'Invalid Argument',
      name: 'apiErrorInvalidArgument',
      desc: '',
      args: [],
    );
  }

  /// `Entity Not Found`
  String get apiErrorNotFound {
    return Intl.message(
      'Entity Not Found',
      name: 'apiErrorNotFound',
      desc: '',
      args: [],
    );
  }

  /// `All Good`
  String get apiErrorOk {
    return Intl.message(
      'All Good',
      name: 'apiErrorOk',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Range`
  String get apiErrorOutOfRange {
    return Intl.message(
      'Invalid Range',
      name: 'apiErrorOutOfRange',
      desc: '',
      args: [],
    );
  }

  /// `Resource Exhausted`
  String get apiErrorResourceExhausted {
    return Intl.message(
      'Resource Exhausted',
      name: 'apiErrorResourceExhausted',
      desc: '',
      args: [],
    );
  }

  /// `Authentication Required`
  String get apiErrorUnauthenticated {
    return Intl.message(
      'Authentication Required',
      name: 'apiErrorUnauthenticated',
      desc: '',
      args: [],
    );
  }

  /// `Operation Not Implemented Yet`
  String get apiErrorUnimplemented {
    return Intl.message(
      'Operation Not Implemented Yet',
      name: 'apiErrorUnimplemented',
      desc: '',
      args: [],
    );
  }

  /// `Service is currently unavailable`
  String get apiErrorUnavailable {
    return Intl.message(
      'Service is currently unavailable',
      name: 'apiErrorUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Session Expired`
  String get invalidAuthTitle {
    return Intl.message(
      'Session Expired',
      name: 'invalidAuthTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your refresh token has expired. Try logging in again`
  String get invalidAuthDescription {
    return Intl.message(
      'Your refresh token has expired. Try logging in again',
      name: 'invalidAuthDescription',
      desc: '',
      args: [],
    );
  }

  /// `Authentication error`
  String get authError {
    return Intl.message(
      'Authentication error',
      name: 'authError',
      desc: '',
      args: [],
    );
  }

  /// `Your session has expired.`
  String get tokenError {
    return Intl.message(
      'Your session has expired.',
      name: 'tokenError',
      desc: '',
      args: [],
    );
  }

  /// `No events have been recorded`
  String get noEventsFoundTitle {
    return Intl.message(
      'No events have been recorded',
      name: 'noEventsFoundTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please check back in a few minutes`
  String get noEventsFoundMessage {
    return Intl.message(
      'Please check back in a few minutes',
      name: 'noEventsFoundMessage',
      desc: '',
      args: [],
    );
  }

  /// `Error! Sensor already has owner`
  String get addSensorsRegisteredTitle {
    return Intl.message(
      'Error! Sensor already has owner',
      name: 'addSensorsRegisteredTitle',
      desc: '',
      args: [],
    );
  }

  /// `This sensor is already added to a different tenant.`
  String get addSensorsRegisteredDescription {
    return Intl.message(
      'This sensor is already added to a different tenant.',
      name: 'addSensorsRegisteredDescription',
      desc: '',
      args: [],
    );
  }

  /// `Error! Sensor is unavailable`
  String get addSensorsUnavailableTitle {
    return Intl.message(
      'Error! Sensor is unavailable',
      name: 'addSensorsUnavailableTitle',
      desc: '',
      args: [],
    );
  }

  /// `This sensor is not available and cannot be added.`
  String get addSensorsUnavailableDescription {
    return Intl.message(
      'This sensor is not available and cannot be added.',
      name: 'addSensorsUnavailableDescription',
      desc: '',
      args: [],
    );
  }

  /// `Error! Sensor has a low battery`
  String get addSensorsRegisteredLowBatteryTitle {
    return Intl.message(
      'Error! Sensor has a low battery',
      name: 'addSensorsRegisteredLowBatteryTitle',
      desc: '',
      args: [],
    );
  }

  /// `This sensor's battery is lower than 5% and cannot be onboarded.`
  String get addSensorsRegisteredLowBatteryDescription {
    return Intl.message(
      'This sensor\'s battery is lower than 5% and cannot be onboarded.',
      name: 'addSensorsRegisteredLowBatteryDescription',
      desc: '',
      args: [],
    );
  }

  /// `Connected`
  String get connected {
    return Intl.message(
      'Connected',
      name: 'connected',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get available {
    return Intl.message(
      'Available',
      name: 'available',
      desc: '',
      args: [],
    );
  }

  /// `Not available`
  String get notAvailable {
    return Intl.message(
      'Not available',
      name: 'notAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Registered`
  String get registered {
    return Intl.message(
      'Registered',
      name: 'registered',
      desc: '',
      args: [],
    );
  }

  /// `New sensor`
  String get newSensor {
    return Intl.message(
      'New sensor',
      name: 'newSensor',
      desc: '',
      args: [],
    );
  }

  /// `Immediately`
  String get createTaskItmImmediately {
    return Intl.message(
      'Immediately',
      name: 'createTaskItmImmediately',
      desc: '',
      args: [],
    );
  }

  /// `On sensor button press`
  String get createTaskItmButtonPress {
    return Intl.message(
      'On sensor button press',
      name: 'createTaskItmButtonPress',
      desc: '',
      args: [],
    );
  }

  /// `Delay until...`
  String get createTaskItmDelayUntil {
    return Intl.message(
      'Delay until...',
      name: 'createTaskItmDelayUntil',
      desc: '',
      args: [],
    );
  }

  /// `Delayed until date/time is required when Start mode is Delay until..`
  String get createTaskDelayedError {
    return Intl.message(
      'Delayed until date/time is required when Start mode is Delay until..',
      name: 'createTaskDelayedError',
      desc: '',
      args: [],
    );
  }

  /// `Start mode is %1$, but delayed until is present`
  String get taskDetailStartModeDelayed {
    return Intl.message(
      'Start mode is %1\$, but delayed until is present',
      name: 'taskDetailStartModeDelayed',
      desc: '',
      args: [],
    );
  }

  /// `Temperature below (°C)`
  String get createTaskItmTempBelow {
    return Intl.message(
      'Temperature below (°C)',
      name: 'createTaskItmTempBelow',
      desc: '',
      args: [],
    );
  }

  /// `Temperature above (°C)`
  String get createTaskItmTempAbove {
    return Intl.message(
      'Temperature above (°C)',
      name: 'createTaskItmTempAbove',
      desc: '',
      args: [],
    );
  }

  /// `Temperature below`
  String get createTaskItmTempBelowText {
    return Intl.message(
      'Temperature below',
      name: 'createTaskItmTempBelowText',
      desc: '',
      args: [],
    );
  }

  /// `Temperature above`
  String get createTaskItmTempAboveText {
    return Intl.message(
      'Temperature above',
      name: 'createTaskItmTempAboveText',
      desc: '',
      args: [],
    );
  }

  /// `Delay time to start (minutes)`
  String get createTaskItmDelayTimeStart {
    return Intl.message(
      'Delay time to start (minutes)',
      name: 'createTaskItmDelayTimeStart',
      desc: '',
      args: [],
    );
  }

  /// `Delayed until date/time`
  String get createTaskItmDelayedUntil {
    return Intl.message(
      'Delayed until date/time',
      name: 'createTaskItmDelayedUntil',
      desc: '',
      args: [],
    );
  }

  /// `Interval value must be at least 15 seconds`
  String get createTaskErrorMustBe15s {
    return Intl.message(
      'Interval value must be at least 15 seconds',
      name: 'createTaskErrorMustBe15s',
      desc: '',
      args: [],
    );
  }

  /// `Create task`
  String get createTaskHdlNew {
    return Intl.message(
      'Create task',
      name: 'createTaskHdlNew',
      desc: '',
      args: [],
    );
  }

  /// `Minimum delay is 1 second`
  String get createTaskStep2ErrorMinOne {
    return Intl.message(
      'Minimum delay is 1 second',
      name: 'createTaskStep2ErrorMinOne',
      desc: '',
      args: [],
    );
  }

  /// `General details`
  String get createTaskLblGeneralDetails {
    return Intl.message(
      'General details',
      name: 'createTaskLblGeneralDetails',
      desc: '',
      args: [],
    );
  }

  /// `Enter or edit the task details below`
  String get createTaskHntGeneralDetails {
    return Intl.message(
      'Enter or edit the task details below',
      name: 'createTaskHntGeneralDetails',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get createTaskLblReview {
    return Intl.message(
      'Review',
      name: 'createTaskLblReview',
      desc: '',
      args: [],
    );
  }

  /// `Leo tortor ornare blandit mollis tristique tortor eu lectus. Etiam semper non a elementum in.`
  String get createTaskHntReview {
    return Intl.message(
      'Leo tortor ornare blandit mollis tristique tortor eu lectus. Etiam semper non a elementum in.',
      name: 'createTaskHntReview',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get createTaskLblComplete {
    return Intl.message(
      'Complete',
      name: 'createTaskLblComplete',
      desc: '',
      args: [],
    );
  }

  /// `Task name`
  String get createTaskLblName {
    return Intl.message(
      'Task name',
      name: 'createTaskLblName',
      desc: '',
      args: [],
    );
  }

  /// `Unique auto generated name`
  String get createTaskHntName {
    return Intl.message(
      'Unique auto generated name',
      name: 'createTaskHntName',
      desc: '',
      args: [],
    );
  }

  /// `Sensor type`
  String get createTaskLblSensorType {
    return Intl.message(
      'Sensor type',
      name: 'createTaskLblSensorType',
      desc: '',
      args: [],
    );
  }

  /// `Select the type of sensor required for this task`
  String get createTaskHntSensorType {
    return Intl.message(
      'Select the type of sensor required for this task',
      name: 'createTaskHntSensorType',
      desc: '',
      args: [],
    );
  }

  /// `Number of sensors (optional)`
  String get createTaskLblSensorsAmmount {
    return Intl.message(
      'Number of sensors (optional)',
      name: 'createTaskLblSensorsAmmount',
      desc: '',
      args: [],
    );
  }

  /// `Set the number of sensors required for the task`
  String get createTaskHntSensorsAmmount {
    return Intl.message(
      'Set the number of sensors required for the task',
      name: 'createTaskHntSensorsAmmount',
      desc: '',
      args: [],
    );
  }

  /// `Password (optional)`
  String get createTaskLblPassword {
    return Intl.message(
      'Password (optional)',
      name: 'createTaskLblPassword',
      desc: '',
      args: [],
    );
  }

  /// `Set a password to stop the task`
  String get createTaskHntPassword {
    return Intl.message(
      'Set a password to stop the task',
      name: 'createTaskHntPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter a strong password`
  String get createTaskTxtPassword {
    return Intl.message(
      'Enter a strong password',
      name: 'createTaskTxtPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sensor configuration`
  String get createTaskHdlSensorConfiguration {
    return Intl.message(
      'Sensor configuration',
      name: 'createTaskHdlSensorConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Configure the sensor below`
  String get createTaskHntSensorConfiguration {
    return Intl.message(
      'Configure the sensor below',
      name: 'createTaskHntSensorConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Reading interval`
  String get createTaskLblReadingInterval {
    return Intl.message(
      'Reading interval',
      name: 'createTaskLblReadingInterval',
      desc: '',
      args: [],
    );
  }

  /// `How often the sensor records temperature (minimum of 15 seconds).`
  String get createTaskHntReadingInterval {
    return Intl.message(
      'How often the sensor records temperature (minimum of 15 seconds).',
      name: 'createTaskHntReadingInterval',
      desc: '',
      args: [],
    );
  }

  /// `Start mode`
  String get createTaskLblStartMode {
    return Intl.message(
      'Start mode',
      name: 'createTaskLblStartMode',
      desc: '',
      args: [],
    );
  }

  /// `Configure sensor when to start logging`
  String get createTaskHntStartMode {
    return Intl.message(
      'Configure sensor when to start logging',
      name: 'createTaskHntStartMode',
      desc: '',
      args: [],
    );
  }

  /// `Start delay`
  String get createTaskLblStartModeDelay {
    return Intl.message(
      'Start delay',
      name: 'createTaskLblStartModeDelay',
      desc: '',
      args: [],
    );
  }

  /// `Delay the start when a sensor reaches a certain temperature, or when a desired amount of time has passed.`
  String get createTaskHntStartModeDelay {
    return Intl.message(
      'Delay the start when a sensor reaches a certain temperature, or when a desired amount of time has passed.',
      name: 'createTaskHntStartModeDelay',
      desc: '',
      args: [],
    );
  }

  /// `Alarm Settings`
  String get createTaskLblAlarmSettings {
    return Intl.message(
      'Alarm Settings',
      name: 'createTaskLblAlarmSettings',
      desc: '',
      args: [],
    );
  }

  /// `Alarm will be triggered when temperature is outside the configured threshold.`
  String get createTaskHntAlarmSettings {
    return Intl.message(
      'Alarm will be triggered when temperature is outside the configured threshold.',
      name: 'createTaskHntAlarmSettings',
      desc: '',
      args: [],
    );
  }

  /// `Low limit (°C)`
  String get createTaskItmLowLimit {
    return Intl.message(
      'Low limit (°C)',
      name: 'createTaskItmLowLimit',
      desc: '',
      args: [],
    );
  }

  /// `High limit (°C)`
  String get createTaskItmHighLimit {
    return Intl.message(
      'High limit (°C)',
      name: 'createTaskItmHighLimit',
      desc: '',
      args: [],
    );
  }

  /// `Low delay in minutes/seconds (optional)`
  String get createTaskItmLowDelay {
    return Intl.message(
      'Low delay in minutes/seconds (optional)',
      name: 'createTaskItmLowDelay',
      desc: '',
      args: [],
    );
  }

  /// `High delay in minutes/seconds (optional)`
  String get createTaskItmHighDelay {
    return Intl.message(
      'High delay in minutes/seconds (optional)',
      name: 'createTaskItmHighDelay',
      desc: '',
      args: [],
    );
  }

  /// `Create task`
  String get createTaskLblCreateTask {
    return Intl.message(
      'Create task',
      name: 'createTaskLblCreateTask',
      desc: '',
      args: [],
    );
  }

  /// `Save and create task`
  String get createTaskSaveCreate {
    return Intl.message(
      'Save and create task',
      name: 'createTaskSaveCreate',
      desc: '',
      args: [],
    );
  }

  /// `Placeholder`
  String get createTaskHntPlaceholder {
    return Intl.message(
      'Placeholder',
      name: 'createTaskHntPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get createTaskLblBack {
    return Intl.message(
      'Back',
      name: 'createTaskLblBack',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get createTaskLblCreate {
    return Intl.message(
      'Create',
      name: 'createTaskLblCreate',
      desc: '',
      args: [],
    );
  }

  /// `Enabled`
  String get createTaskLblEnabled {
    return Intl.message(
      'Enabled',
      name: 'createTaskLblEnabled',
      desc: '',
      args: [],
    );
  }

  /// `Review & save`
  String get createTaskTitleReview {
    return Intl.message(
      'Review & save',
      name: 'createTaskTitleReview',
      desc: '',
      args: [],
    );
  }

  /// `General settings`
  String get createTaskLblGeneralSettings {
    return Intl.message(
      'General settings',
      name: 'createTaskLblGeneralSettings',
      desc: '',
      args: [],
    );
  }

  /// `New task created!`
  String get createTaskSaved {
    return Intl.message(
      'New task created!',
      name: 'createTaskSaved',
      desc: '',
      args: [],
    );
  }

  /// `Exit Create Task`
  String get createTaskExitTitle {
    return Intl.message(
      'Exit Create Task',
      name: 'createTaskExitTitle',
      desc: '',
      args: [],
    );
  }

  /// `If you choose to exit the Create Task page, your changes will not be saved. Are you sure you want to exit?`
  String get createTaskExitDescription {
    return Intl.message(
      'If you choose to exit the Create Task page, your changes will not be saved. Are you sure you want to exit?',
      name: 'createTaskExitDescription',
      desc: '',
      args: [],
    );
  }

  /// `Error creating task`
  String get createTaskCreateErrorTitle {
    return Intl.message(
      'Error creating task',
      name: 'createTaskCreateErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Review the task details below`
  String get createTaskReviewText {
    return Intl.message(
      'Review the task details below',
      name: 'createTaskReviewText',
      desc: '',
      args: [],
    );
  }

  /// `High delay:`
  String get taskDetailInfoHighDelay {
    return Intl.message(
      'High delay:',
      name: 'taskDetailInfoHighDelay',
      desc: '',
      args: [],
    );
  }

  /// `Low delay:`
  String get taskDetailInfoLowDelay {
    return Intl.message(
      'Low delay:',
      name: 'taskDetailInfoLowDelay',
      desc: '',
      args: [],
    );
  }

  /// `Low limit`
  String get taskDetailInfoLowLimit {
    return Intl.message(
      'Low limit',
      name: 'taskDetailInfoLowLimit',
      desc: '',
      args: [],
    );
  }

  /// `High limit`
  String get taskDetailInfoHighLimit {
    return Intl.message(
      'High limit',
      name: 'taskDetailInfoHighLimit',
      desc: '',
      args: [],
    );
  }

  /// `At least one alarm should be set to continue`
  String get taskCreateAlarmNotSet {
    return Intl.message(
      'At least one alarm should be set to continue',
      name: 'taskCreateAlarmNotSet',
      desc: '',
      args: [],
    );
  }

  /// `Value is not a number`
  String get errorEmptyNotANumber {
    return Intl.message(
      'Value is not a number',
      name: 'errorEmptyNotANumber',
      desc: '',
      args: [],
    );
  }

  /// `Empty value`
  String get errorEmptyValue {
    return Intl.message(
      'Empty value',
      name: 'errorEmptyValue',
      desc: '',
      args: [],
    );
  }

  /// `The Low limit must be less than the High limit.`
  String get taskCreateLowHigher {
    return Intl.message(
      'The Low limit must be less than the High limit.',
      name: 'taskCreateLowHigher',
      desc: '',
      args: [],
    );
  }

  /// `The High limit must be greater than the Low limit.`
  String get taskCreateHigher {
    return Intl.message(
      'The High limit must be greater than the Low limit.',
      name: 'taskCreateHigher',
      desc: '',
      args: [],
    );
  }

  /// `Values must be non negative`
  String get errorEmptyNonNegative {
    return Intl.message(
      'Values must be non negative',
      name: 'errorEmptyNonNegative',
      desc: '',
      args: [],
    );
  }

  /// `Temperature cannot be lower than -40°C and higher than 84°C`
  String get taskCreateLowLimits {
    return Intl.message(
      'Temperature cannot be lower than -40°C and higher than 84°C',
      name: 'taskCreateLowLimits',
      desc: '',
      args: [],
    );
  }

  /// `Temperature cannot be lower than -39°C and higher than 85°C`
  String get taskCreateHighLimits {
    return Intl.message(
      'Temperature cannot be lower than -39°C and higher than 85°C',
      name: 'taskCreateHighLimits',
      desc: '',
      args: [],
    );
  }

  /// `Delay time to start can be between 1 and 240 minutes`
  String get taskCreateDelayMinutes {
    return Intl.message(
      'Delay time to start can be between 1 and 240 minutes',
      name: 'taskCreateDelayMinutes',
      desc: '',
      args: [],
    );
  }

  /// `Set at least one`
  String get taskCreateSetAlarm {
    return Intl.message(
      'Set at least one',
      name: 'taskCreateSetAlarm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `{val}°C`
  String taskDetailInfoDegree(Object val) {
    return Intl.message(
      '$val°C',
      name: 'taskDetailInfoDegree',
      desc: '',
      args: [val],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Not Specified`
  String get notSpecified {
    return Intl.message(
      'Not Specified',
      name: 'notSpecified',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get minutes {
    return Intl.message(
      'Minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Seconds`
  String get seconds {
    return Intl.message(
      'Seconds',
      name: 'seconds',
      desc: '',
      args: [],
    );
  }

  /// `Alarm`
  String get alarm {
    return Intl.message(
      'Alarm',
      name: 'alarm',
      desc: '',
      args: [],
    );
  }

  /// `{outOf}/{total} alarm/s`
  String alarmsCount(Object outOf, Object total) {
    return Intl.message(
      '$outOf/$total alarm/s',
      name: 'alarmsCount',
      desc: '',
      args: [outOf, total],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `{minutes} minute/s and {seconds} second/s`
  String minutesSeconds(Object minutes, Object seconds) {
    return Intl.message(
      '$minutes minute/s and $seconds second/s',
      name: 'minutesSeconds',
      desc: '',
      args: [minutes, seconds],
    );
  }

  /// `Create a Task`
  String get createTaskLabel {
    return Intl.message(
      'Create a Task',
      name: 'createTaskLabel',
      desc: '',
      args: [],
    );
  }

  /// `Failed host lookup: check your Internet connection and try again`
  String get connectionErrorMesssage {
    return Intl.message(
      'Failed host lookup: check your Internet connection and try again',
      name: 'connectionErrorMesssage',
      desc: '',
      args: [],
    );
  }

  /// `Alarms`
  String get alarmsTitle {
    return Intl.message(
      'Alarms',
      name: 'alarmsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Alarm`
  String get alarmTitle {
    return Intl.message(
      'Alarm',
      name: 'alarmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Low limit: `
  String get alarmLowLimit {
    return Intl.message(
      'Low limit: ',
      name: 'alarmLowLimit',
      desc: '',
      args: [],
    );
  }

  /// `High limit: `
  String get alarmHighLimit {
    return Intl.message(
      'High limit: ',
      name: 'alarmHighLimit',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get dateTitle {
    return Intl.message(
      'Date',
      name: 'dateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Checking for task alarms`
  String get checkingForTaskAlarms {
    return Intl.message(
      'Checking for task alarms',
      name: 'checkingForTaskAlarms',
      desc: '',
      args: [],
    );
  }

  /// `Battery saver plus clear`
  String get alarmTypeBatterySaverPlusClear {
    return Intl.message(
      'Battery saver plus clear',
      name: 'alarmTypeBatterySaverPlusClear',
      desc: '',
      args: [],
    );
  }

  /// `Battery saver plus set`
  String get alarmTypeBatterySaverPlusSet {
    return Intl.message(
      'Battery saver plus set',
      name: 'alarmTypeBatterySaverPlusSet',
      desc: '',
      args: [],
    );
  }

  /// `Low limit alarm`
  String get alarmTypeLowLimitAlarm {
    return Intl.message(
      'Low limit alarm',
      name: 'alarmTypeLowLimitAlarm',
      desc: '',
      args: [],
    );
  }

  /// `Low limit alarm clear`
  String get alarmTypeLowLimitAlarmClear {
    return Intl.message(
      'Low limit alarm clear',
      name: 'alarmTypeLowLimitAlarmClear',
      desc: '',
      args: [],
    );
  }

  /// `Low battery alarm`
  String get alarmTypeLowBattery {
    return Intl.message(
      'Low battery alarm',
      name: 'alarmTypeLowBattery',
      desc: '',
      args: [],
    );
  }

  /// `High limit alarm`
  String get alarmTypeHighLimitAlarm {
    return Intl.message(
      'High limit alarm',
      name: 'alarmTypeHighLimitAlarm',
      desc: '',
      args: [],
    );
  }

  /// `High limit alarm clear`
  String get alarmTypeHighLimitAlarmClear {
    return Intl.message(
      'High limit alarm clear',
      name: 'alarmTypeHighLimitAlarmClear',
      desc: '',
      args: [],
    );
  }

  /// `Unspecified`
  String get alarmTypeUnspecified {
    return Intl.message(
      'Unspecified',
      name: 'alarmTypeUnspecified',
      desc: '',
      args: [],
    );
  }

  /// `Too cold alarm`
  String get alarmTypeTooCold {
    return Intl.message(
      'Too cold alarm',
      name: 'alarmTypeTooCold',
      desc: '',
      args: [],
    );
  }

  /// `Checking for task events`
  String get checkingForTaskEvents {
    return Intl.message(
      'Checking for task events',
      name: 'checkingForTaskEvents',
      desc: '',
      args: [],
    );
  }

  /// `Checking for task sensors`
  String get checkingForTaskSensors {
    return Intl.message(
      'Checking for task sensors',
      name: 'checkingForTaskSensors',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get taskDetailTabOverview {
    return Intl.message(
      'Overview',
      name: 'taskDetailTabOverview',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get taskDetailTabInfo {
    return Intl.message(
      'Info',
      name: 'taskDetailTabInfo',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get taskDetailTabEvents {
    return Intl.message(
      'Events',
      name: 'taskDetailTabEvents',
      desc: '',
      args: [],
    );
  }

  /// `Sensors`
  String get taskDetailTabSensors {
    return Intl.message(
      'Sensors',
      name: 'taskDetailTabSensors',
      desc: '',
      args: [],
    );
  }

  /// `Getting task details`
  String get taskDetailsLoading {
    return Intl.message(
      'Getting task details',
      name: 'taskDetailsLoading',
      desc: '',
      args: [],
    );
  }

  /// `No events`
  String get taskDetailsNoEvents {
    return Intl.message(
      'No events',
      name: 'taskDetailsNoEvents',
      desc: '',
      args: [],
    );
  }

  /// `There are no events for this task`
  String get taskDetailsNoEventsDesc {
    return Intl.message(
      'There are no events for this task',
      name: 'taskDetailsNoEventsDesc',
      desc: '',
      args: [],
    );
  }

  /// `No sensors`
  String get taskDetailsNoSensors {
    return Intl.message(
      'No sensors',
      name: 'taskDetailsNoSensors',
      desc: '',
      args: [],
    );
  }

  /// `There are no sensors for this task`
  String get taskDetailsNoSensorsDesc {
    return Intl.message(
      'There are no sensors for this task',
      name: 'taskDetailsNoSensorsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Stop task`
  String get stopTask {
    return Intl.message(
      'Stop task',
      name: 'stopTask',
      desc: '',
      args: [],
    );
  }

  /// `Stopping a task`
  String get stopTaskLoading {
    return Intl.message(
      'Stopping a task',
      name: 'stopTaskLoading',
      desc: '',
      args: [],
    );
  }

  /// `Error while stopping a task`
  String get stopTaskError {
    return Intl.message(
      'Error while stopping a task',
      name: 'stopTaskError',
      desc: '',
      args: [],
    );
  }

  /// `This will stop all sensors on this task and will mark it as complete.`
  String get stopTaskPromptMessage {
    return Intl.message(
      'This will stop all sensors on this task and will mark it as complete.',
      name: 'stopTaskPromptMessage',
      desc: '',
      args: [],
    );
  }

  /// `Stopping task`
  String get stopTaskPending {
    return Intl.message(
      'Stopping task',
      name: 'stopTaskPending',
      desc: '',
      args: [],
    );
  }

  /// `Please bring sensor ({sn}) within range of a bridge or your mobile device`
  String stopTaskPendingDesc(Object sn) {
    return Intl.message(
      'Please bring sensor ($sn) within range of a bridge or your mobile device',
      name: 'stopTaskPendingDesc',
      desc: '',
      args: [sn],
    );
  }

  /// `The task was successfully stopped`
  String get stopTaskSuccess {
    return Intl.message(
      'The task was successfully stopped',
      name: 'stopTaskSuccess',
      desc: '',
      args: [],
    );
  }

  /// `active`
  String get taskDetailStatusActiveShort {
    return Intl.message(
      'active',
      name: 'taskDetailStatusActiveShort',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get taskDetailStatusActiveLong {
    return Intl.message(
      'Active',
      name: 'taskDetailStatusActiveLong',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get taskDetailStatusActiveLongVariant {
    return Intl.message(
      'Active',
      name: 'taskDetailStatusActiveLongVariant',
      desc: '',
      args: [],
    );
  }

  /// `active w alarm`
  String get taskDetailStatusActiveWithAlarmShort {
    return Intl.message(
      'active w alarm',
      name: 'taskDetailStatusActiveWithAlarmShort',
      desc: '',
      args: [],
    );
  }

  /// `Active with alarm`
  String get taskDetailStatusActiveWithAlarmLong {
    return Intl.message(
      'Active with alarm',
      name: 'taskDetailStatusActiveWithAlarmLong',
      desc: '',
      args: [],
    );
  }

  /// `active w tech alarm`
  String get taskDetailStatusActiveWithTechAlarmShort {
    return Intl.message(
      'active w tech alarm',
      name: 'taskDetailStatusActiveWithTechAlarmShort',
      desc: '',
      args: [],
    );
  }

  /// `Active with tech alarm`
  String get taskDetailStatusActiveWithTechAlarmLong {
    return Intl.message(
      'Active with tech alarm',
      name: 'taskDetailStatusActiveWithTechAlarmLong',
      desc: '',
      args: [],
    );
  }

  /// `sensors required`
  String get taskDetailStatusSensorsRequiredShort {
    return Intl.message(
      'sensors required',
      name: 'taskDetailStatusSensorsRequiredShort',
      desc: '',
      args: [],
    );
  }

  /// `Sensors required`
  String get taskDetailStatusSensorsRequiredLong {
    return Intl.message(
      'Sensors required',
      name: 'taskDetailStatusSensorsRequiredLong',
      desc: '',
      args: [],
    );
  }

  /// `completed`
  String get taskDetailStatusSensorsCompletedShort {
    return Intl.message(
      'completed',
      name: 'taskDetailStatusSensorsCompletedShort',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get taskDetailStatusSensorsCompletedLong {
    return Intl.message(
      'Completed',
      name: 'taskDetailStatusSensorsCompletedLong',
      desc: '',
      args: [],
    );
  }

  /// `stopped`
  String get taskDetailStatusSensorsStoppedShort {
    return Intl.message(
      'stopped',
      name: 'taskDetailStatusSensorsStoppedShort',
      desc: '',
      args: [],
    );
  }

  /// `Stopped`
  String get taskDetailStatusSensorsStoppedLong {
    return Intl.message(
      'Stopped',
      name: 'taskDetailStatusSensorsStoppedLong',
      desc: '',
      args: [],
    );
  }

  /// `start pending`
  String get taskDetailStatusStartPendingShort {
    return Intl.message(
      'start pending',
      name: 'taskDetailStatusStartPendingShort',
      desc: '',
      args: [],
    );
  }

  /// `Start pending`
  String get taskDetailStatusStartPendingLong {
    return Intl.message(
      'Start pending',
      name: 'taskDetailStatusStartPendingLong',
      desc: '',
      args: [],
    );
  }

  /// `Start pending`
  String get taskDetailStatusStartPendingLongVariant {
    return Intl.message(
      'Start pending',
      name: 'taskDetailStatusStartPendingLongVariant',
      desc: '',
      args: [],
    );
  }

  /// `stop pending`
  String get taskDetailStatusStopPendingShort {
    return Intl.message(
      'stop pending',
      name: 'taskDetailStatusStopPendingShort',
      desc: '',
      args: [],
    );
  }

  /// `Stop pending`
  String get taskDetailStatusStopPendingLong {
    return Intl.message(
      'Stop pending',
      name: 'taskDetailStatusStopPendingLong',
      desc: '',
      args: [],
    );
  }

  /// `Stop pending`
  String get taskDetailStatusStopPendingLongVariant {
    return Intl.message(
      'Stop pending',
      name: 'taskDetailStatusStopPendingLongVariant',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get taskDetailTimeEndInProgress {
    return Intl.message(
      'In Progress',
      name: 'taskDetailTimeEndInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Task start`
  String get taskDashboardListFieldTaskStart {
    return Intl.message(
      'Task start',
      name: 'taskDashboardListFieldTaskStart',
      desc: '',
      args: [],
    );
  }

  /// `Task end`
  String get taskDashboardListFieldTaskEnd {
    return Intl.message(
      'Task end',
      name: 'taskDashboardListFieldTaskEnd',
      desc: '',
      args: [],
    );
  }

  /// `View/edit notes`
  String get taskDetailInfoViewEditNotes {
    return Intl.message(
      'View/edit notes',
      name: 'taskDetailInfoViewEditNotes',
      desc: '',
      args: [],
    );
  }

  /// `Add notes`
  String get taskDetailInfoAddNotes {
    return Intl.message(
      'Add notes',
      name: 'taskDetailInfoAddNotes',
      desc: '',
      args: [],
    );
  }

  /// `Task has no notes`
  String get taskDetailNoNotes {
    return Intl.message(
      'Task has no notes',
      name: 'taskDetailNoNotes',
      desc: '',
      args: [],
    );
  }

  /// `Sensor type`
  String get taskDetailInfoSensorType {
    return Intl.message(
      'Sensor type',
      name: 'taskDetailInfoSensorType',
      desc: '',
      args: [],
    );
  }

  /// `Number of sensors`
  String get taskDetailInfoNumberOfSensors {
    return Intl.message(
      'Number of sensors',
      name: 'taskDetailInfoNumberOfSensors',
      desc: '',
      args: [],
    );
  }

  /// `Reading interval`
  String get taskDetailInfoReadingInterval {
    return Intl.message(
      'Reading interval',
      name: 'taskDetailInfoReadingInterval',
      desc: '',
      args: [],
    );
  }

  /// `Overwrite readings`
  String get taskDetailInfoLoopOverwrite {
    return Intl.message(
      'Overwrite readings',
      name: 'taskDetailInfoLoopOverwrite',
      desc: '',
      args: [],
    );
  }

  /// `Enabled`
  String get taskDetailInfoEnabled {
    return Intl.message(
      'Enabled',
      name: 'taskDetailInfoEnabled',
      desc: '',
      args: [],
    );
  }

  /// `Disabled`
  String get taskDetailInfoDisabled {
    return Intl.message(
      'Disabled',
      name: 'taskDetailInfoDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Start mode`
  String get taskDetailInfoStartMode {
    return Intl.message(
      'Start mode',
      name: 'taskDetailInfoStartMode',
      desc: '',
      args: [],
    );
  }

  /// `Immediately`
  String get taskDetailInfoStartModeImmediately {
    return Intl.message(
      'Immediately',
      name: 'taskDetailInfoStartModeImmediately',
      desc: '',
      args: [],
    );
  }

  /// `Delayed`
  String get taskDetailInfoStartModeDelayed {
    return Intl.message(
      'Delayed',
      name: 'taskDetailInfoStartModeDelayed',
      desc: '',
      args: [],
    );
  }

  /// `Start delay`
  String get taskDetailInfoStartDelay {
    return Intl.message(
      'Start delay',
      name: 'taskDetailInfoStartDelay',
      desc: '',
      args: [],
    );
  }

  /// `Not specified`
  String get taskDetailInfoNotSet {
    return Intl.message(
      'Not specified',
      name: 'taskDetailInfoNotSet',
      desc: '',
      args: [],
    );
  }

  /// `Temperature`
  String get sensorTypeTemperature {
    return Intl.message(
      'Temperature',
      name: 'sensorTypeTemperature',
      desc: '',
      args: [],
    );
  }

  /// `Humidity`
  String get sensorTypeHumidity {
    return Intl.message(
      'Humidity',
      name: 'sensorTypeHumidity',
      desc: '',
      args: [],
    );
  }

  /// `Pressure`
  String get sensorTypePressure {
    return Intl.message(
      'Pressure',
      name: 'sensorTypePressure',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get sensorTypeLight {
    return Intl.message(
      'Light',
      name: 'sensorTypeLight',
      desc: '',
      args: [],
    );
  }

  /// `Inertial`
  String get sensorTypeInertial {
    return Intl.message(
      'Inertial',
      name: 'sensorTypeInertial',
      desc: '',
      args: [],
    );
  }

  /// `Last Updated`
  String get sensorLastUpdated {
    return Intl.message(
      'Last Updated',
      name: 'sensorLastUpdated',
      desc: '',
      args: [],
    );
  }

  /// `On sensor button press`
  String get createTaskItemButtonPress {
    return Intl.message(
      'On sensor button press',
      name: 'createTaskItemButtonPress',
      desc: '',
      args: [],
    );
  }

  /// `Above`
  String get labelAbove {
    return Intl.message(
      'Above',
      name: 'labelAbove',
      desc: '',
      args: [],
    );
  }

  /// `Below`
  String get labelBelow {
    return Intl.message(
      'Below',
      name: 'labelBelow',
      desc: '',
      args: [],
    );
  }

  /// `Until`
  String get labelUntil {
    return Intl.message(
      'Until',
      name: 'labelUntil',
      desc: '',
      args: [],
    );
  }

  /// `Good`
  String get lblGood {
    return Intl.message(
      'Good',
      name: 'lblGood',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get lblOk {
    return Intl.message(
      'OK',
      name: 'lblOk',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get lblLow {
    return Intl.message(
      'Low',
      name: 'lblLow',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get lblHigh {
    return Intl.message(
      'High',
      name: 'lblHigh',
      desc: '',
      args: [],
    );
  }

  /// `Battery level`
  String get batteryLevel {
    return Intl.message(
      'Battery level',
      name: 'batteryLevel',
      desc: '',
      args: [],
    );
  }

  /// `active`
  String get taskDetailSensorActiveShort {
    return Intl.message(
      'active',
      name: 'taskDetailSensorActiveShort',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get taskDetailSensorActiveLong {
    return Intl.message(
      'Active',
      name: 'taskDetailSensorActiveLong',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get taskDetailSensorActiveLongVariant {
    return Intl.message(
      'Active',
      name: 'taskDetailSensorActiveLongVariant',
      desc: '',
      args: [],
    );
  }

  /// `active w alarm`
  String get taskDetailSensorActiveWithAlarmShort {
    return Intl.message(
      'active w alarm',
      name: 'taskDetailSensorActiveWithAlarmShort',
      desc: '',
      args: [],
    );
  }

  /// `Active with alarm`
  String get taskDetailSensorActiveWithAlarmLong {
    return Intl.message(
      'Active with alarm',
      name: 'taskDetailSensorActiveWithAlarmLong',
      desc: '',
      args: [],
    );
  }

  /// `Active with alarm`
  String get taskDetailSensorActiveWithAlarmLongVariant {
    return Intl.message(
      'Active with alarm',
      name: 'taskDetailSensorActiveWithAlarmLongVariant',
      desc: '',
      args: [],
    );
  }

  /// `active w tech alarm`
  String get taskDetailSensorActiveWithTechAlarmShort {
    return Intl.message(
      'active w tech alarm',
      name: 'taskDetailSensorActiveWithTechAlarmShort',
      desc: '',
      args: [],
    );
  }

  /// `Active with tech alarm`
  String get taskDetailSensorActiveWithTechAlarmLong {
    return Intl.message(
      'Active with tech alarm',
      name: 'taskDetailSensorActiveWithTechAlarmLong',
      desc: '',
      args: [],
    );
  }

  /// `Active with tech alarm`
  String get taskDetailSensorActiveWithTechAlarmLongVariant {
    return Intl.message(
      'Active with tech alarm',
      name: 'taskDetailSensorActiveWithTechAlarmLongVariant',
      desc: '',
      args: [],
    );
  }

  /// `stop pending`
  String get taskDetailSensorStoppedPendingShort {
    return Intl.message(
      'stop pending',
      name: 'taskDetailSensorStoppedPendingShort',
      desc: '',
      args: [],
    );
  }

  /// `Stop pending`
  String get taskDetailSensorStoppedPendingLong {
    return Intl.message(
      'Stop pending',
      name: 'taskDetailSensorStoppedPendingLong',
      desc: '',
      args: [],
    );
  }

  /// `Stop pending`
  String get taskDetailSensorStoppedPendingLongVariant {
    return Intl.message(
      'Stop pending',
      name: 'taskDetailSensorStoppedPendingLongVariant',
      desc: '',
      args: [],
    );
  }

  /// `unspecified`
  String get taskDetailSensorUnspecifiedShort {
    return Intl.message(
      'unspecified',
      name: 'taskDetailSensorUnspecifiedShort',
      desc: '',
      args: [],
    );
  }

  /// `Unspecified`
  String get taskDetailSensorUnspecifiedLong {
    return Intl.message(
      'Unspecified',
      name: 'taskDetailSensorUnspecifiedLong',
      desc: '',
      args: [],
    );
  }

  /// `Unspecified`
  String get taskDetailSensorUnspecifiedLongVariant {
    return Intl.message(
      'Unspecified',
      name: 'taskDetailSensorUnspecifiedLongVariant',
      desc: '',
      args: [],
    );
  }

  /// `stop pending cold`
  String get taskDetailSensorStoppedPendingColdShort {
    return Intl.message(
      'stop pending cold',
      name: 'taskDetailSensorStoppedPendingColdShort',
      desc: '',
      args: [],
    );
  }

  /// `Stop pending cold`
  String get taskDetailSensorStoppedPendingColdLong {
    return Intl.message(
      'Stop pending cold',
      name: 'taskDetailSensorStoppedPendingColdLong',
      desc: '',
      args: [],
    );
  }

  /// `Stop pending cold`
  String get taskDetailSensorStoppedPendingLongColdVariant {
    return Intl.message(
      'Stop pending cold',
      name: 'taskDetailSensorStoppedPendingLongColdVariant',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get taskFilterFilter {
    return Intl.message(
      'Filter',
      name: 'taskFilterFilter',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get taskFilterStatus {
    return Intl.message(
      'Status',
      name: 'taskFilterStatus',
      desc: '',
      args: [],
    );
  }

  /// `List view`
  String get taskFilterView {
    return Intl.message(
      'List view',
      name: 'taskFilterView',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get taskFilterStatusField {
    return Intl.message(
      'All',
      name: 'taskFilterStatusField',
      desc: '',
      args: [],
    );
  }

  /// `Slim`
  String get taskFilterViewFieldSlim {
    return Intl.message(
      'Slim',
      name: 'taskFilterViewFieldSlim',
      desc: '',
      args: [],
    );
  }

  /// `Detailed`
  String get taskFilterViewFieldDetailed {
    return Intl.message(
      'Detailed',
      name: 'taskFilterViewFieldDetailed',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get taskFilter {
    return Intl.message(
      'All',
      name: 'taskFilter',
      desc: '',
      args: [],
    );
  }

  /// `By date`
  String get taskFilterDate {
    return Intl.message(
      'By date',
      name: 'taskFilterDate',
      desc: '',
      args: [],
    );
  }

  /// `Not on task`
  String get taskFilterNotOnTask {
    return Intl.message(
      'Not on task',
      name: 'taskFilterNotOnTask',
      desc: '',
      args: [],
    );
  }

  /// `Custom range`
  String get taskFilterCustomRange {
    return Intl.message(
      'Custom range',
      name: 'taskFilterCustomRange',
      desc: '',
      args: [],
    );
  }

  /// `All time`
  String get taskFilterDateFilterAllTime {
    return Intl.message(
      'All time',
      name: 'taskFilterDateFilterAllTime',
      desc: '',
      args: [],
    );
  }

  /// `last day`
  String get taskFilterDateFilterLastDay {
    return Intl.message(
      'last day',
      name: 'taskFilterDateFilterLastDay',
      desc: '',
      args: [],
    );
  }

  /// `last 7 days`
  String get taskFilterDateFilterLast7Days {
    return Intl.message(
      'last 7 days',
      name: 'taskFilterDateFilterLast7Days',
      desc: '',
      args: [],
    );
  }

  /// `last 30 days`
  String get taskFilterDateFilterLast30Days {
    return Intl.message(
      'last 30 days',
      name: 'taskFilterDateFilterLast30Days',
      desc: '',
      args: [],
    );
  }

  /// `Not set`
  String get taskFilterDateFilterNotSet {
    return Intl.message(
      'Not set',
      name: 'taskFilterDateFilterNotSet',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get sensorDetailGraphFromStart {
    return Intl.message(
      'All',
      name: 'sensorDetailGraphFromStart',
      desc: '',
      args: [],
    );
  }

  /// `1D`
  String get sensorDetailGraph1D {
    return Intl.message(
      '1D',
      name: 'sensorDetailGraph1D',
      desc: '',
      args: [],
    );
  }

  /// `5D`
  String get sensorDetailGraph5d {
    return Intl.message(
      '5D',
      name: 'sensorDetailGraph5d',
      desc: '',
      args: [],
    );
  }

  /// `1M`
  String get sensorDetailGraph1M {
    return Intl.message(
      '1M',
      name: 'sensorDetailGraph1M',
      desc: '',
      args: [],
    );
  }

  /// `Date range`
  String get sensorDetailGraphDateRange {
    return Intl.message(
      'Date range',
      name: 'sensorDetailGraphDateRange',
      desc: '',
      args: [],
    );
  }

  /// `No readings`
  String get sensorDetailGraphNoDataTitle {
    return Intl.message(
      'No readings',
      name: 'sensorDetailGraphNoDataTitle',
      desc: '',
      args: [],
    );
  }

  /// `There is no data as of this moment`
  String get sensorDetailGraphNoDataSubtitle {
    return Intl.message(
      'There is no data as of this moment',
      name: 'sensorDetailGraphNoDataSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `There is no data at this period`
  String get sensorDetailGraphNoDataFiltersSubtitle {
    return Intl.message(
      'There is no data at this period',
      name: 'sensorDetailGraphNoDataFiltersSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `View for all time`
  String get sensorDetailGraphNoDataFiltersButton {
    return Intl.message(
      'View for all time',
      name: 'sensorDetailGraphNoDataFiltersButton',
      desc: '',
      args: [],
    );
  }

  /// `Note, graph contains real data, but it is `
  String get sensorDetailGraphHintDesc1 {
    return Intl.message(
      'Note, graph contains real data, but it is ',
      name: 'sensorDetailGraphHintDesc1',
      desc: '',
      args: [],
    );
  }

  /// `not`
  String get sensorDetailGraphHintDesc2 {
    return Intl.message(
      'not',
      name: 'sensorDetailGraphHintDesc2',
      desc: '',
      args: [],
    );
  }

  /// ` live.\n`
  String get sensorDetailGraphHintDesc3 {
    return Intl.message(
      ' live.\n',
      name: 'sensorDetailGraphHintDesc3',
      desc: '',
      args: [],
    );
  }

  /// `To see it live, upload the sensor data to the cloud and refresh`
  String get sensorDetailGraphHintDesc4 {
    return Intl.message(
      'To see it live, upload the sensor data to the cloud and refresh',
      name: 'sensorDetailGraphHintDesc4',
      desc: '',
      args: [],
    );
  }

  /// `high limit`
  String get taskDetailAlertHighLimitShort {
    return Intl.message(
      'high limit',
      name: 'taskDetailAlertHighLimitShort',
      desc: '',
      args: [],
    );
  }

  /// `High limit alarms`
  String get taskDetailAlertHighLimitLong {
    return Intl.message(
      'High limit alarms',
      name: 'taskDetailAlertHighLimitLong',
      desc: '',
      args: [],
    );
  }

  /// `High limit`
  String get taskDetailAlertHighLimitLongVariant {
    return Intl.message(
      'High limit',
      name: 'taskDetailAlertHighLimitLongVariant',
      desc: '',
      args: [],
    );
  }

  /// `high limit clear`
  String get taskDetailAlertHighLimitClearShort {
    return Intl.message(
      'high limit clear',
      name: 'taskDetailAlertHighLimitClearShort',
      desc: '',
      args: [],
    );
  }

  /// `High limit clear`
  String get taskDetailAlertHighLimitClearLong {
    return Intl.message(
      'High limit clear',
      name: 'taskDetailAlertHighLimitClearLong',
      desc: '',
      args: [],
    );
  }

  /// `High limit clear`
  String get taskDetailAlertHighLimitClearLongVariant {
    return Intl.message(
      'High limit clear',
      name: 'taskDetailAlertHighLimitClearLongVariant',
      desc: '',
      args: [],
    );
  }

  /// `low limit clear`
  String get taskDetailAlertLowLimitClearShort {
    return Intl.message(
      'low limit clear',
      name: 'taskDetailAlertLowLimitClearShort',
      desc: '',
      args: [],
    );
  }

  /// `Low limit clear`
  String get taskDetailAlertLowLimitClearLong {
    return Intl.message(
      'Low limit clear',
      name: 'taskDetailAlertLowLimitClearLong',
      desc: '',
      args: [],
    );
  }

  /// `Low limit clear`
  String get taskDetailAlertLowLimitClearLongVariant {
    return Intl.message(
      'Low limit clear',
      name: 'taskDetailAlertLowLimitClearLongVariant',
      desc: '',
      args: [],
    );
  }

  /// `low limit`
  String get taskDetailAlertLowLimitShort {
    return Intl.message(
      'low limit',
      name: 'taskDetailAlertLowLimitShort',
      desc: '',
      args: [],
    );
  }

  /// `Low limit alarms`
  String get taskDetailAlertLowLimitLong {
    return Intl.message(
      'Low limit alarms',
      name: 'taskDetailAlertLowLimitLong',
      desc: '',
      args: [],
    );
  }

  /// `Low limit`
  String get taskDetailAlertLowLimitLongVariant {
    return Intl.message(
      'Low limit',
      name: 'taskDetailAlertLowLimitLongVariant',
      desc: '',
      args: [],
    );
  }

  /// `low battery`
  String get taskDetailAlertLowBatteryShort {
    return Intl.message(
      'low battery',
      name: 'taskDetailAlertLowBatteryShort',
      desc: '',
      args: [],
    );
  }

  /// `Low battery`
  String get taskDetailAlertLowBatteryLong {
    return Intl.message(
      'Low battery',
      name: 'taskDetailAlertLowBatteryLong',
      desc: '',
      args: [],
    );
  }

  /// `Low battery`
  String get taskDetailAlertLowBatteryLongVariant {
    return Intl.message(
      'Low battery',
      name: 'taskDetailAlertLowBatteryLongVariant',
      desc: '',
      args: [],
    );
  }

  /// `Low limit`
  String get eventTaskDetailLowLimit {
    return Intl.message(
      'Low limit',
      name: 'eventTaskDetailLowLimit',
      desc: '',
      args: [],
    );
  }

  /// `High limit`
  String get eventTaskDetailHighLimit {
    return Intl.message(
      'High limit',
      name: 'eventTaskDetailHighLimit',
      desc: '',
      args: [],
    );
  }

  /// `No limits set`
  String get eventTaskDetailNoLimits {
    return Intl.message(
      'No limits set',
      name: 'eventTaskDetailNoLimits',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get labelAll {
    return Intl.message(
      'All',
      name: 'labelAll',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get labelEvents {
    return Intl.message(
      'Events',
      name: 'labelEvents',
      desc: '',
      args: [],
    );
  }

  /// `Readings`
  String get labelReadings {
    return Intl.message(
      'Readings',
      name: 'labelReadings',
      desc: '',
      args: [],
    );
  }

  /// `Enroll Sensor`
  String get enrollSensorLabel {
    return Intl.message(
      'Enroll Sensor',
      name: 'enrollSensorLabel',
      desc: '',
      args: [],
    );
  }

  /// `We need to enroll this sensor ({sn})`
  String enrollSensorTitle(Object sn) {
    return Intl.message(
      'We need to enroll this sensor ($sn)',
      name: 'enrollSensorTitle',
      desc: '',
      args: [sn],
    );
  }

  /// `Please wake it up by pressing its button for 3 seconds before continuing.`
  String get enrollSensolText {
    return Intl.message(
      'Please wake it up by pressing its button for 3 seconds before continuing.',
      name: 'enrollSensolText',
      desc: '',
      args: [],
    );
  }

  /// `Please wake it up by pressing its button for 3 seconds before continuing.\n\nExiting will leave the sensor unenrolled.`
  String get enrollSensolTextDetailed {
    return Intl.message(
      'Please wake it up by pressing its button for 3 seconds before continuing.\n\nExiting will leave the sensor unenrolled.',
      name: 'enrollSensolTextDetailed',
      desc: '',
      args: [],
    );
  }

  /// `Sensor ({sn}) enrolled on another tenant`
  String enrolledSensorTitle(Object sn) {
    return Intl.message(
      'Sensor ($sn) enrolled on another tenant',
      name: 'enrolledSensorTitle',
      desc: '',
      args: [sn],
    );
  }

  /// `This sensor is already enrolled on another tenant and cannot be used.\n\nPlease unenroll it or try another sensor.`
  String get enrolledSensorText {
    return Intl.message(
      'This sensor is already enrolled on another tenant and cannot be used.\n\nPlease unenroll it or try another sensor.',
      name: 'enrolledSensorText',
      desc: '',
      args: [],
    );
  }

  /// `Sensor ({sn}) is pending enrollment`
  String enrollSensorPendingTitle(Object sn) {
    return Intl.message(
      'Sensor ($sn) is pending enrollment',
      name: 'enrollSensorPendingTitle',
      desc: '',
      args: [sn],
    );
  }

  /// `Please wake it up by pressing its button for 3 seconds before continuing.\n\nExiting will leave the sensor enrollment pending.`
  String get enrollSensorPendingText {
    return Intl.message(
      'Please wake it up by pressing its button for 3 seconds before continuing.\n\nExiting will leave the sensor enrollment pending.',
      name: 'enrollSensorPendingText',
      desc: '',
      args: [],
    );
  }

  /// `Could not verify sensor ({sn}) enrollment`
  String enrollSensorNotVerifiedTitle(Object sn) {
    return Intl.message(
      'Could not verify sensor ($sn) enrollment',
      name: 'enrollSensorNotVerifiedTitle',
      desc: '',
      args: [sn],
    );
  }

  /// `Verifying sensor enrollment...`
  String get enrollSensorVerify {
    return Intl.message(
      'Verifying sensor enrollment...',
      name: 'enrollSensorVerify',
      desc: '',
      args: [],
    );
  }

  /// `This may take 1-2 minutes.`
  String get enrollSensorVerifyDesc {
    return Intl.message(
      'This may take 1-2 minutes.',
      name: 'enrollSensorVerifyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please wake up the sensor by pressing its button for 3 seconds before trying again.\n\nExiting will leave the sensor enrollment pending.`
  String get enrollSensorNotVerifiedText {
    return Intl.message(
      'Please wake up the sensor by pressing its button for 3 seconds before trying again.\n\nExiting will leave the sensor enrollment pending.',
      name: 'enrollSensorNotVerifiedText',
      desc: '',
      args: [],
    );
  }

  /// `Sensor ({sn}) successfully enrolled`
  String enrollSensorSuccessTitle(Object sn) {
    return Intl.message(
      'Sensor ($sn) successfully enrolled',
      name: 'enrollSensorSuccessTitle',
      desc: '',
      args: [sn],
    );
  }

  /// `Now that it's enrolled, we can create and add it to a task.\n\nExiting will leave the sensor enrolled.`
  String get enrollSensorSuccessText {
    return Intl.message(
      'Now that it\'s enrolled, we can create and add it to a task.\n\nExiting will leave the sensor enrolled.',
      name: 'enrollSensorSuccessText',
      desc: '',
      args: [],
    );
  }

  /// `Could not fetch the sensor information`
  String get couldNotFetchSensorInformationTitle {
    return Intl.message(
      'Could not fetch the sensor information',
      name: 'couldNotFetchSensorInformationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please rescan the QR code or re-enter the sensor's serial number and try again.`
  String get couldNotFetchSensorInformationText {
    return Intl.message(
      'Please rescan the QR code or re-enter the sensor\'s serial number and try again.',
      name: 'couldNotFetchSensorInformationText',
      desc: '',
      args: [],
    );
  }

  /// `({val} seconds remaining)`
  String scanTimeRemaining(Object val) {
    return Intl.message(
      '($val seconds remaining)',
      name: 'scanTimeRemaining',
      desc: '',
      args: [val],
    );
  }

  /// `Task Status`
  String get taskStatus {
    return Intl.message(
      'Task Status',
      name: 'taskStatus',
      desc: '',
      args: [],
    );
  }

  /// `Sensor Status`
  String get sensorStatus {
    return Intl.message(
      'Sensor Status',
      name: 'sensorStatus',
      desc: '',
      args: [],
    );
  }

  /// `Task Start`
  String get taskStart {
    return Intl.message(
      'Task Start',
      name: 'taskStart',
      desc: '',
      args: [],
    );
  }

  /// `Task End`
  String get taskEnd {
    return Intl.message(
      'Task End',
      name: 'taskEnd',
      desc: '',
      args: [],
    );
  }

  /// `Sensor Serial Number`
  String get sensorSerialNumber {
    return Intl.message(
      'Sensor Serial Number',
      name: 'sensorSerialNumber',
      desc: '',
      args: [],
    );
  }

  /// `Sensor Task Status`
  String get sensorTaskStatus {
    return Intl.message(
      'Sensor Task Status',
      name: 'sensorTaskStatus',
      desc: '',
      args: [],
    );
  }

  /// `View Alarms ({val})`
  String viewAlarms(Object val) {
    return Intl.message(
      'View Alarms ($val)',
      name: 'viewAlarms',
      desc: '',
      args: [val],
    );
  }

  /// `Number of Sensors`
  String get numberOfSensors {
    return Intl.message(
      'Number of Sensors',
      name: 'numberOfSensors',
      desc: '',
      args: [],
    );
  }

  /// `Task Name`
  String get taskName {
    return Intl.message(
      'Task Name',
      name: 'taskName',
      desc: '',
      args: [],
    );
  }

  /// `Sensor Name`
  String get sensorName {
    return Intl.message(
      'Sensor Name',
      name: 'sensorName',
      desc: '',
      args: [],
    );
  }

  /// `Unverified Data`
  String get unverifiedData {
    return Intl.message(
      'Unverified Data',
      name: 'unverifiedData',
      desc: '',
      args: [],
    );
  }

  /// `Reading Interval`
  String get readingInterval {
    return Intl.message(
      'Reading Interval',
      name: 'readingInterval',
      desc: '',
      args: [],
    );
  }

  /// `Loop Override`
  String get loopOverride {
    return Intl.message(
      'Loop Override',
      name: 'loopOverride',
      desc: '',
      args: [],
    );
  }

  /// `Start Mode`
  String get startMode {
    return Intl.message(
      'Start Mode',
      name: 'startMode',
      desc: '',
      args: [],
    );
  }

  /// `Alarm Settings`
  String get alarmSettings {
    return Intl.message(
      'Alarm Settings',
      name: 'alarmSettings',
      desc: '',
      args: [],
    );
  }

  /// `Task Details`
  String get taskDetails {
    return Intl.message(
      'Task Details',
      name: 'taskDetails',
      desc: '',
      args: [],
    );
  }

  /// `Reading`
  String get eventReading {
    return Intl.message(
      'Reading',
      name: 'eventReading',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get eventTime {
    return Intl.message(
      'Time',
      name: 'eventTime',
      desc: '',
      args: [],
    );
  }

  /// `Event Type`
  String get eventType {
    return Intl.message(
      'Event Type',
      name: 'eventType',
      desc: '',
      args: [],
    );
  }

  /// `Alarm Type`
  String get alarmType {
    return Intl.message(
      'Alarm Type',
      name: 'alarmType',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get alarmTime {
    return Intl.message(
      'Time',
      name: 'alarmTime',
      desc: '',
      args: [],
    );
  }

  /// `Temperature`
  String get alarmTemperature {
    return Intl.message(
      'Temperature',
      name: 'alarmTemperature',
      desc: '',
      args: [],
    );
  }

  /// `Serial Number`
  String get serialNumber {
    return Intl.message(
      'Serial Number',
      name: 'serialNumber',
      desc: '',
      args: [],
    );
  }

  /// `MAC Address`
  String get macAddress {
    return Intl.message(
      'MAC Address',
      name: 'macAddress',
      desc: '',
      args: [],
    );
  }

  /// `Alarms`
  String get alarms {
    return Intl.message(
      'Alarms',
      name: 'alarms',
      desc: '',
      args: [],
    );
  }

  /// `Last Updated`
  String get lastUpdated {
    return Intl.message(
      'Last Updated',
      name: 'lastUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Value must not be empty`
  String get errorNotEmpty {
    return Intl.message(
      'Value must not be empty',
      name: 'errorNotEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Value must be more or equal to zero`
  String get errorPositiveNumber {
    return Intl.message(
      'Value must be more or equal to zero',
      name: 'errorPositiveNumber',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `ZSFinder is not installed`
  String get zsfinderNotInstalled {
    return Intl.message(
      'ZSFinder is not installed',
      name: 'zsfinderNotInstalled',
      desc: '',
      args: [],
    );
  }

  /// `This application requires that the ZSFinder service is installed and running.`
  String get zsfinderRequired {
    return Intl.message(
      'This application requires that the ZSFinder service is installed and running.',
      name: 'zsfinderRequired',
      desc: '',
      args: [],
    );
  }

  /// `Download from Google Play`
  String get downloadFromGooglePlay {
    return Intl.message(
      'Download from Google Play',
      name: 'downloadFromGooglePlay',
      desc: '',
      args: [],
    );
  }

  /// `Incompatible version of ZSFinder`
  String get zsfinderIncompatible {
    return Intl.message(
      'Incompatible version of ZSFinder',
      name: 'zsfinderIncompatible',
      desc: '',
      args: [],
    );
  }

  /// `This application requires that a newer version of ZSFinder service is installed.`
  String get zsfinderUpdateRequired {
    return Intl.message(
      'This application requires that a newer version of ZSFinder service is installed.',
      name: 'zsfinderUpdateRequired',
      desc: '',
      args: [],
    );
  }

  /// `ZSFinder permissions not granted`
  String get zsfinderPermissionsDenied {
    return Intl.message(
      'ZSFinder permissions not granted',
      name: 'zsfinderPermissionsDenied',
      desc: '',
      args: [],
    );
  }

  /// `This application requires that the ZSFinder service has all necessary permissions.`
  String get zsfinderPermissionsRequired {
    return Intl.message(
      'This application requires that the ZSFinder service has all necessary permissions.',
      name: 'zsfinderPermissionsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Grant Permissions`
  String get zsfinderGrantPermissions {
    return Intl.message(
      'Grant Permissions',
      name: 'zsfinderGrantPermissions',
      desc: '',
      args: [],
    );
  }

  /// `ZSFinder failed to bind`
  String get zsfinderBindFailed {
    return Intl.message(
      'ZSFinder failed to bind',
      name: 'zsfinderBindFailed',
      desc: '',
      args: [],
    );
  }

  /// `Try opening ZSFinder service to ensure it is running and then open this application again.`
  String get zsfinderRebind {
    return Intl.message(
      'Try opening ZSFinder service to ensure it is running and then open this application again.',
      name: 'zsfinderRebind',
      desc: '',
      args: [],
    );
  }

  /// `Open ZSFinder`
  String get zsfinderOpen {
    return Intl.message(
      'Open ZSFinder',
      name: 'zsfinderOpen',
      desc: '',
      args: [],
    );
  }

  /// `Sensor cannot be used`
  String get associateSensorErrorGeneralTitle {
    return Intl.message(
      'Sensor cannot be used',
      name: 'associateSensorErrorGeneralTitle',
      desc: '',
      args: [],
    );
  }

  /// `Failed to associate sensor to task`
  String get associateSensorErrorTitle {
    return Intl.message(
      'Failed to associate sensor to task',
      name: 'associateSensorErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Unspecified error associating sensor to task.`
  String get associateSensorErrorUnspecified {
    return Intl.message(
      'Unspecified error associating sensor to task.',
      name: 'associateSensorErrorUnspecified',
      desc: '',
      args: [],
    );
  }

  /// `Could not associate sensor to task because of a low battery.`
  String get associateSensorErrorLowBattery {
    return Intl.message(
      'Could not associate sensor to task because of a low battery.',
      name: 'associateSensorErrorLowBattery',
      desc: '',
      args: [],
    );
  }

  /// `Could not associate sensor to task because it is on another task.`
  String get associateSensorErrorActive {
    return Intl.message(
      'Could not associate sensor to task because it is on another task.',
      name: 'associateSensorErrorActive',
      desc: '',
      args: [],
    );
  }

  /// `Sensor has a pending unenrollment. Bring it in range of a bridge to complete the unenrollment, then scan its QR code again to re-enroll it.`
  String get associateSensorErrorPendingUnenrollment {
    return Intl.message(
      'Sensor has a pending unenrollment. Bring it in range of a bridge to complete the unenrollment, then scan its QR code again to re-enroll it.',
      name: 'associateSensorErrorPendingUnenrollment',
      desc: '',
      args: [],
    );
  }

  /// `Attempting to send task to sensor...`
  String get associateSensorSendToTaskAttempt {
    return Intl.message(
      'Attempting to send task to sensor...',
      name: 'associateSensorSendToTaskAttempt',
      desc: '',
      args: [],
    );
  }

  /// `Task successfully created`
  String get associateSensorTaskCreated {
    return Intl.message(
      'Task successfully created',
      name: 'associateSensorTaskCreated',
      desc: '',
      args: [],
    );
  }

  /// `Sensor is in start pending for its task`
  String get associateSensorPendingTitle {
    return Intl.message(
      'Sensor is in start pending for its task',
      name: 'associateSensorPendingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please wake up the sensor again by pressing its button for 3 seconds before continuing`
  String get associateSensorPendingDescription {
    return Intl.message(
      'Please wake up the sensor again by pressing its button for 3 seconds before continuing',
      name: 'associateSensorPendingDescription',
      desc: '',
      args: [],
    );
  }

  /// `Download CSV`
  String get downloadCSV {
    return Intl.message(
      'Download CSV',
      name: 'downloadCSV',
      desc: '',
      args: [],
    );
  }

  /// `Downloading..`
  String get downloading {
    return Intl.message(
      'Downloading..',
      name: 'downloading',
      desc: '',
      args: [],
    );
  }

  /// `Downloading failed.`
  String get downloadedErrored {
    return Intl.message(
      'Downloading failed.',
      name: 'downloadedErrored',
      desc: '',
      args: [],
    );
  }

  /// `File successfully downloaded.`
  String get downloadedSuccessfully {
    return Intl.message(
      'File successfully downloaded.',
      name: 'downloadedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `File downloaded succesfully`
  String get downloadMessageSuccess {
    return Intl.message(
      'File downloaded succesfully',
      name: 'downloadMessageSuccess',
      desc: '',
      args: [],
    );
  }

  /// `File with name "{n}" is located at "{p}"`
  String downloadedCSVpath(Object n, Object p) {
    return Intl.message(
      'File with name "$n" is located at "$p"',
      name: 'downloadedCSVpath',
      desc: '',
      args: [n, p],
    );
  }

  /// `Request failed. Please check your internet connection and try again.`
  String get errorNoInternetConnection {
    return Intl.message(
      'Request failed. Please check your internet connection and try again.',
      name: 'errorNoInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `We are having trouble connecting to the server. Please try again.`
  String get errorServerConneciton {
    return Intl.message(
      'We are having trouble connecting to the server. Please try again.',
      name: 'errorServerConneciton',
      desc: '',
      args: [],
    );
  }

  /// `Request timed out. Please try again.`
  String get errorTimeout {
    return Intl.message(
      'Request timed out. Please try again.',
      name: 'errorTimeout',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '' key
}

class AppLocalizationDelegate extends LocalizationsDelegate<Loco> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Loco> load(Locale locale) => Loco.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
