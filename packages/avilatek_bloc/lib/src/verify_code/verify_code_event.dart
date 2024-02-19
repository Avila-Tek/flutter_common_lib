import 'package:equatable/equatable.dart';

/// Abstract class that represents the events that can be dispatched
/// to the [VerifyCodeBloc<T>].
abstract class VerifyCodeEvent extends Equatable {
  /// Creates a new instance of the [VerifyCodeEvent].
  const VerifyCodeEvent();

  @override
  List<Object?> get props => [];
}

/// Event that triggers the verification of the code.
/// This event is dispatched when the user presses the verify button.
class VerifyCodePressedEvent<T> extends VerifyCodeEvent {
  /// Creates a new instance of the [VerifyCodePressedEvent].
  const VerifyCodePressedEvent(this.code, {this.simulateError = false});

  /// The code that will be verified.
  final String code;

  /// If true, the [VerifyCodeBloc<T>] will simulate an error.
  final bool? simulateError;

  @override
  List<Object?> get props => [code];
}
