import 'package:equatable/equatable.dart';

/// {@template send_data_event}
/// Abstract class that represents the events that can be dispatched to the
/// [SendDataBloc<T>].
/// {@endtemplate}
abstract class SendDataEvent extends Equatable {
  /// {@macro send_data_event}
  const SendDataEvent();

  @override
  List<Object?> get props => [];
}

/// {@template data_sent}
/// Event that triggers the fetching of the send data.
/// {@endtemplate}
class DataSent extends SendDataEvent {
  /// {@macro fetch_send_data}
  const DataSent(this.data, {this.simulateError = false});

  /// If true, the [SendDataBloc<T>] will simulate an error.
  final bool? simulateError;

  /// The data that is to be sent.
  final dynamic data;

  @override
  List<Object?> get props => [simulateError, data];
}
