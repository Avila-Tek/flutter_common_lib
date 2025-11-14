import 'package:afp/src/errors/errors.dart';

/// {@template validation_error}
/// Represents a validation error that occurs when input data fails validation
/// rules.
///
/// This error typically corresponds to HTTP 400 (Bad Request) responses and
/// contains specific details about which fields failed validation and why.
///
/// Can be created from ServerError via ErrorMapper transformation
/// {@endtemplate}
class ValidationError extends AppError {
  /// {@macro validation_error}
  const ValidationError({
    required super.title,
    required super.message,
    this.details,
  });

  /// Creates a [ValidationError] from a [ServerError].
  ///
  /// Transforms server validation error into application-level error.
  ///
  /// Example:
  /// ```dart
  /// final validationError = ValidationError.fromServerError(serverError);
  /// ```
  factory ValidationError.fromServerError(ServerError serverError) {
    return ValidationError(
      title: serverError.title,
      message: serverError.message,
      details: serverError.details,
    );
  }

  /// Optional typed details specific to validation errors.
  ///
  /// Contains structured information about validation failures,
  /// such as field names, error messages, and validation rules that failed.
  final List<dynamic>? details;

  /// Creates a [ValidationError] from a [ServerError] with mapped details.
  ///
  /// The [detailsMapper] function allows you to transform the raw server
  /// details into specific model objects. This is useful when validation errors
  /// contain structured field information.
  ///
  /// Example:
  /// ```dart
  /// final error = ValidationError.fromServerErrorWithMapper(
  ///   serverError,
  ///   detailsMapper: (detailMap) => FieldError.fromMap(detailMap),
  /// );
  /// ```
  static ValidationError fromServerErrorWithMapper<T>(
    ServerError serverError, {
    required T Function(Map<String, dynamic>) detailsMapper,
  }) {
    List<T>? mappedDetails;
    if (serverError.details != null) {
      mappedDetails = serverError.details!
          .whereType<Map<String, dynamic>>()
          .map((Map<String, dynamic> item) => detailsMapper(item))
          .toList();
    }

    return ValidationError(
      title: serverError.title,
      message: serverError.message,
      details: mappedDetails,
    );
  }
}
