// ignore_for_file: lines_longer_than_80_chars

import 'package:afp/src/errors/errors.dart';
import 'package:afp/src/interfaces/interfaces.dart';

/// {@template server_error}
/// Represents an error that originates from a server/API response.
///
/// This class extends [BaseError] and contains all the server-specific
/// error information including type classification, error codes, HTTP status,
/// and structured details. It provides a standardized way to handle
/// server-side errors and serves as the source for ErrorMapper transformations
/// into application-specific error types.
/// {@endtemplate}
class ServerError extends BaseError {
  /// {@macro server_error}
  const ServerError({
    required this.type,
    required this.code,
    required this.title,
    required this.message,
    required this.status,
    this.details,
  });

  /// Creates a [ServerError] from a JSON map representation.
  ///
  /// This factory constructor parses a server error response and creates
  /// a [ServerError] instance with the appropriate fields. It handles
  /// missing or null values by providing sensible defaults.
  ///
  /// The [map] parameter should contain the following keys:
  /// - `type`: Error type string (mapped to [ServerErrorType])
  /// - `code`: Error code string
  /// - `title`: Error title string
  /// - `message`: Error message string
  /// - `status`: HTTP status code (defaults to 500 if missing)
  /// - `details`: Optional list of additional error details
  ///
  /// Example:
  /// ```dart
  /// final errorMap = {
  ///   'type': 'VALIDATION_ERROR',
  ///   'code': 'INVALID_EMAIL',
  ///   'title': 'Validation Failed',
  ///   'message': 'The email format is invalid',
  ///   'status': 400,
  ///   'details': [...]
  /// };
  ///
  /// final error = ServerError.fromMap(errorMap);
  /// ```
  factory ServerError.fromMap(Map<String, dynamic> map) {
    return ServerError(
      type: ServerErrorType.fromValue(map['type'] as String? ?? ''),
      code: map['code'] as String? ?? '',
      title: map['title'] as String? ?? '',
      message: map['message'] as String? ?? '',
      status: map['status'] as int? ?? 500,
      details: map['details'] as List?,
    );
  }

  /// Error type classification from the server response.
  ///
  /// This represents the server's categorization of the error and is used
  /// by ErrorMapper for fallback type-based mapping when specific codes
  /// aren't recognized.
  ///
  /// Example: Server returns 'VALIDATION_ERROR' → [ServerErrorType.validationError]
  final ServerErrorType type;

  /// Unique error code from the server.
  ///
  /// Machine-readable identifier that should be stable across API versions
  /// and is used as the primary key for ErrorMapper code-based transformations.
  ///
  /// Examples: 'USER_NOT_FOUND', 'INVALID_EMAIL_FORMAT', 'TOKEN_EXPIRED'
  final String code;

  /// Error title from the server response.
  ///
  /// Brief error summary provided by the server.
  ///
  /// Example: 'Validation Failed'
  final String title;

  /// Detailed error message from the server.
  ///
  /// Server-provided error description that gives more context about the error.
  final String message;

  /// HTTP status code from the server response.
  ///
  /// Standard HTTP status code that reflects the server's assessment
  /// of the error type and maintains compatibility with HTTP-based
  /// error handling patterns.
  ///
  /// Common values: 400, 401, 403, 404, 409, 429, 500
  final int status;

  /// Structured error details from the server response.
  ///
  /// Contains additional error information that can be transformed
  /// into strongly-typed objects via ErrorMapper detailsMapper functions.
  ///
  /// Common patterns:
  /// - Field validation errors with field names and messages
  /// - Business logic errors with domain-specific data
  /// - Rate limiting information with retry timing
  final List<dynamic>? details;

  @override
  String toString() {
    return '[$status]: ${type.name} - $code';
  }
}
