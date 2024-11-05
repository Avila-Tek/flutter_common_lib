import 'package:afp/src/base_error.dart';

/// An abstract class representing the result of an operation.
///
/// This generic class takes two types: [T] for the success data type
/// and [E] for the error type in case of failure. The result can either
/// contain data or an error, but not both.
abstract class Result<T, E extends BaseError> {

  Result({
    this.data,
    this.error,
  });

  /// The data returned in case of success.
  final T? data;

  /// The error returned in case of failure.
  final E? error;
}

/// A class representing a successful result.
///
/// Contains the data returned by the operation.
class Success<T, E extends BaseError> extends Result<T, E> {
  Success(T data) : super(data: data);
}

/// A class representing a failed result.
///
/// Contains the error that occurred during the operation.
class Failure<T, E extends BaseError> extends Result<T, E> {
  Failure(E error) : super(error: error);
}
