import 'package:avilatek_bloc/avilatek_bloc.dart';

class SendPasswordCodeBloc extends SendCodeBloc {
  SendPasswordCodeBloc({
    required int sendCodeDurationInSeconds,
    bool manuallyStartTimer = false,
  }) : super(
            sendCodeDurationInSeconds: sendCodeDurationInSeconds,
            manuallyStartTimer: manuallyStartTimer);

  @override
  Future<bool> sendCodePressed(
      SendCodeState oldState, SendCodePressedEvent event) async {
    if (event.simulateError ?? false) {
      return false;
    }
    // Send code logic here
    return true;
  }

  @override
  Future<bool> resendCodePressed(
      SendCodeState oldState, ResendCodePressedEvent event) async {
    if (event.simulateError ?? false) {
      return false;
    }
    // Resend code logic here
    return true;
  }
}
