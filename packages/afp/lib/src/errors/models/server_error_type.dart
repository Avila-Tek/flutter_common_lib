/// {@template base_error_type}
/// Represents the different types of server/API errors that can occur.
///
/// This enum provides a standardized way to categorize HTTP API response
/// errors, making it easier to handle different server error scenarios
/// appropriately and provide meaningful feedback to users based on the
/// server response.
/// {@endtemplate}
enum ServerErrorType {
  /// Returned when request data fails server-side validation
  validationError('VALIDATION_ERROR'),

  /// Returned when credentials are invalid or token has expired
  authenticationError('AUTHENTICATION_ERROR'),

  /// Returned when user lacks permission to access the requested resource
  authorizationError('AUTHORIZATION_ERROR'),

  /// Returned when the requested resource doesn't exist on the server
  notFoundError('NOT_FOUND_ERROR'),

  /// Returned when request conflicts with current server state
  conflictError('CONFLICT_ERROR'),

  /// Returned when API rate limits or usage quotas are exceeded
  rateLimitError('RATE_LIMIT_ERROR'),

  /// Returned when request is valid but violates business rules
  domainError('DOMAIN_ERROR'),

  /// Returned when server encounters unexpected errors
  internalServerError('INTERNAL_SERVER_ERROR'),

  /// Returned when server fails due to external dependency issues
  externalServiceError('EXTERNAL_SERVICE_ERROR');

  /// {@macro base_error_type}
  const ServerErrorType(this.name);

  /// Creates a [ServerErrorType] from a string value.
  ///
  /// If the provided [value] doesn't match any known error type,
  /// defaults to [ServerErrorType.internalServerError].
  ///
  /// Example:
  /// ```dart
  /// final errorType = BaseErrorType.fromValue('VALIDATION_ERROR');
  /// // Returns BaseErrorType.validationError
  ///
  /// final unknownType = BaseErrorType.fromValue('UNKNOWN_ERROR');
  /// // Returns BaseErrorType.internalServerError
  /// ```
  factory ServerErrorType.fromValue(String value) {
    return ServerErrorType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ServerErrorType.internalServerError,
    );
  }

  /// The string representation of the error type
  final String name;
}
