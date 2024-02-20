// ignore_for_file: public_member_api_docs, comment_references

import 'package:equatable/equatable.dart';

/// Extension for the [VerifyCodeState] class that provides utility methods to
/// check the type of the state.
extension VerifyCodeStateX on VerifyCodeState<dynamic> {
  /// Returns `true` if the state is initialized.
  bool get isInitialized => this is VerifyCodeInitialized;

  /// Returns `true` if the state is [VerifyCodeLoading].
  bool get isLoading => this is VerifyCodeLoading;

  /// Returns `true` if the state is [VerifyCodeError].
  bool get isError => this is VerifyCodeError;

  /// Returns `true` if the state is [VerifyCodeSuccess].
  bool get isSuccess => this is VerifyCodeSuccess;
}

/// Base class for states of the [VerifyCodeBloc].
///
/// This class is used to provide a common interface for all the states of the
/// [VerifyCodeBloc].
abstract class VerifyCodeState<T> extends Equatable {
  const VerifyCodeState();

  @override
  List<Object?> get props => [];
}

/// State that represents the initial state of the [VerifyCodeBloc].
/// This state is emitted when the [VerifyCodeBloc] is created.
class VerifyCodeInitialized<T> extends VerifyCodeState<T> {
  const VerifyCodeInitialized();
}

/// State that represents the loading state of the [VerifyCodeBloc].
/// This state is emitted when the [VerifyCodeBloc] is verifying the code.
class VerifyCodeLoading<T> extends VerifyCodeState<T> {}

/// State that represents an error in the [VerifyCodeBloc].
/// This state is emitted when the [VerifyCodeBloc] encounters an error.
class VerifyCodeError<T> extends VerifyCodeState<T> {
  const VerifyCodeError(this.error);

  final dynamic error;

  @override
  List<Object?> get props => [...super.props, error];
}

/// State that represents a successful verification of the code in the
/// [VerifyCodeBloc].
/// This state is emitted when the [VerifyCodeBloc] successfully
/// verifies the code.
class VerifyCodeSuccess<T> extends VerifyCodeState<T> {
  const VerifyCodeSuccess();
}
