import 'package:flutter/foundation.dart';

/// {@template error_radar_api}
/// Interface for error radar service delegates.
///
/// This interface should be extended implementing the preferred library for
/// error radar. For instance,
/// [sentry](https://pub.dev/packages/sentry) or
/// [firebase_crashlytics](https://pub.dev/packages/firebase_crashlytics).
/// {@endtemplate}
abstract class ErrorRadarDelegate {
  /// {@macro error_radar_repository}
  const ErrorRadarDelegate();

  /// Returns whether the error collection is enabled by the user.
  bool get isCollectionEnabled;

  /// Captures exception and sends it to the error collection service.
  void captureException(Object exception, StackTrace stackTrace);

  /// Enables or disables the error collection.
  void setCollectionEnabled({required bool enabled});

  /// Records a fatal error caught by the Flutter framework. For
  /// PlatformDispatcher errors, see [recordPlatformDispatcherError].
  void recordFlutterFatalError(FlutterErrorDetails details);

  /// Records a fatal error caught by the PlatformDispatcher.
  void recordPlatformDispatcherError(Object object, StackTrace stack);
}

/// {@template multi_error_radar_repository}
/// A repository that uses multiple error collection services.
/// This is useful when you want to use multiple error collection services
/// (e.g. Sentry and Crashlytics) and you want to use the same API for
/// capturing exceptions.
/// {@endtemplate}
final class MultiErrorRadar {
  /// {@macro multi_error_radar_repository}
  const MultiErrorRadar({
    required List<ErrorRadarDelegate> radars,
  }) : _radars = radars;

  final List<ErrorRadarDelegate> _radars;

  /// Returns `true` if all radars are enabled.
  bool get isCollectionEnabled => _radars.every((e) => e.isCollectionEnabled);

  /// Captures exception and sends it to registered error collection
  /// services.
  void captureException(Object exception, StackTrace stackTrace) {
    for (final radar in _radars) {
      if (!radar.isCollectionEnabled) continue;
      radar.captureException(exception, stackTrace);
    }
  }

  /// Enables or disables the error collection for all registered services.
  void setCollectionEnabled({required bool enabled}) {
    for (final radar in _radars) {
      radar.setCollectionEnabled(enabled: enabled);
    }
  }

  /// Records a fatal error caught by the Flutter framework. For
  /// PlatformDispatcher errors, see [recordPlatformDispatcherError].
  void recordFlutterFatalError(FlutterErrorDetails details) {
    for (final radar in _radars) {
      if (!radar.isCollectionEnabled) continue;
      radar.recordFlutterFatalError(details);
    }
  }

  /// Records a fatal error caught by the PlatformDispatcher.
  bool recordPlatformDispatcherError(Object object, StackTrace stack) {
    for (final radar in _radars) {
      if (!radar.isCollectionEnabled) continue;
      radar.recordPlatformDispatcherError(object, stack);
    }
    return true;
  }
}
