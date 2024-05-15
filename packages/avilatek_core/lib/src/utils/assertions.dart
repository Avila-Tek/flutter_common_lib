/// Packs handy assertions.
class CommonAssertions {
  /// Run a series of assertions to check if the API URL is valid.
  ///
  /// Should be used when instancing a new GraphQL API object.
  static void assertApiGql(String apiUrl) {
    assert(
      apiUrl.startsWith(RegExp('^https?://')),
      'apiUrl format error: URL must start with "http://" or "https://" protocol',
    );
    assert(
      !apiUrl.endsWith('/') || !apiUrl.endsWith('graphql'),
      'apiUrl format error: URL cannot end with "/" nor "/graphql"',
    );
  }
}
