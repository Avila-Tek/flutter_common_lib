import 'package:avilatek_core/src/interfaces/error_radar.dart';
import 'package:flutter/foundation.dart';

/// {@template multi_error_radar_repository}
/// A repository that uses multiple error collection services.
/// This is useful when you want to use multiple error collection services
/// (e.g. Sentry and Crashlytics) and you want to use the same API for
/// capturing exceptions.
/// {@endtemplate}
class MultiErrorRadarRepository implements IErrorRadarRepository {
  /// {@macro multi_error_radar_repository}
  const MultiErrorRadarRepository({
    required List<IErrorRadarDelegate> radars,
  }) : _radars = radars;

  final List<IErrorRadarDelegate> _radars;

  /// Returns `true` if all radars are enabled.
  @override
  bool get isCollectionEnabled => _radars.every((e) => e.isCollectionEnabled);

  @override
  void captureException(Object exception, StackTrace stackTrace) {
    for (final radar in _radars) {
      if (!radar.isCollectionEnabled) continue;
      radar.captureException(exception, stackTrace);
    }
  }

  @override
  void setCollectionEnabled({required bool enabled}) {
    for (final radar in _radars) {
      radar.setCollectionEnabled(enabled: enabled);
    }
  }

  @override
  void recordFlutterFatalError(FlutterErrorDetails details) {
    for (final radar in _radars) {
      if (!radar.isCollectionEnabled) continue;
      radar.recordFlutterFatalError(details);
    }
  }

  @override
  bool recordPlatformDispatcherError(Object object, StackTrace stack) {
    for (final radar in _radars) {
      if (!radar.isCollectionEnabled) continue;
      radar.recordPlatformDispatcherError(object, stack);
    }
    return true;
  }
}

/// {@template error_radar_repository}
/// A repository that uses a single error collection service. For usecases where
/// more than one error collection service is needed, use
/// [MultiErrorRadarRepository] instead.
/// {@endtemplate}
class ErrorRadarRepository implements IErrorRadarRepository {
  /// {@macro error_radar_repository}
  const ErrorRadarRepository({
    required IErrorRadarDelegate radar,
  }) : _radar = radar;

  final IErrorRadarDelegate _radar;

  @override
  bool get isCollectionEnabled => _radar.isCollectionEnabled;

  @override
  void captureException(Object exception, StackTrace stackTrace) {
    if (!isCollectionEnabled) return;

    _radar.captureException(exception, stackTrace);
  }

  @override
  void setCollectionEnabled({required bool enabled}) =>
      _radar.setCollectionEnabled(enabled: enabled);

  @override
  void recordFlutterFatalError(FlutterErrorDetails details) {
    if (!isCollectionEnabled) return;

    _radar.recordFlutterFatalError(details);
  }

  @override
  bool recordPlatformDispatcherError(Object object, StackTrace stack) {
    if (!isCollectionEnabled) return true;

    _radar.recordPlatformDispatcherError(object, stack);
    return true;
  }
}
