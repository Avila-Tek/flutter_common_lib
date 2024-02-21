// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, unnecessary_getters_setters

import 'package:equatable/equatable.dart';

extension SendCodeStateX on SendCodeState {
  /// Returns `true` if the state is initialized and has data.
  bool get isInitialized => this is SendCodeInitialized;

  /// Returns `true` if the state is [SendCodeLoading].
  bool get isLoading => this is SendCodeLoading;

  /// Returns `true` if the state is [SendCodeError].
  bool get isError => this is SendCodeError;

  /// Returns `true` if the state is [SendCodeSuccess].
  bool get isSuccess => this is SendCodeSuccess;

  /// Returns `true` if the state is [SendCodeOnHoldTime].
  bool get isOnHoldTime => this is SendCodeOnHoldTime;
}

abstract class SendCodeState extends Equatable {
  const SendCodeState();

  static String _input = '';

  String get input => _input;

  set input(String newInput) {
    _input = newInput;
  }

  @override
  List<Object?> get props => [input];
}

class SendCodeInitialized extends SendCodeState {
  const SendCodeInitialized();
}

class SendCodeLoading extends SendCodeState {
  const SendCodeLoading();
}

class SendCodeError extends SendCodeState {
  const SendCodeError(this.error);

  final dynamic error;

  @override
  List<Object?> get props => [...super.props, error];
}

class SendCodeSuccess extends SendCodeState {
  const SendCodeSuccess();
}

class SendCodeOnHoldTime extends SendCodeState {
  const SendCodeOnHoldTime(
    this.durationInSeconds,
  );

  final int durationInSeconds;

  @override
  List<Object?> get props => [durationInSeconds];
}
