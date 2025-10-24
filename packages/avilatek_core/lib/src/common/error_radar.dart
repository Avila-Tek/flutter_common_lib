import 'package:flutter/foundation.dart';

/// Enum representing different severity levels for error tracking.
enum ErrorLevel {
  /// Debug level - for debugging information
  debug,

  /// Info level - for informational messages
  info,

  /// Warning level - for warning messages
  warning,

  /// Error level - for error messages
  error,

  /// Fatal level - for fatal errors
  fatal,
}

/// Represents a breadcrumb for tracing user actions and application flow.
class ErrorBreadcrumb {
  /// Creates an [ErrorBreadcrumb] instance.
  const ErrorBreadcrumb({
    required this.message,
    this.category = 'general',
    this.level = ErrorLevel.info,
    this.data,
    this.timestamp,
  });

  /// The breadcrumb message
  final String message;

  /// The category of the breadcrumb (e.g., 'ui', 'navigation', 'api')
  final String category;

  /// The severity level of the breadcrumb
  final ErrorLevel level;

  /// Additional data associated with the breadcrumb
  final Map<String, dynamic>? data;

  /// The timestamp when the breadcrumb was created
  final DateTime? timestamp;
}

/// Represents user information for error tracking context.
class ErrorUser {
  /// Creates an [ErrorUser] instance.
  const ErrorUser({
    required this.id,
    this.email,
    this.username,
    this.extras,
  });

  /// The user's unique identifier
  final String id;

  /// The user's email address
  final String? email;

  /// The user's username
  final String? username;

  /// Additional user data
  final Map<String, dynamic>? extras;
}

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

  /// Singleton instance
  static ErrorRadarDelegate? _instance;

  /// Sets the singleton instance with the provided delegate
  static set instance(ErrorRadarDelegate delegate) {
    _instance = delegate;
  }

  /// Gets the singleton instance
  static ErrorRadarDelegate get instance {
    if (_instance == null) {
      throw StateError(
        'ErrorRadarDelegate has not been initialized. '
        'Call ErrorRadarDelegate.initialize() first.',
      );
    }
    return _instance!;
  }

  /// Returns whether the error collection is enabled by the user.
  bool get isCollectionEnabled;

  /// Captures exception and sends it to the error collection service.
  void captureException(
    Object exception,
    StackTrace stackTrace, {
    Map<String, String>? tags,
    Map<String, dynamic>? extra,
  });

  /// Captures a message without an exception.
  void captureMessage(
    String message, {
    ErrorLevel level = ErrorLevel.info,
    Map<String, String>? tags,
    Map<String, dynamic>? extra,
  });

  /// Adds a breadcrumb to the current scope.
  void addBreadcrumb(ErrorBreadcrumb breadcrumb);

  /// Sets a tag for the current scope.
  void setTag(String key, String value);

  /// Sets extra data for the current scope.
  void setExtra(String key, dynamic value);

  /// Sets user information for the current scope.
  void setUser(ErrorUser user);

  /// Clears the current scope (useful for logout scenarios).
  void clearScope();

  /// Enables or disables the error collection.
  void setCollectionEnabled({required bool enabled});

  /// Records a fatal error caught by the Flutter framework. For
  /// PlatformDispatcher errors, see [recordPlatformDispatcherError].
  void recordFlutterFatalError(FlutterErrorDetails details);

  /// Records a fatal error caught by the PlatformDispatcher.
  bool recordPlatformDispatcherError(Object object, StackTrace stack);
}

/// {@template multi_error_radar_repository}
/// A repository that uses multiple error collection services.
/// This is useful when you want to use multiple error collection services
/// (e.g. Sentry and Crashlytics) and you want to use the same API for
/// capturing exceptions.
/// {@endtemplate}
final class MultiErrorRadar extends ErrorRadarDelegate {
  /// {@macro multi_error_radar_repository}
  const MultiErrorRadar({
    required List<ErrorRadarDelegate> radars,
  }) : _radars = radars;

  final List<ErrorRadarDelegate> _radars;

  /// Returns `true` if all radars are enabled.
  @override
  bool get isCollectionEnabled => _radars.every((e) => e.isCollectionEnabled);

  /// Captures exception and sends it to registered error collection
  /// services.
  @override
  void captureException(
    Object exception,
    StackTrace stackTrace, {
    Map<String, String>? tags,
    Map<String, dynamic>? extra,
  }) {
    for (final radar in _radars) {
      if (!radar.isCollectionEnabled) continue;
      radar.captureException(exception, stackTrace, tags: tags, extra: extra);
    }
  }

  /// Captures a message and sends it to registered error collection
  /// services.
  @override
  void captureMessage(
    String message, {
    ErrorLevel level = ErrorLevel.info,
    Map<String, String>? tags,
    Map<String, dynamic>? extra,
  }) {
    for (final radar in _radars) {
      if (!radar.isCollectionEnabled) continue;
      radar.captureMessage(message, level: level, tags: tags, extra: extra);
    }
  }

  /// Adds a breadcrumb to all registered error collection services.
  @override
  void addBreadcrumb(ErrorBreadcrumb breadcrumb) {
    for (final radar in _radars) {
      if (!radar.isCollectionEnabled) continue;
      radar.addBreadcrumb(breadcrumb);
    }
  }

  /// Sets a tag for all registered error collection services.
  @override
  void setTag(String key, String value) {
    for (final radar in _radars) {
      radar.setTag(key, value);
    }
  }

  /// Sets extra data for all registered error collection services.
  @override
  void setExtra(String key, dynamic value) {
    for (final radar in _radars) {
      radar.setExtra(key, value);
    }
  }

  /// Sets user information for all registered error collection services.
  @override
  void setUser(ErrorUser user) {
    for (final radar in _radars) {
      radar.setUser(user);
    }
  }

  /// Clears the scope for all registered error collection services.
  @override
  void clearScope() {
    for (final radar in _radars) {
      radar.clearScope();
    }
  }

  /// Enables or disables the error collection for all registered services.
  @override
  void setCollectionEnabled({required bool enabled}) {
    for (final radar in _radars) {
      radar.setCollectionEnabled(enabled: enabled);
    }
  }

  /// Records a fatal error caught by the Flutter framework. For
  /// PlatformDispatcher errors, see [recordPlatformDispatcherError].
  @override
  void recordFlutterFatalError(FlutterErrorDetails details) {
    for (final radar in _radars) {
      if (!radar.isCollectionEnabled) continue;
      radar.recordFlutterFatalError(details);
    }
  }

  /// Records a fatal error caught by the PlatformDispatcher.
  @override
  bool recordPlatformDispatcherError(Object object, StackTrace stack) {
    for (final radar in _radars) {
      if (!radar.isCollectionEnabled) continue;
      radar.recordPlatformDispatcherError(object, stack);
    }
    return true;
  }
}
