// ignore_for_file: lines_longer_than_80_chars

import 'package:afp/src/errors/errors.dart';

/// {@template error_mapper_config}
/// Configuration class for mapping server errors to application errors.
///
/// This class provides a declarative API for configuring how ServerErrors
/// are transformed into AppErrors. It supports three levels of mapping:
///
/// 1. **Code-specific handlers**: Exact string code matches (highest priority)
/// 2. **Type-based handlers**: ServerErrorType enum fallbacks (medium priority)
/// 3. **Default handler**: Universal fallback for unmatched errors (lowest priority)
///
/// The configuration uses a setter-based approach for clean, readable setup
/// without requiring complex builder patterns or method chaining.
/// {@endtemplate}
class ErrorMapperConfig {
  final Map<String, AppError Function(ServerError)> _codeHandlers = {};
  final Map<ServerErrorType, AppError Function(ServerError)> _typeHandlers = {};
  AppError Function(ServerError)? _defaultHandler;

  /// Sets error handlers for specific server error codes.
  ///
  /// Code handlers have the highest priority and are checked first during
  /// error mapping. They allow for precise handling of specific server error
  /// codes that require custom transformation logic or specialized error types.
  ///
  /// **Key behaviors:**
  /// - Codes are automatically converted to uppercase for consistency
  /// - Exact string matching is used for lookups
  /// - Takes precedence over type-based and default handlers
  ///
  /// **Use cases:**
  /// - Mapping specific validation errors with detailed field information
  /// - Handling unique business logic errors that don't fit standard types
  /// - Creating specialized error objects with custom properties
  ///
  /// Example:
  /// ```dart
  /// config.codeHandlers = {
  ///   'USER_NOT_FOUND': (serverError) => UserNotFoundError.fromServerError(serverError),
  ///   'EMAIL_ALREADY_EXISTS': (serverError) => ConflictError.fromServerError(serverError),
  ///   'INVALID_FIELD_FORMAT': (serverError) => InvalidFieldFormatError.fromServerErrorWithMapper<FieldError>(
  ///     serverError,
  ///     detailsMapper: (map) => FieldError.fromMap(map),
  ///   ),
  /// };
  /// ```
  set codeHandlers(Map<String, AppError Function(ServerError)> handlers) {
    _codeHandlers.clear();
    for (final entry in handlers.entries) {
      _codeHandlers[entry.key.toUpperCase()] = entry.value;
    }
  }

  /// Gets the current code handlers configuration.
  ///
  /// Returns an unmodifiable map of all configured code-specific handlers.
  /// Useful for debugging, testing, or building diagnostic tools that need
  /// to inspect the current error mapping configuration.
  Map<String, AppError Function(ServerError)> get codeHandlers =>
      Map.unmodifiable(_codeHandlers);

  /// Sets error handlers for specific server error types.
  ///
  /// Type handlers provide fallback mapping when no specific code handler
  /// is found. They map ServerErrorType enum values to corresponding AppError
  /// subclasses, enabling consistent error handling across different server
  /// implementations that may use different codes but the same error types.
  ///
  /// **Key behaviors:**
  /// - Used when no matching code handler is found
  /// - Maps ServerErrorType enum values to AppError constructors
  /// - Provides standardized error handling across different server APIs
  /// - Can be overridden by more specific code handlers
  ///
  /// **Use cases:**
  /// - Establishing baseline error type mappings
  /// - Handling server responses with consistent type classifications
  /// - Providing fallback behavior for unrecognized error codes
  /// - Maintaining compatibility across different API versions
  ///
  /// Example:
  /// ```dart
  /// config.typeHandlers = {
  ///   ServerErrorType.validationError: (serverError) => ValidationError.fromServerError(serverError),
  ///   ServerErrorType.authenticationError: (serverError) => AuthenticationError.fromServerError(serverError),
  ///   ServerErrorType.authorizationError: (serverError) => AuthorizationError.fromServerError(serverError),
  ///   ServerErrorType.notFoundError: (serverError) => NotFoundError.fromServerError(serverError),
  /// };
  /// ```
  set typeHandlers(
    Map<ServerErrorType, AppError Function(ServerError)> handlers,
  ) {
    _typeHandlers
      ..clear()
      ..addAll(handlers);
  }

