// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:equatable/equatable.dart';

extension SendCodeStateX on SendCodeState<dynamic> {
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

  /// Returns the last sent date time if the state is [SendCodeSuccess].
  DateTime get lastSentAt => (this as SendCodeSuccess).lastSentAt;
}

abstract class SendCodeState<T> extends Equatable {
  const SendCodeState();

  @override
  List<Object?> get props => [];
}

class SendCodeInitialized<T> extends SendCodeState<T> {
  const SendCodeInitialized();
}

class SendCodeLoading<T> extends SendCodeState<T> {
  const SendCodeLoading();
}

class SendCodeError<T> extends SendCodeState<T> {
  const SendCodeError(this.error);

  final dynamic error;

  @override
  List<Object?> get props => [...super.props, error];
}

class SendCodeSuccess<T> extends SendCodeState<T> {
  const SendCodeSuccess(
    this.lastSentAt,
  );

  final DateTime lastSentAt;
}

class SendCodeOnHoldTime<T> extends SendCodeState<T> {
  const SendCodeOnHoldTime(
    this.timeInterval,
  );

  final Duration timeInterval;
}
