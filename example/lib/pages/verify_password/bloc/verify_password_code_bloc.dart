import 'package:avilatek_bloc/avilatek_bloc.dart';

class VerifyPasswordCodeBloc extends VerifyCodeBloc {
  VerifyPasswordCodeBloc({
    bool simulateError = false,
    required String sendTo,
  }) : super(sendTo: sendTo);

  @override
  Future<bool> verifyCodePressed(
      VerifyCodeState oldState, VerifyCodePressedEvent event) async {
    if (oldState.code != '123456' || (event.simulateError ?? false)) {
      return false;
    } else {
      /// Use oldState.sendTo to access the email or pho
      return true;
    }
  }
}
