import 'package:bloc/bloc.dart';

part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  VerifyCubit() : super(const VerifyState());

  void setCode(String code) {
    emit(state.copyWith(code: code));
  }
}
