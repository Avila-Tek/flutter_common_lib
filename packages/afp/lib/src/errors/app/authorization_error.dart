import 'package:afp/src/errors/errors.dart';

/// {@template authorization_error}
/// Represents an authorization error that occurs when a user lacks permission
/// to access a resource or perform an action.
///
/// This error corresponds to HTTP 403 (Forbidden) responses and
/// indicates that while the user is authenticated, they don't have the
/// necessary permissions for the requested operation.
///
/// Can be created from ServerError via ErrorMapper transformation
/// {@endtemplate}
class AuthorizationError extends AppError {
  /// {@macro authorization_error}
  const AuthorizationError({
    required super.title,
    required super.message,
    this.details,
  });

  /// Creates an [AuthorizationError] from a [ServerError].
  factory AuthorizationError.fromServerError(ServerError serverError) {
    return AuthorizationError(
      title: serverError.title,
      message: serverError.message,
      details: serverError.details,
    );
  }

  /// Optional typed details specific to authorization errors.
  ///
  /// Contains structured information about the authorization failure,
  /// such as required permissions, resource access rules, or user roles.
  final List<dynamic>? details;

  /// Creates an [AuthorizationError] from a [ServerError] with mapped details.
  static AuthorizationError fromServerErrorWithMapper<T>(
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

    return AuthorizationError(
      title: serverError.title,
      message: serverError.message,
      details: mappedDetails,
    );
  }
}
