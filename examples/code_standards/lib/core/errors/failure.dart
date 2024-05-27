import 'package:equatable/equatable.dart';

class Failure extends Equatable implements Exception {
  const Failure({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class UnknownFailure extends Failure {
  const UnknownFailure({required Object error})
      : super(
          message: 'Unknown failure: $error',
          statusCode: 0,
        );
}
