import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:bloc/bloc.dart';

/// Handler for [VerifyCodeBloc].
class VerifyCodeEventHandler<T> {
  /// Constructor for [VerifyCodeEventHandler].
  const VerifyCodeEventHandler();

  /// Handler for [VerifyCodePressedEvent] + [VerifyCodeInitialized]
  /// combination. Handles the verification of the code.
  ///
  /// On success it emits: [VerifyCodeSuccess].
  /// On failure it emits: [VerifyCodeError], [VerifyCodeInitialized].
  ///
  /// If [VerifyCodePressedEvent.simulateError] is true, it will
  /// simulate an error.
  ///
  /// The [verifyCodePressed] function should return true if
  /// the code is verified, false otherwise.
  ///
  /// The [VerifyCodeState] is the current state of the [VerifyCodeBloc].
  Future<void> mapVerifyCodePressedToState(
    VerifyCodePressedEvent<T> event,
    VerifyCodeState<T> state,
    Emitter<VerifyCodeState<T>> emit,
    Future<bool> Function(
      VerifyCodeState<T>,
      VerifyCodePressedEvent<T>,
    ) verifyCodePressed,
  ) async {
    try {
      emit(VerifyCodeLoading());

      if (event.simulateError ?? false) {
        await _simulateError();
      }

      final isCodeVerified = await verifyCodePressed(state, event);

      if (isCodeVerified) {
        emit(const VerifyCodeSuccess());
      }
    } catch (e) {
      emit(VerifyCodeError(e));
      emit(const VerifyCodeInitialized());
    }
  }

  Future<void> _simulateError() {
    Future<void>.delayed(const Duration(seconds: 1));
    throw Exception('Simulated error');
  }
}
