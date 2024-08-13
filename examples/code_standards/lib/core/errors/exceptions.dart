import 'package:equatable/equatable.dart';

abstract class PokemonDataException extends Equatable implements Exception {
  const PokemonDataException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerException extends PokemonDataException {
  const ServerException({
    required super.message,
    required super.statusCode,
  });
}

class UnknownException extends PokemonDataException {
  const UnknownException({Object? error})
      : super(
          message: error != null ? '$error' : 'Unknown exception',
          statusCode: 0,
        );
}
