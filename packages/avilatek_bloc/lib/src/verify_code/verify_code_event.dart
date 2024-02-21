// ignore_for_file: comment_references

import 'package:equatable/equatable.dart';

/// Abstract class that represents the events that can be dispatched
/// to the [VerifyCodeBloc].
abstract class VerifyCodeEvent extends Equatable {
  /// Creates a new instance of the [VerifyCodeEvent].
  const VerifyCodeEvent();

  @override
  List<Object?> get props => [];
}

/// Event that triggers the verification of the code.
/// This event is dispatched when the user presses the verify button.
class VerifyCodePressedEvent extends VerifyCodeEvent {
  /// Creates a new instance of the [VerifyCodePressedEvent].
  const VerifyCodePressedEvent({this.simulateError = false});

  /// If true, the [VerifyCodeBloc] will simulate an error.
  final bool? simulateError;

  @override
  List<Object?> get props => [];
}

/// Event that triggers the change of the code input.
/// This event is dispatched when the user changes the code input.
class VerifyCodeInputChangedEvent extends VerifyCodeEvent {
  /// Creates a new instance of the [VerifyCodeInputChangedEvent].
  const VerifyCodeInputChangedEvent(this.code);

  /// The new code input.
  final String code;

  @override
  List<Object?> get props => [code];
}

/// Event that triggers the start of the verification code process.
/// This event is dispatched when the bloc is initialized.
class VerifyCodeStartedEvent extends VerifyCodeEvent {
  /// Creates a new instance of the [VerifyCodeStartedEvent].
  const VerifyCodeStartedEvent(this.sendTo);

  /// The email or phone number where the code was sent.
  final String sendTo;

  @override
  List<Object?> get props => [sendTo];
}
