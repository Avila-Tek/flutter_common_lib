import 'package:afp/src/errors/errors.dart';

/// {@template conflict_error}
/// Represents a conflict error that occurs when a request conflicts with
/// the current state of the resource.
///
/// This error typically corresponds to HTTP 409 (Conflict) responses and
/// indicates that the request could not be completed due to a conflict
/// with existing data or resource state.
///
/// Can be created from ServerError via ErrorMapper transformation
/// {@endtemplate}
class ConflictError extends AppError {
  /// {@macro conflict_error}
  const ConflictError({
    required super.title,
    required super.message,
    this.details,
  });

  /// Creates a [ConflictError] from a [ServerError].
  factory ConflictError.fromServerError(ServerError serverError) {
    return ConflictError(
      title: serverError.title,
      message: serverError.message,
      details: serverError.details,
    );
  }

  /// Optional typed details specific to conflict errors.
  ///
  /// Contains structured information about the conflict,
  /// such as conflicting values, existing data, or resolution suggestions.
  final List<dynamic>? details;

  /// Creates a [ConflictError] from a [ServerError] with mapped details.
  static ConflictError fromServerErrorWithMapper<T>(
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

    return ConflictError(
      title: serverError.title,
      message: serverError.message,
      details: mappedDetails,
    );
  }
}
