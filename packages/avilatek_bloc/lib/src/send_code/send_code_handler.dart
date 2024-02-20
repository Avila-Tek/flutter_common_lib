// ignore_for_file: comment_references

import 'package:avilatek_bloc/src/send_code/send_code_event.dart';
import 'package:avilatek_bloc/src/send_code/send_code_state.dart';
import 'package:bloc/bloc.dart';

/// Handler for [SendCodeBloc].
///
/// This class is used to handle the events dispatched by the [SendCodeBloc].
class SendCodeEventHandler<T> {
  /// Creates a new instance of [SendCodeEventHandler].
  const SendCodeEventHandler();

  /// Propagates the [SendCodePressedEvent] event down to the
  /// corresponding event handler.
  ///
  /// This function is used to handle the states of the bloc
  /// when an event is dispatched.
  Future<void> mapSendCodePressedToState(
    SendCodePressedEvent<T> event,
    SendCodeState<T> state,
    Emitter<SendCodeState<T>> emit,
    Future<bool> Function(
      SendCodeState<T>,
      SendCodePressedEvent<T>,
    ) sendCodePressed,
  ) async {
    try {
      if (event.simulateError ?? false) {
        await _simulateError();
      }

      // If the last sent code was sent less than the time interval, do nothing.
      final timeDifference = DateTime.now().difference(state.lastSentAt);
      if (timeDifference.inSeconds < event.timeInterval.inSeconds) {
        return;
      }

      emit(const SendCodeInitialized());

      final isCodeSended = await sendCodePressed(state, event);

      if (isCodeSended) {
        emit(SendCodeSuccess(DateTime.now()));
        emit(SendCodeOnHoldTime(event.timeInterval));
      }
    } catch (e) {
      emit(SendCodeError(e));
      emit(const SendCodeInitialized());
    }
  }

  /// Simulates an error.
  Future<void> _simulateError() {
    Future<void>.delayed(const Duration(seconds: 1));
    throw Exception('Simulated error');
  }
}
