import 'package:afp/src/interfaces/interfaces.dart';

/// {@template app_error}
/// Base application error class that provides a unified error handling system.
///
/// This class extends [BaseError] and serves as the foundation for all
/// application-level errors regardless of their origin. AppErrors can be:
///
/// - **Transformed from ServerErrors**: Via ErrorMapper from API responses
/// - **Created directly**: For local validation, business logic, or package
/// errors
/// - **Thrown by packages**: External library errors wrapped as AppErrors
///
/// The class supports flexible error creation and provides standardized
/// application-level error information that is consistent regardless of
/// the error's origin.
/// {@endtemplate}
class AppError extends BaseError {
  /// {@macro app_error}
  const AppError({
    required this.title,
    required this.message,
  });

  /// Short, human-readable title for the error.
  final String title;

  /// Human-readable error message for the application.
  ///
  /// This message should be appropriate for displaying to users or
  /// for application logging.
  final String message;

  /// Returns a string representation of the error.
  ///
  /// Format: `AppError: message`
  ///
  /// Example: `AppError: Email format is invalid`
  @override
  String toString() {
    // ignore: no_runtimetype_tostring
    return '$runtimeType: $message';
  }
}
