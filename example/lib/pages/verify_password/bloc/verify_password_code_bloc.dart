import 'package:avilatek_bloc/avilatek_bloc.dart';

class VerifyPasswordCodeBloc extends VerifyCodeBloc {
  VerifyPasswordCodeBloc({
    bool simulateError = false,
  }) : super();

  @override
  Future<bool> verifyCodePressed(
      VerifyCodeState oldState, VerifyCodePressedEvent event) async {
    if (event.code != '123456' || (event.simulateError ?? false)) {
      return false;
    } else {
      return true;
    }
  }
}
