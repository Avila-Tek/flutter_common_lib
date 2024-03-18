import 'package:equatable/equatable.dart';

/// {@template remote_data_event}
/// Abstract class that represents the events that can be dispatched to the
/// [PagedRemoteDataBloc<T>].
/// {@endtemplate}
abstract class PagedRemoteDataEvent extends Equatable {
  /// {@macro remote_data_event}
  const PagedRemoteDataEvent();

  @override
  List<Object?> get props => [];
}

/// {@template fetch_remote_data}
/// Event that triggers the fetching of the next page.
/// {@endtemplate}
class PagedRemoteDataFetchNextPage extends PagedRemoteDataEvent {
  /// {@macro fetch_remote_data}
  const PagedRemoteDataFetchNextPage({this.simulateError = false});

  /// If true, the [PagedRemoteDataBloc<T>] will simulate an error.
  final bool? simulateError;

  @override
  List<Object?> get props => [simulateError];
}

/// {@template restart_remote_data}
/// Event that triggers a restart, erasing currently loaded data.
/// {@endtemplate}
class PagedRemoteDataRestart extends PagedRemoteDataEvent {
  /// {@macro restart_remote_data}
  const PagedRemoteDataRestart({this.simulateError = false});

  /// If true, the [PagedRemoteDataBloc<T>] will simulate an error.
  final bool? simulateError;
  @override
  List<Object?> get props => [simulateError];
}
