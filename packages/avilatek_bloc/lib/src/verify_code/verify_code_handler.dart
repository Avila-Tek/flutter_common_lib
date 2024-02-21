import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:bloc/bloc.dart';

/// Handler for [VerifyCodeBloc].
class VerifyCodeEventHandler {
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
    VerifyCodePressedEvent event,
    VerifyCodeState state,
    Emitter<VerifyCodeState> emit,
    Future<bool> Function(
      VerifyCodeState,
      VerifyCodePressedEvent,
    ) verifyCodePressed,
  ) async {
    try {
      emit(const VerifyCodeLoading());

      if (event.simulateError ?? false) {
        await _simulateError();
      }

      final isCodeVerified = await verifyCodePressed(state, event);

      if (isCodeVerified) {
        emit(const VerifyCodeSuccess());
      } else {
        throw Exception();
      }
    } catch (e) {
      emit(VerifyCodeError(error: e));
      emit(const VerifyCodeInitialized());
    }
  }

  Future<void> _simulateError() {
    Future<void>.delayed(const Duration(seconds: 1));
    throw Exception('Simulated error');
  }
}
