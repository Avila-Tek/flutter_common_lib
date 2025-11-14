import 'package:afp/src/errors/errors.dart';

/// {@template domain_error}
/// Represents a domain error that occurs when business logic or
/// domain-specific rules are violated.
///
/// This error typically corresponds to HTTP 422 (Unprocessable Entity)
/// responses and indicates that the request is valid but violates
/// business rules or domain constraints.
///
/// Can be created from ServerError via ErrorMapper transformation
/// {@endtemplate}
class DomainError extends AppError {
  /// {@macro domain_error}
  const DomainError({
    required super.title,
    required super.message,
    this.details,
  });

  /// Creates a [DomainError] from a [ServerError].
  factory DomainError.fromServerError(ServerError serverError) {
    return DomainError(
      title: serverError.title,
      message: serverError.message,
      details: serverError.details,
    );
  }

  /// Optional typed details specific to domain errors.
  final List<dynamic>? details;

  /// Creates a [DomainError] from a [ServerError] with mapped details.
  static DomainError fromServerErrorWithMapper<T>(
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

    return DomainError(
      title: serverError.title,
      message: serverError.message,
      details: mappedDetails,
    );
  }
}
