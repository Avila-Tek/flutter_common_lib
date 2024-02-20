// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:avilatek_bloc/src/send_code/send_code_event.dart';
import 'package:avilatek_bloc/src/send_code/send_code_handler.dart';
import 'package:avilatek_bloc/src/send_code/send_code_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

abstract class SendCodeBloc extends Bloc<SendCodeEvent, SendCodeState> {
  SendCodeBloc({
    required int sendCodeDurationInSeconds,
  })  : _sendCodeDuration = sendCodeDurationInSeconds,
        super(const SendCodeInitialized()) {
    _handler = const SendCodeEventHandler();

    on<SendCodePressedEvent>(
      _mapSendCodePressedToState,
    );
    on<SendCodeTickTimerEvent>((event, emit) {
      emit(
        event.durationInSeconds > 0
            ? SendCodeOnHoldTime(event.durationInSeconds)
            : const SendCodeInitialized(),
      );
    });
  }
  StreamSubscription<int>? tickerSubscription;
  final int _sendCodeDuration;

  /// Handler for [SendCodeBloc].
  late SendCodeEventHandler _handler;

  /// Propagates the [SendCodePressedEvent] event down to the
  /// corresponding event handler.
  Future<void> _mapSendCodePressedToState(
    SendCodePressedEvent event,
    Emitter<SendCodeState> emit,
  ) async {
    return await _handleStatesOnEvent(
      isNoOp: state is SendCodeLoading ||
          state is SendCodeError ||
          state is SendCodeSuccess,
      onSendCodeInitialized: () {
        _startOrResetTimer();
        return _handler.mapSendCodePressedToState(
          event,
          state as SendCodeInitialized,
          emit,
          sendCodePressed,
        );
      },
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

  /// Function that should be implemented to send the code.
  /// This function should return `true` if the code is sent,
  /// `false` otherwise.
  @visibleForTesting
  Future<bool> sendCodePressed(
    SendCodeState oldState,
    SendCodePressedEvent event,
  );

  void _startOrResetTimer() {
    tickerSubscription?.cancel();
    tickerSubscription = Stream.periodic(
      const Duration(seconds: 1),
      (x) => _sendCodeDuration - x - 1,
    )
        .take(_sendCodeDuration)
        .listen((duration) => add(SendCodeTickTimerEvent(duration)));
  }
}
