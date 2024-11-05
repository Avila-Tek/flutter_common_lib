import 'package:afp/src/interfaces/base_error.dart';

/// {@template result}
/// An abstract class representing the result of an operation.
///
/// This generic class takes two types: [T] for the success data type
/// and [E] for the error type in case of failure. The result can either
/// contain data or an error, but not both.
/// {@endtemplate}
abstract class Result<T, E extends BaseError> {
  /// {@macro result}
  Result({
    this.data,
    this.error,
  });

  /// The data returned in case of success.
  final T? data;

  /// The error returned in case of failure.
  final E? error;

  /// Resolves the result into a callback function with either a success or
  /// failure.
  ///
  /// Example usage:
  /// ```dart
  /// void main() {
  ///   final result = someFunction();
  ///
  ///   result.resolve(
  ///     (data) => print('Success: $data'), // Handle success response
  ///     (error) => print('Failure: $error'), // Handle failure response
  ///   );
  /// }
  ///
  /// Result<FooObject, SomeError> someFunction() {
  ///    try {
  ///      return Success(FooObject());
  ///    } catch (e) {
  ///      return Failure(SomeError());
  ///    }
  /// }
  /// ```
  ///
  void Function(
    void Function(Success<T, E> data),
    void Function(Failure<T, E> error),
  ) resolve() {
    return (
      void Function(Success<T, E> data) onSuccess,
      void Function(Failure<T, E> error) onFailure,
    ) {
      if (this is Success) {
        onSuccess(this as Success<T, E>);
      }
      if (this is Failure) {
        onFailure(this as Failure<T, E>);
      }
    };
  }
}

/// {@template success}
/// A class representing a successful result.
///
/// Contains the data returned by the operation.
/// {@endtemplate}
class Success<T, E extends BaseError> extends Result<T, E> {
  /// {@macro success}
  Success(T data) : super(data: data);
}

/// {@template failure}
/// A class representing a failed result.
///
/// Contains the error that occurred during the operation.
/// {@endtemplate}
class Failure<T, E extends BaseError> extends Result<T, E> {
  /// {@macro failure}
  Failure(E error) : super(error: error);
}
