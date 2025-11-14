import 'package:afp/src/errors/errors.dart';

/// {@template internal_server_error}
/// Represents an internal server error that occurs due to server-side issues.
///
/// This error typically corresponds to HTTP 500 (Internal Server Error)
/// responses and indicates that something went wrong on the server side.
/// {@endtemplate}
class InternalServerError extends AppError {
  /// {@macro internal_server_error}
  const InternalServerError({
    required super.title,
    required super.message,
    this.details,
  });

  /// Creates an [InternalServerError] from a [ServerError].
  factory InternalServerError.fromServerError(ServerError serverError) {
    return InternalServerError(
      title: serverError.title,
      message: serverError.message,
      details: serverError.details,
    );
  }

  /// Optional typed details specific to internal server errors.
  final List<dynamic>? details;

  /// Creates an [InternalServerError] from a [ServerError] with mapped details.
  static InternalServerError fromServerErrorWithMapper<T>(
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

    return InternalServerError(
      title: serverError.title,
      message: serverError.message,
      details: mappedDetails,
    );
  }
}
