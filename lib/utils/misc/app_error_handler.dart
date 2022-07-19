import 'package:base_template_project/configuration.dart';
import 'package:flutter/material.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppErrorHandler with Log4Dart {
  Future<bool> init() async {
    logDebug('Initializing AppErrorHandler...');
    if (kSentryEnabled) {
      await SentryFlutter.init(
        (options) {
          options.dsn = kSentryDsn;
          options.tracesSampleRate = 1.0;
        },
      );
    }
    return true;
  }

  void onFlutterError({required FlutterErrorDetails flutterErrorDetails}) async {
    logError('Flutter Framework internal error', exception: flutterErrorDetails.exception, stackTrace: flutterErrorDetails.stack);
    if (kSentryEnabled && kSentryLogFlutterErrors) {
      await Sentry.captureException(flutterErrorDetails.exception, stackTrace: flutterErrorDetails.stack);
    }
  }

  void onError({required Object error, required StackTrace stackTrace}) async {
    logDebug('Flutter Code error', exception: error, stackTrace: stackTrace);
    if (kSentryEnabled && kSentryLogErrors) {
      await Sentry.captureException(error, stackTrace: stackTrace);
    }
  }
}
