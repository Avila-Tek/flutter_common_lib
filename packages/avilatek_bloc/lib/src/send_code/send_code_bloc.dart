// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:avilatek_bloc/src/send_code/send_code_event.dart';
import 'package:avilatek_bloc/src/send_code/send_code_handler.dart';
import 'package:avilatek_bloc/src/send_code/send_code_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

/// Abstract Bloc implementation used to send a code.
///
/// This bloc is used to send a code. It is used to handle the state of the
/// sending process.
///
/// The states are:
/// - [SendCodeInitialized]: The initial state of the bloc.
/// - [SendCodeLoading]: The state of the bloc when the code is
/// being sent.
/// - [SendCodeError]: The state of the bloc when an error occurs during the
/// sending process.
/// - [SendCodeSuccess]: The state of the bloc when the code is successfully
/// sent.
/// - [SendCodeOnHoldTime]: The state of the bloc when the code is on hold.
///
/// The events are:
/// - [SendCodePressed]: The event that is used to send the code.
/// - [SendCodeTickTimerEvent]: The event that is used to tick the timer.
/// - [SendCodeInputChangedEvent]: The event that is used to change the input.
///
/// The bloc uses the [SendCodeEventHandler] to handle the events.
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

    on<SendCodeInputChangedEvent>(_onSendCodeInputChangedEvent);
  }

  /// The subscription to the ticker.
  /// This subscription is used to tick the timer.
  StreamSubscription<int>? _tickerSubscription;

  /// The duration of the send code process.
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

  /// Starts or resets the timer.
  ///
  /// If the timer is already running, it will be canceled and started again.
  ///
  /// If the timer is not running, it will be started.
  ///
  /// The timer will tick every second and will emit a [SendCodeTickTimerEvent]
  ///
  /// The timer will tick for the duration of the [_sendCodeDuration] parameter.
  void _startOrResetTimer() {
    _tickerSubscription?.cancel();
    _tickerSubscription = Stream.periodic(
      const Duration(seconds: 1),
      (x) => _sendCodeDuration - x - 1,
    )
        .take(_sendCodeDuration)
        .listen((duration) => add(SendCodeTickTimerEvent(duration)));
  }

  /// Closes the ticker subscription.
  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  /// Handles the [SendCodeInputChangedEvent] event.
  FutureOr<void> _onSendCodeInputChangedEvent(
    SendCodeInputChangedEvent event,
    Emitter<SendCodeState> emit,
  ) {
    state.input = event.input;
  }
}
