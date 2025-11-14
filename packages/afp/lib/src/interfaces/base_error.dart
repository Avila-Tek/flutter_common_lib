/// {@template base_error}
/// Minimal base interface for all error types in the application.
///
/// This abstract class provides the essential structure that all error objects
/// must implement, serving as the foundation for different error sources:
///
/// - **Server Errors**: API/server responses with detailed server data
/// - **Application Errors**: Business logic errors with app-specific handling
/// - **Package Errors**: Errors thrown by external packages/libraries
/// - **Validation Errors**: Local input validation failures
/// - **System Errors**: Platform or system-level errors
///
/// The minimal interface ensures that all errors can be handled uniformly
/// while allowing specific error types to add their own properties and
/// behavior.
///
/// ## Error Hierarchy
///
/// ```
/// BaseError (interface)
/// ├── ServerError (server-specific data: type, code, status, details)
/// └── AppError (application-level classification)
///     ├── ValidationError (from server OR local validation)
///     ├── AuthenticationError (from server OR package)
///     ├── DomainError (business logic errors)
///     └── ... (other app-specific errors)
/// ```
/// {@endtemplate}
abstract class BaseError implements Exception {
  /// Creates a base error.
  ///
  /// All error types must extend this interface to ensure consistent
  /// error handling throughout the application.
  const BaseError();
}
