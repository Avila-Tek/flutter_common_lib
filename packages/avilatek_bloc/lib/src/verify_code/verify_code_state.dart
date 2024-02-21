// ignore_for_file: public_member_api_docs, comment_references, unnecessary_getters_setters

import 'package:equatable/equatable.dart';

/// Extension for the [VerifyCodeState] class that provides utility methods to
/// check the type of the state.
extension VerifyCodeStateX on VerifyCodeState {
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
abstract class VerifyCodeState extends Equatable {
  const VerifyCodeState({this.code = '', this.sendTo = ''});

  /// The code that is being verified.
  final String code;

  /// The email or phone number where the code was sent.
  final String sendTo;

  /// Returns a new instance of the [VerifyCodeState] with the provided
  /// parameters.
  VerifyCodeState copyWith({String? code, String? sendTo});

  /// Returns a list of properties to be used in the comparison of two
  /// [VerifyCodeState] instances.
  @override
  List<Object> get props => [code];
}

/// State that represents the initial state of the [VerifyCodeBloc].
/// This state is emitted when the [VerifyCodeBloc] is created.
class VerifyCodeInitialized extends VerifyCodeState {
  const VerifyCodeInitialized({super.code, super.sendTo});

  @override
  VerifyCodeInitialized copyWith({String? code, String? sendTo}) {
    return VerifyCodeInitialized(
      code: code ?? this.code,
      sendTo: sendTo ?? this.sendTo,
    );
  }
}

/// State that represents the loading state of the [VerifyCodeBloc].
/// This state is emitted when the [VerifyCodeBloc] is verifying the code.

class VerifyCodeLoading extends VerifyCodeState {
  const VerifyCodeLoading({super.code, super.sendTo});

  @override
  VerifyCodeLoading copyWith({String? code, String? sendTo}) {
    return VerifyCodeLoading(
      code: code ?? this.code,
      sendTo: sendTo ?? this.sendTo,
    );
  }
}

/// State that represents an error in the [VerifyCodeBloc].
/// This state is emitted when the [VerifyCodeBloc] encounters an error.
class VerifyCodeError extends VerifyCodeState {
  const VerifyCodeError({
    required this.error,
    super.code,
    super.sendTo,
  });

  /// The error that caused the state.
  final dynamic error;

  @override
  VerifyCodeError copyWith({String? code, String? sendTo, dynamic error}) {
    return VerifyCodeError(
      code: code ?? this.code,
      sendTo: sendTo ?? this.sendTo,
      error: error ?? this.error,
    );
  }
}

/// State that represents a successful verification of the code in the
/// [VerifyCodeBloc].
/// This state is emitted when the [VerifyCodeBloc] successfully
/// verifies the code.
class VerifyCodeSuccess extends VerifyCodeState {
  const VerifyCodeSuccess({super.code, super.sendTo});

  @override
  VerifyCodeSuccess copyWith({String? code, String? sendTo}) {
    return VerifyCodeSuccess(
      code: code ?? this.code,
      sendTo: sendTo ?? this.sendTo,
    );
  }
}
