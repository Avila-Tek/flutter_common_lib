part of 'verify_cubit.dart';

class VerifyState {
  const VerifyState({
    this.code = '',
  });

  final String code;

  List<Object?> get props => [code];

  VerifyState copyWith({
    String? code,
  }) {
    return VerifyState(
      code: code ?? this.code,
    );
  }
}
