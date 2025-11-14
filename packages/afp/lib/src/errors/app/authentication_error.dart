import 'package:afp/src/errors/errors.dart';

/// {@template authentication_error}
/// Represents an authentication error that occurs when user credentials are
/// invalid or authentication fails.
///
/// This error corresponds to HTTP 401 (Unauthorized) responses and
/// indicates that the user needs to provide valid credentials or
/// re-authenticate.
///
/// Can be created from ServerError via ErrorMapper transformation
/// {@endtemplate}
class AuthenticationError extends AppError {
  /// {@macro authentication_error}
  const AuthenticationError({
    required super.title,
    required super.message,
    this.details,
  });

  /// Creates an [AuthenticationError] from a [ServerError].
  ///
  /// Transforms server authentication error into application-level error.
  ///
  /// Example:
  /// ```dart
  /// final authError = AuthenticationError.fromServerError(serverError);
  /// ```
  factory AuthenticationError.fromServerError(ServerError serverError) {
    return AuthenticationError(
      title: serverError.title,
      message: serverError.message,
      details: serverError.details,
    );
  }

  /// Optional typed details specific to authentication errors.
  ///
  /// Contains structured information about the authentication failure.
  final List<dynamic>? details;

  /// Creates an [AuthenticationError] from a [ServerError] with mapped details.
  ///
  /// The [detailsMapper] function allows you to transform the raw server
  /// details into specific model objects. This is useful when authentication
  /// errors contain structured information about failed authentication
  /// attempts.
  ///
  /// Example:
  /// ```dart
  /// final error = AuthenticationError.fromServerErrorWithMapper(
  ///   serverError,
  ///   detailsMapper: (detailMap) => AuthDetail.fromMap(detailMap),
  /// );
  /// ```
  static AuthenticationError fromServerErrorWithMapper<T>(
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

    return AuthenticationError(
      title: serverError.title,
      message: serverError.message,
      details: mappedDetails,
    );
  }
}
