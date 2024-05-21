import 'package:flutter_test/flutter_test.dart';

/// A collection of helper functions to be used in tests.
class TestHelpers {
  /// Checks that the GraphQL service instance correctly checks
  /// for common errors in the apiUrl string.
  ///
  /// The [builder] function should return an instance of the GraphQL service
  /// with the apiUrl parameter.
  ///
  /// Usage:
  /// ```
  /// TestHelpers.checkGraphQLApiUrl(
  ///   (apiUrl) => UserApiGql(apiUrl: apiUrl),
  /// );
  /// ```
  static void checkGraphQLApiUrl<T>(
    T Function(String apiUrl) builder,
  ) {
    // Url does not define the protocol
    expect(
      () => builder('localhost:3000'),
      throwsAssertionError,
    );
    // Url ends with '/'
    expect(
      () => builder('http://localhost:3000/'),
      throwsAssertionError,
    );

    // Url ends with '/graphql'
    expect(
      () => builder('http://localhost:3000/graphql'),
      throwsAssertionError,
    );

    // Bad Url protocol format "http::/"
    expect(
      () => builder('http::/localhost:3000'),
      throwsAssertionError,
    );

    expect(
      builder('http://localhost:3000'),
      isA<T>(),
    );
  }

  /// Checks that the REST service instance correctly checks
  /// for common errors in the apiUrl string.
  ///
  /// The [builder] function should return an instance of the REST service
  /// with the apiUrl parameter.
  ///
  /// Usage:
  /// ```
  /// TestHelpers.checkRestApiUrl(
  ///  (apiUrl) => UserApiRest(apiUrl: apiUrl),
  /// );
  static void checkRestApiUrl<T>(
    T Function(String apiUrl) builder,
  ) {
    // Url does not define the protocol
    expect(
      () => builder('localhost:3000'),
      throwsAssertionError,
    );
    // Url ends with '/'
    expect(
      () => builder('http://localhost:3000/'),
      throwsAssertionError,
    );

    // Bad Url protocol format "http::/"
    expect(
      () => builder('http::/localhost:3000'),
      throwsAssertionError,
    );

    expect(
      builder('http://localhost:3000'),
      isA<T>(),
    );
  }
}
