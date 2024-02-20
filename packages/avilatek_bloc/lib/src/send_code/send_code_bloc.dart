// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:avilatek_bloc/src/send_code/send_code_event.dart';
import 'package:avilatek_bloc/src/send_code/send_code_state.dart';
import 'package:avilatek_bloc/src/verify_code/verify_code_event.dart';
import 'package:avilatek_bloc/src/verify_code/verify_code_handler.dart';
import 'package:avilatek_bloc/src/verify_code/verify_code_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

abstract class SendCodeBloc<T> extends Bloc<SendCodeEvent, SendCodeState<T>> {
  SendCodeBloc() : super(const SendCodeInitialized()) {
    _handler = SendCodeEventHandler<T>();
    on<SendCodePressedEvent<T>>(
      _mapSendCodePressedToState,
    );
  }

  /// Handler for [SendCodeBloc].
  late SendCodeEventHandler<T> _handler;

  /// Propagates the [SendCodePressedEvent] event down to the
  /// corresponding event handler.
  Future<void> _mapSendCodePressedToState(
    SendCodePressedEvent<T> event,
    Emitter<SendCodeState<T>> emit,
  ) async {
    return await _handleStatesOnEvent(
      isNoOp: state is SendCodeLoading ||
          state is SendCodeError ||
          state is SendCodeSuccess,
      onSendCodeInitialized: () => _handler.mapSendCodePressedToState(
        event,
        state as SendCodeInitialized<T>,
        emit,
        verifyCodePressed,
      ),
    );
  }

  /// Helper function that can be used by [_mapSendCodePressedToState]
  /// function for cleaner propagation of the events to the
  /// corresponding event handler.
  ///
  /// This function should be implemented to handle the states of the bloc
  /// when an event is dispatched.
  FutureOr<void> _handleStatesOnEvent({
    required bool isNoOp,
    Future<void> Function()? onSendCodeInitialized,
  }) async {
    if (isNoOp) {
      return;
    } else if ((state is SendCodeInitialized) &&
        onSendCodeInitialized != null) {
      return onSendCodeInitialized();
    } else {
      throw UnimplementedError(
        'No handler implemented for combination: ${state.runtimeType}.',
      );
    }
  }

  /// Function that should be implemented to verify the code.
  /// This function should return `true` if the code is verified,
  /// `false` otherwise.
  @visibleForTesting
  Future<bool> verifyCodePressed(
    SendCodeState<T> oldState,
    SendCodePressedEvent<T> event,
  );
}
