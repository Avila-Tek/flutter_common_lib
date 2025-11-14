import 'package:afp/src/errors/errors.dart';

/// {@template not_found_error}
/// Represents a not found error that occurs when a requested resource
/// cannot be located.
///
/// This error typically corresponds to HTTP 404 (Not Found) responses and
/// indicates that the requested resource doesn't exist or is not accessible.
///
/// Can be created from ServerError via ErrorMapper transformation
/// {@endtemplate}
class NotFoundError extends AppError {
  /// {@macro not_found_error}
  const NotFoundError({
    required super.title,
    required super.message,
    this.details,
  });

  /// Creates a [NotFoundError] from a [ServerError].
  factory NotFoundError.fromServerError(ServerError serverError) {
    return NotFoundError(
      title: serverError.title,
      message: serverError.message,
      details: serverError.details,
    );
  }

  /// Optional typed details specific to not found errors.
  ///
  /// Contains structured information about the missing resource,
  /// such as resource IDs, expected locations, or alternative suggestions.
  final List<dynamic>? details;

  /// Creates a [NotFoundError] from a [ServerError] with mapped details.
  static NotFoundError fromServerErrorWithMapper<T>(
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

    return NotFoundError(
      title: serverError.title,
      message: serverError.message,
      details: mappedDetails,
    );
  }
}