  /// Gets the current type handlers configuration.
  ///
  /// Returns an unmodifiable map of all configured type-based handlers.
  /// Useful for debugging, testing, or building tools that need to inspect
  /// the current error type mapping configuration.
  Map<ServerErrorType, AppError Function(ServerError)> get typeHandlers =>
      Map.unmodifiable(_typeHandlers);

  /// Sets the default handler for unmatched server errors.
  ///
  /// The default handler is the final fallback when no code-specific or
  /// type-specific handlers match the incoming ServerError. It ensures that
  /// all server errors can be transformed into AppErrors, even when they
  /// represent unknown or unexpected error conditions.
  ///
  /// **Key behaviors:**
  /// - Only invoked when no code or type handlers match
  /// - Must handle any possible ServerError input
  /// - Should provide meaningful error information to users
  /// - Typically creates a generic AppError with server details
  ///
  /// **Use cases:**
  /// - Handling new error types not yet configured in the mapper
  /// - Providing fallback behavior for API changes or unknown errors
  /// - Ensuring robust error handling that never throws exceptions
  /// - Creating logging or monitoring for unmapped error conditions
  ///
  /// Example:
  /// ```dart
  /// config.defaultHandler = (serverError) => AppError(
  ///   message: serverError.message.isNotEmpty
  ///     ? serverError.message
  ///     : 'An unexpected server error occurred',
  /// );
  /// ```
  set defaultHandler(AppError Function(ServerError) handler) {
    _defaultHandler = handler;
  }

  /// Gets the current default handler function.
  ///
  /// Returns the configured default handler, or a built-in fallback that
  /// creates a simple AppError with the server's message. The built-in
  /// fallback ensures that ErrorMapper always has a valid default handler
  /// even when none is explicitly configured.
  AppError Function(ServerError) get defaultHandler =>
      _defaultHandler ??
      (serverError) => AppError(
            title: serverError.title,
            message: serverError.message,
          );

  /// Maps a server error to an appropriate application error.
  ///
  /// This method implements the core error mapping logic using a priority-based
  /// approach to determine the most appropriate AppError for the given ServerError.
  ///
  /// **Mapping priority (highest to lowest):**
  /// 1. **Code-specific handler**: Exact match on `serverError.code`
  /// 2. **Type-based handler**: Match on `serverError.type` enum value
  /// 3. **Default handler**: Universal fallback for any unmatched error
  ///
  /// **Parameters:**
  /// - `code`: The server error code (automatically converted to uppercase)
  /// - `serverError`: Complete server error with all details and context
  ///
  /// **Returns:**
  /// An AppError instance that represents the server error in application context.
  /// The exact AppError subclass depends on the configured handlers and mapping logic.
  ///
  /// **Example usage:**
  /// ```dart
  /// final appError = config.mapError('USER_NOT_FOUND', serverError);
  /// // Returns: NotFoundError if code handler configured
  /// // Fallback: Uses type handler for ServerErrorType.notFoundError
  /// // Final fallback: Uses default handler creating generic AppError
  /// ```
  AppError mapError(String code, ServerError serverError) {
    // Try code-specific handler first
    final codeHandler = _codeHandlers[code.toUpperCase()];
    if (codeHandler != null) {
      return codeHandler(serverError);
    }

    // Try type-specific handler
    final typeHandler = _typeHandlers[serverError.type];
    if (typeHandler != null) {
      return typeHandler(serverError);
    }

    // Use default handler
    return defaultHandler(serverError);
  }
}

