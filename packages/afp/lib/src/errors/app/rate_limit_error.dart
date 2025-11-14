import 'package:afp/src/errors/errors.dart';

/// {@template rate_limit_error}
/// Represents a rate limit error that occurs when too many requests
/// are made within a specific time period.
///
/// This error typically corresponds to HTTP 429 (Too Many Requests)
/// responses and indicates that the client should wait before making
/// additional requests.
///
/// Can be created from ServerError via ErrorMapper transformation
/// {@endtemplate}
class RateLimitError extends AppError {
  /// {@macro rate_limit_error}
  const RateLimitError({
    required super.title,
    required super.message,
    this.details,
  });

  /// Creates a [RateLimitError] from a [ServerError].
  factory RateLimitError.fromServerError(ServerError serverError) {
    return RateLimitError(
      title: serverError.title,
      message: serverError.message,
      details: serverError.details,
    );
  }

  /// Optional typed details specific to rate limit errors.
  final List<dynamic>? details;

  /// Creates a [RateLimitError] from a [ServerError] with mapped details.
  static RateLimitError fromServerErrorWithMapper<T>(
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

    return RateLimitError(
      title: serverError.title,
      message: serverError.message,
      details: mappedDetails,
    );
  }
}
