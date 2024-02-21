// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, unnecessary_getters_setters, comment_references

import 'package:equatable/equatable.dart';

extension SendCodeStateX on SendCodeState {
  /// Returns `true` if the state is initialized and has data.
  bool get isInitialized => this is SendCodeInitialized;

  /// Returns `true` if the state is [SendCodeLoading].
  bool get isLoading => this is SendCodeLoading;

  /// Returns `true` if the state is [SendCodeError].
  bool get isError => this is SendCodeError;

  /// Returns `true` if the state is [SendCodeSuccess].
  bool get isSuccess => this is SendCodeSuccess;

  /// Returns `true` if the state is [SendCodeOnHoldTime].
  bool get isOnHoldTime => this is SendCodeOnHoldTime;
}

/// Base class for states of the [SendCodeBloc].
///
/// This class is used to provide a common interface for all the states of the
/// [SendCodeBloc].
abstract class SendCodeState extends Equatable {
  const SendCodeState();

  /// The email or phone number where the user
  /// wants to receive the code.
  static String _input = '';

  /// `input` getter.
  String get input => _input;

  /// `input` setter.
  set input(String newInput) {
    _input = newInput;
  }

  /// Returns a new instance of the [SendCodeState] with the provided
  /// parameters.
  @override
  List<Object?> get props => [input];
}

/// State that represents the initial state of the [SendCodeBloc].
///
/// This state is emitted when the [SendCodeBloc] is created.
/// And when the [SendCodeBloc] is initialized after a successful code
/// sending process.
class SendCodeInitialized extends SendCodeState {
  const SendCodeInitialized();
}

/// State that represents the loading state of the [SendCodeBloc].
///
/// This state is emitted when the [SendCodeBloc] is sending the code.
class SendCodeLoading extends SendCodeState {
  const SendCodeLoading();
}

/// State that represents the error state of the [SendCodeBloc].
///
/// This state is emitted when the [SendCodeBloc] encounters an error.
///
/// The error can be of any type.
class SendCodeError extends SendCodeState {
  const SendCodeError(this.error);

  /// The error that caused the state to be emitted.
  final dynamic error;

  @override
  List<Object?> get props => [...super.props, error];
}

/// State that represents the success state of the [SendCodeBloc].
///
/// This state is emitted when the [SendCodeBloc] successfully sends the code.
class SendCodeSuccess extends SendCodeState {
  const SendCodeSuccess();
}

/// State that represents the on hold time state of the [SendCodeBloc].
///
/// This state is emitted when the [SendCodeBloc] is on hold.
///
/// The duration in seconds that the [SendCodeBloc] will wait before
/// sending the code again is provided.
class SendCodeOnHoldTime extends SendCodeState {
  const SendCodeOnHoldTime(
    this.durationInSeconds,
  );

  /// The duration in seconds that the [SendCodeBloc] will wait before
  /// sending the code again.
  final int durationInSeconds;

  @override
  List<Object?> get props => [durationInSeconds];
}
