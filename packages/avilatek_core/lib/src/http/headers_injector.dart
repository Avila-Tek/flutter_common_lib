/// {@template http_headers_injector}
/// Interface for injecting headers into HTTP requests.
/// {@endtemplate}
abstract class HeadersInjector {
  /// {@macro http_headers_injector}
  const HeadersInjector();

  /// Retrieves all header values.
  Future<Map<String, String>> getAll();

  /// Retrieves the header value.
  ///
  /// Example:
  /// ```dart
  /// final headers = HttpHeadersInjectorImpl(); // Example implementation
  /// final token = await headers.get(HttpHeaders.authorizationHeader);
  /// ```
  Future<String?> get(String key);

  /// Stores the header-value pair.
  ///
  /// Example:
  /// ```dart
  /// final headers = HttpHeadersInjectorImpl(); // Example implementation
  /// await headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');
  Future<void> set(String key, String value);

  /// Deletes the header value. Does nothing if the header is not found.
  ///
  /// Example:
  /// ```dart
  /// final headers = HttpHeadersInjectorImpl(); // Example implementation
  /// await headers.delete(HttpHeaders.authorizationHeader);
  /// ```
  Future<void> delete(String key);

  /// Builds the headers using the stored values and the extra headers. The
  /// `extra` headers have priority over the stored values but will not change
  /// them.
  Future<Map<String, String>> headers({Map<String, String>? extra});
}
