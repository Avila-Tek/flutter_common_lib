import 'package:equatable/equatable.dart';

///
extension SendDataStateX on SendDataState {
  /// Returns `true` if the state is [SendDataReady], ready to send data.
  bool get isReady => this is SendDataReady;

  /// Returns `true` if the state is [SendDataLoading], waiting for the data to
  /// be sent.
  bool get isLoading => this is SendDataLoading;

  /// Returns `true` if the state is [SendDataFailure], the data transmission
  /// failed.
  bool get isFailure => this is SendDataFailure;

  /// Returns `true` if the state is [SendDataSuccess], the data was sent
  /// successfully.
  bool get isSuccess => this is SendDataSuccess;
}

/// Base class for all states of the [SendDataBloc<T>].
abstract class SendDataState extends Equatable {
  ///
  const SendDataState();

  @override
  List<Object?> get props => [];
}

/// Initial state of the [SendDataBloc<T>].
class SendDataReady extends SendDataState {}

/// State during which the bloc is waiting for the asynchonous task to
/// finish.
class SendDataLoading extends SendDataState {}

/// {@template send_data_failure}
/// State emitted when the data transmission fails.
///
/// This state is only emitted from the [SendDataLoading] state.
/// {@endtemplate}
class SendDataFailure<T> extends SendDataState {
  /// {@macro send_data_failure}
  const SendDataFailure(this.data, this.error);

  /// The data that was just sent.
  final T data;

  /// The error that caused the data transmission to fail.
  final dynamic error;

  @override
  List<Object?> get props => [...super.props, data, error];
}

/// {@template send_data_success}
/// State emitted when the data is sent successfully.
///
/// This state is only emitted from the [SendDataLoading] state.
/// {@endtemplate}
class SendDataSuccess<T> extends SendDataState {
  /// {@macro send_data_success}
  const SendDataSuccess(this.data);

  /// The data that was just sent.
  final T data;

  @override
  List<Object?> get props => [...super.props, data];
}
