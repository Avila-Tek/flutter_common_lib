// ignore_for_file: comment_references

import 'dart:async';

import 'package:avilatek_bloc/src/send_code/send_code_event.dart';
import 'package:avilatek_bloc/src/send_code/send_code_state.dart';
import 'package:bloc/bloc.dart';

/// Handler for [SendCodeBloc].
///
/// This class is used to handle the events dispatched by the [SendCodeBloc].
class SendCodeEventHandler {
  /// Creates a new instance of [SendCodeEventHandler].
  const SendCodeEventHandler();

  /// Propagates the [SendCodePressedEvent] event down to the
  /// corresponding event handler.
  ///
  /// This function is used to handle the states of the bloc
  /// when an event is dispatched.
  Future<void> mapSendCodePressedToState(
    SendCodePressedEvent event,
    SendCodeState state,
    Emitter<SendCodeState> emit,
    Future<bool> Function(
      SendCodeState,
      SendCodePressedEvent,
    ) sendCodePressed,
  ) async {
    try {
      if (event.simulateError ?? false) {
        await _simulateError();
      }

      final isCodeSended = await sendCodePressed(state, event);

      if (isCodeSended) {
        emit(const SendCodeSuccess());
        emit(SendCodeOnHoldTime(event.timeInterval.inSeconds));
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
