import 'dart:developer';
import 'package:intl/intl.dart';

void debugLog(String? message, {int? wrapWidth}) {
  final String time = DateFormat('HH:mm:ss:mm').format(DateTime.now());
  final String messageLog = "[$time]: ${message ?? ""}";
  log(messageLog);
}

void logError(String error, String? prefix, [Object? request]) {
  final stacktrace = StackTrace.current.toString();
  final clippedStackTrace = stacktrace;

  final resolvedPrefix = prefix != null ? '$prefix: ' : '';
  debugLog('----------------------------------------------------------------');
  debugLog(resolvedPrefix + error.toString());
  if (request != null) {
    debugLog('Request: --------------------------------');
    for (final requestLine in request.toString().split('\n')) {
      debugLog(requestLine);
    }
    debugLog('Request: --------------------------------');
  }
  debugLog(clippedStackTrace);
  debugLog('----------------------------------------------------------------');
}
