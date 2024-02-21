// ignore_for_file: comment_references

import 'package:equatable/equatable.dart';

/// Abstract class that represents the events that can be dispatched
/// to the [SendCodeBloc].
abstract class SendCodeEvent extends Equatable {
  /// Creates a new instance of the [SendCodeEvent].
  const SendCodeEvent();

  @override
  List<Object?> get props => [];
}

/// Event that triggers the sending of the code.
///
/// This event is dispatched when the user presses the send code button.
class SendCodePressedEvent extends SendCodeEvent {
  /// SendCodePressed Constructor
  const SendCodePressedEvent({
    this.simulateError = false,
    this.timeInterval = const Duration(seconds: 60),
  });

  /// If true, the [SendCodeBloc] will simulate an error.
  final bool? simulateError;

  /// The time interval that the [SendCodeBloc] will wait before
  /// sending the code again.
  final Duration timeInterval;

  @override
  List<Object?> get props => [simulateError, timeInterval];
}

/// Event that triggers the resending of the code.
///
/// This event is dispatched when the user presses the resend code button.
class ResendCodePressedEvent extends SendCodeEvent {
  /// ResendCodePressedEvent Constructor
  const ResendCodePressedEvent({
    required this.input,
    this.simulateError = false,
    this.timeInterval = const Duration(seconds: 60),
  });

  /// If true, the [SendCodeBloc] will simulate an error.
  final bool? simulateError;

  /// The time interval that the [SendCodeBloc] will wait before
  final Duration timeInterval;

  /// The input with the user's email or phone number where
  /// the code will be sent.
  final String input;

  @override
  List<Object?> get props => [input, simulateError, timeInterval];
}

/// Event that triggers the tick timer of the [SendCodeBloc].
class SendCodeTickTimerEvent extends SendCodeEvent {
  /// SendCodeTickTimerEvent Constructor
  const SendCodeTickTimerEvent(this.durationInSeconds);

  /// The duration in seconds that the [SendCodeBloc] will wait before
  final int durationInSeconds;

  @override
  List<Object?> get props => [durationInSeconds];
}

/// Event that triggers the change of the input.
/// This event is dispatched when the user changes the input
/// with the email or phone number where the code will be sent.
class SendCodeInputChangedEvent extends SendCodeEvent {
  /// SendCodeInputChangedEvent Constructor
  const SendCodeInputChangedEvent(this.input);

  /// The input with the user's email or phone number where
  /// the code will be sent.
  final String input;

  @override
  List<Object?> get props => [input];
}
