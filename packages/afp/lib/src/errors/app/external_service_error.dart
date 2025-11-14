import 'package:afp/src/errors/errors.dart';

/// {@template external_service_error}
/// Represents an error that occurs when external services fail or
/// are unavailable.
///
/// This error typically corresponds to HTTP 500, 502, 503 (Service Unavailable)
/// responses and indicates issues with third-party services, APIs,
/// or external dependencies.
/// {@endtemplate}
class ExternalServiceError extends AppError {
  /// {@macro external_service_error}
  const ExternalServiceError({
    required super.title,
    required super.message,
    this.details,
  });

  /// Creates an [ExternalServiceError] from a [ServerError].
  factory ExternalServiceError.fromServerError(ServerError serverError) {
    return ExternalServiceError(
      title: serverError.title,
      message: serverError.message,
      details: serverError.details,
    );
  }

  /// Optional typed details specific to external service errors.
  final List<dynamic>? details;

  /// Creates an [ExternalServiceError] from a [ServerError] with mapped
  /// details.
  static ExternalServiceError fromServerErrorWithMapper<T>(
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

    return ExternalServiceError(
      title: serverError.title,
      message: serverError.message,
      details: mappedDetails,
    );
  }
}
