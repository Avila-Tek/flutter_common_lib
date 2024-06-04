import 'package:code_standards/core/core.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  const Failure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    required this.statusCode,
  });

  ServerFailure.fromException(ServerException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );

  final int statusCode;

  @override
  List<Object?> get props => [...super.props, statusCode];
}

class UnknownFailure extends Failure {
  const UnknownFailure(Object? error)
      : super(
          message:
              error != null ? 'Unknown failure: $error' : 'Unknown failure',
        );
}
