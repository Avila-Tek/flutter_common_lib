// ignore_for_file: lines_longer_than_80_chars

import 'package:afp/afp.dart';

/// Convenience extensions for ErrorMapperConfig to reduce boilerplate setup.
///
/// These extensions provide pre-configured mapping setups for common scenarios,
/// eliminating the need to manually configure every standard error type
/// mapping.
extension ErrorMapperConfigExtensions on ErrorMapperConfig {
  /// Configures standard type-based mappings for all built-in error types.
  ///
  /// This method sets up the default mapping from ServerErrorType enum values
  /// to their corresponding AppError subclasses. It's a convenience method that
  /// eliminates the need to manually configure each standard error type
  /// mapping.
  ///
  /// **Configured mappings:**
  /// - `ServerErrorType.validationError` → `ValidationError`
  /// - `ServerErrorType.authenticationError` → `AuthenticationError`
  /// - `ServerErrorType.authorizationError` → `AuthorizationError`
  /// - `ServerErrorType.notFoundError` → `NotFoundError`
  /// - `ServerErrorType.conflictError` → `ConflictError`
  /// - `ServerErrorType.rateLimitError` → `RateLimitError`
  /// - `ServerErrorType.domainError` → `DomainError`
  /// - `ServerErrorType.internalServerError` → `InternalServerError`
  /// - `ServerErrorType.externalServiceError` → `ExternalServiceError`
  ///
  /// **Usage:**
  /// ```dart
  /// final mapper = ErrorMapper.configure((config) {
  ///   // Set up all standard type mappings
  ///   config.withStandardTypes();
  ///
  ///   // Add custom code handlers for specific cases
  ///   config.codeHandlers = {
  ///     'CUSTOM_BUSINESS_ERROR': (serverError) => DomainError.fromServerError(serverError),
  ///   };
  /// });
  /// ```
  ///
  /// **Note:** This method replaces any existing type handlers. If you need
  /// to customize specific mappings, call this method first, then override
  /// individual handlers as needed.
  void withStandardTypes() {
    typeHandlers = {
      ServerErrorType.validationError: ValidationError.fromServerError,
      ServerErrorType.authenticationError: AuthenticationError.fromServerError,
      ServerErrorType.authorizationError: AuthorizationError.fromServerError,
      ServerErrorType.notFoundError: NotFoundError.fromServerError,
      ServerErrorType.conflictError: ConflictError.fromServerError,
      ServerErrorType.rateLimitError: RateLimitError.fromServerError,
      ServerErrorType.domainError: DomainError.fromServerError,
      ServerErrorType.internalServerError: InternalServerError.fromServerError,
      ServerErrorType.externalServiceError:
          ExternalServiceError.fromServerError,
    };
  }
}
