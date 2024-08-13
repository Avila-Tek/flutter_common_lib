/// Packs handy assertions.
class CommonAssertions {
  /// Run a series of assertions to check if the API URL is valid.
  ///
  /// Should be used when instancing a new GraphQL API object.
  static void assertGraphQLApi(String apiUrl) {
    assertUrlIsHttpOrHttps(apiUrl);
    assert(
      !apiUrl.endsWith('/') || !apiUrl.endsWith('graphql'),
      'apiUrl format error: URL cannot end with "/" nor "/graphql"',
    );
  }

  /// Checks whether the apiUrl follows http or https protocol.
  static void assertUrlIsHttpOrHttps(String apiUrl) {
    assert(
      apiUrl.startsWith(RegExp('^https?://')),
      'apiUrl format error: URL must start with "http://" or "https://" protocol',
    );
    assert(
      !apiUrl.endsWith('/'),
      'apiUrl format error: URL cannot end with slash "/"',
    );
  }
}
