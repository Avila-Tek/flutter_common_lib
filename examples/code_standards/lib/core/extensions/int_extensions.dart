extension IntHttp on int {
  /// Checks if the status code is a success code.
  ///
  /// A success code is a code between 200 and 299.
  bool get isSuccessful => this >= 200 && this < 300;
}
