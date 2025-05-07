import 'package:equatable/equatable.dart';

/// {@template remote_data_event}
/// Abstract class that represents the events that can be dispatched to the
/// [RemoteDataBloc<T>].
/// {@endtemplate}
abstract class RemoteDataEvent extends Equatable {
  /// {@macro remote_data_event}
  const RemoteDataEvent();
}

/// {@template fetch_remote_data}
/// Event that triggers the fetching of the remote data.
/// {@endtemplate}
class FetchRemoteData extends RemoteDataEvent {
  /// {@macro fetch_remote_data}
  const FetchRemoteData({this.simulateError = false});

  /// If true, the [RemoteDataBloc<T>] will simulate an error.
  final bool? simulateError;

  @override
  List<Object?> get props => [simulateError];
}

/// {@template restart_remote_data}
/// Event that triggers a restart, erasing currently loaded data.
/// {@endtemplate}
class RemoteDataRestarted extends RemoteDataEvent {
  /// {@macro restart_remote_data}
  const RemoteDataRestarted({this.simulateError = false});

  /// If true, the [PagedRemoteDataBloc<T>] will simulate an error.
  final bool? simulateError;
  @override
  List<Object?> get props => [simulateError];
}
