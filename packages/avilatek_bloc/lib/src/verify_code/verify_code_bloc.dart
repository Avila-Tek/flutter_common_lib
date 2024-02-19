// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:avilatek_bloc/src/verify_code/verify_code_event.dart';
import 'package:avilatek_bloc/src/verify_code/verify_code_handler.dart';
import 'package:avilatek_bloc/src/verify_code/verify_code_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

/// Abstract Bloc implementation used to verify a code.
/// [T] is the type of the data that will be returned after the code is
/// verified.
///
/// This bloc is used to verify a code. It is used to handle the state of the
/// verification process. It is used to handle the state of the verification
/// process.
/// The states are:
/// - [VerifyCodeInitialized]: The initial state of the bloc.
/// - [VerifyCodeLoading]: The state of the bloc when the code is
/// being verified.
/// - [VerifyCodeError]: The state of the bloc when an error occurs during the
/// verification process.
/// - [VerifyCodeSuccess]: The state of the bloc when the code is successfully
/// verified.
///
/// The events are:
/// - [VerifyCodePressed]: The event that is used to verify the code.
///
/// The bloc uses the [VerifyCodeEventHandler] to handle the events.
///
///
abstract class VerifyCodeBloc<T>
    extends Bloc<VerifyCodeEvent, VerifyCodeState<T>> {
  VerifyCodeBloc() : super(const VerifyCodeInitialized()) {
    _handler = VerifyCodeEventHandler<T>();
    on<VerifyCodePressedEvent<T>>(
      _mapVerifyCodePressedToState,
    );
  }

  /// Handler for [VerifyCodeBloc].
  late VerifyCodeEventHandler<T> _handler;

  /// Propagates the [VerifyCodePressedEvent] event down to the
  /// corresponding event handler.
  Future<void> _mapVerifyCodePressedToState(
    VerifyCodePressedEvent<T> event,
    Emitter<VerifyCodeState<T>> emit,
  ) async {
    return await _handleStatesOnEvent(
      isNoOp: state is VerifyCodeLoading ||
          state is VerifyCodeError ||
          state is VerifyCodeSuccess,
      onVerifyCodeInitialized: () => _handler.mapVerifyCodePressedToState(
        event,
        state as VerifyCodeInitialized<T>,
        emit,
        verifyCodePressed,
      ),
    );
  }

  /// Helper function that can be used by [_mapVerifyCodePressedToState]
  /// function for cleaner propagation of the events to the
  /// corresponding event handler.
  ///
  /// This function should be implemented to handle the states of the bloc
  /// when an event is dispatched.
  FutureOr<void> _handleStatesOnEvent({
    required bool isNoOp,
    Future<void> Function()? onVerifyCodeInitialized,
  }) async {
    if (isNoOp) {
      return;
    } else if ((state is VerifyCodeInitialized) &&
        onVerifyCodeInitialized != null) {
      return onVerifyCodeInitialized();
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
    VerifyCodeState<T> oldState,
    VerifyCodePressedEvent<T> event,
  );
}
