import 'package:equatable/equatable.dart';

/// Abstract class that represents the events that can be dispatched
/// to the [SendCodeBloc<T>].
abstract class SendCodeEvent extends Equatable {
  /// Creates a new instance of the [SendCodeEvent].
  const SendCodeEvent();

  @override
  List<Object?> get props => [];
}

/// Event that triggers the sending of the code.
///
/// This event is dispatched when the user presses the send code button.
class SendCodePressedEvent<T> extends SendCodeEvent {
  /// SendCodePressed Constructor
  const SendCodePressedEvent({
    this.simulateError = false,
    this.timeInterval = const Duration(seconds: 60),
  });

  /// If true, the [SendCodeBloc<T>] will simulate an error.
  final bool? simulateError;

  /// The time interval that the [SendCodeBloc<T>] will wait before
  /// sending the code again.
  final Duration timeInterval;

  @override
  List<Object?> get props => [simulateError, timeInterval];
}
