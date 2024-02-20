import 'package:avilatek_bloc/avilatek_bloc.dart';

class SendPasswordCodeBloc extends SendCodeBloc {
  SendPasswordCodeBloc({
    required int sendCodeDurationInSeconds,
  }) : super(sendCodeDurationInSeconds: sendCodeDurationInSeconds) {
    add(const SendCodePressedEvent());
  }

  @override
  Future<bool> sendCodePressed(
      SendCodeState oldState, SendCodePressedEvent event) async {
    if (event.simulateError ?? false) {
      return false;
    }
    // Send code logic here
    return true;
  }
}