/// {@template error_mapper}
/// A centralized error mapper that transforms ServerErrors into AppErrors
/// using a configuration-driven approach.
///
/// ErrorMapper provides a declarative way to handle server error responses
/// by configuring specific mappings for error codes, error types, and fallback
/// scenarios. This eliminates the need for repetitive switch statements and
/// provides a consistent, maintainable approach to error transformation.
///
/// **Key Features:**
/// - **Code-specific mapping**: Handle exact error codes with custom logic
/// - **Type-based fallbacks**: Map error types to standard AppError subclasses
/// - **Default handling**: Ensure all errors are transformed, even unknown ones
/// - **Flexible configuration**: Use standard Dart syntax for clean setup
/// - **Type safety**: Compile-time checking for handler function signatures
///
/// **Architecture:**
/// ```
/// ServerError → ErrorMapper → AppError
///     ↓            ↓           ↓
/// API Response → Configured → Application
///                Handlers     Context
/// ```
///
/// **Use Cases:**
/// - Transform HTTP API error responses into domain-specific error types
/// - Provide consistent error handling across different server implementations
/// - Enable type-safe error handling with specific AppError subclasses
/// - Reduce boilerplate error mapping code throughout the application
/// {@endtemplate}
class ErrorMapper {
  /// Creates an ErrorMapper with declarative configuration.
  ///
  /// This factory constructor uses a configuration function to set up
  /// error mapping handlers in a clean, readable way. The configurator
  /// function receives an ErrorMapperConfig instance that can be used
  /// to define code handlers, type handlers, and default behavior.
  ///
  /// **Configuration approach:**
  /// The configurator function is called once during ErrorMapper creation,
  /// allowing you to set up all mapping logic in a single, cohesive block.
  /// This approach provides better readability and maintainability compared
  /// to imperative configuration methods.
  ///
  /// **Example - Basic configuration:**
  /// ```dart
  /// final mapper = ErrorMapper.configure((config) {
  ///   // Handle specific error codes
  ///   config.codeHandlers = {
  ///     'USER_NOT_FOUND': (serverError) => NotFoundError.fromServerError(serverError),
  ///     'INVALID_EMAIL': (serverError) => ValidationError.fromServerError(serverError),
  ///   };
  ///
  ///   // Handle error types for fallback
  ///   config.typeHandlers = {
  ///     ServerErrorType.authenticationError: (serverError) => AuthenticationError.fromServerError(serverError),
  ///     ServerErrorType.authorizationError: (serverError) => AuthorizationError.fromServerError(serverError),
  ///   };
  ///
  ///   // Define default behavior
  ///   config.defaultHandler = (serverError) => AppError(message: serverError.message);
  /// });
  /// ```
  ///
  /// **Example - Advanced with custom mapping:**
  /// ```dart
  /// final mapper = ErrorMapper.configure((config) {
  ///   config.codeHandlers = {
  ///     'VALIDATION_FAILED': (serverError) => ValidationError.fromServerErrorWithMapper<FieldError>(
  ///       serverError,
  ///       detailsMapper: (map) => FieldError.fromMap(map),
  ///     ),
  ///   };
  /// });
  /// ```
  factory ErrorMapper.configure(
    void Function(ErrorMapperConfig) configurator,
  ) {
    final config = ErrorMapperConfig();
    configurator(config);
    return ErrorMapper._(config);
  }

  const ErrorMapper._(this._config);

  final ErrorMapperConfig _config;

  /// Transforms a ServerError into an AppError using configured mappings.
  ///
  /// This is the main entry point for error transformation. It takes a
  /// ServerError (typically from an API response) and applies the configured
  /// mapping logic to produce an appropriate AppError for application use.
  ///
  /// **Transformation process:**
  /// 1. Extract the error code from the ServerError
  /// 2. Apply the priority-based mapping logic via `mapError()`
  /// 3. Return the resulting AppError instance
  ///
  /// **Parameters:**
  /// - `serverError`: The server error to transform, containing all server
  ///   response details including code, type, message, status, and optional details
  ///
  /// **Returns:**
  /// An AppError instance appropriate for the application context. The exact
  /// subclass depends on the configured handlers and the server error details.
  ///
  /// **Example usage:**
  /// ```dart
  /// // API response produces ServerError
  /// final serverError = ServerError(
  ///   type: ServerErrorType.validationError,
  ///   code: 'INVALID_EMAIL',
  ///   title: 'Validation Failed',
  ///   message: 'Email format is invalid',
  ///   status: 400,
  /// );
  ///
  /// // Transform to AppError
  /// final appError = mapper.fromServerError(serverError);
  /// // Result: ValidationError instance with server details
  /// ```
  AppError fromServerError(ServerError serverError) {
    return _config.mapError(serverError.code, serverError);
  }
}
