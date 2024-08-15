import 'package:flutter/foundation.dart';

/// {@template error_radar_repository}
/// Interface for error radar repositories. This class should depend on
/// [IErrorRadarDelegate] to provide the implementation for the error collection
/// service.
/// {@endtemplate}
abstract class IErrorRadarRepository {
  /// {@macro error_radar_repository}
  const IErrorRadarRepository();

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
  bool recordPlatformDispatcherError(Object object, StackTrace stack);
}

/// {@template error_radar_api}
/// Interface for error radar service delegates.
///
/// This interface should be extended implementing the preferred library for
/// error radar. For instance,
/// [sentry](https://pub.dev/packages/sentry) or
/// [firebase_crashlytics](https://pub.dev/packages/firebase_crashlytics).
/// {@endtemplate}
abstract class IErrorRadarDelegate {
  /// Returns whether the error collection is enabled by the user.
  bool get isCollectionEnabled;

  /// Captures exception and sends it to the error collection service.
  Future<void> captureException(Object exception, StackTrace stackTrace);

  /// Enables or disables the error collection.
  Future<void> setCollectionEnabled({required bool enabled});

  /// Records a fatal error caught by the Flutter framework. For
  Future<void> recordFlutterFatalError(FlutterErrorDetails details);

  /// Records a fatal error caught by the PlatformDispatcher.
  Future<void> recordPlatformDispatcherError(Object object, StackTrace stack);
}
