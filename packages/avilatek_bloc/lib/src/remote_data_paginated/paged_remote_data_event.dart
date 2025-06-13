import 'package:equatable/equatable.dart';

/// {@template remote_data_event}
/// Abstract class that represents the events that can be dispatched to the
/// [PagedRemoteDataBloc<T>].
/// {@endtemplate}
abstract class PagedRemoteDataEvent extends Equatable {
  /// {@macro remote_data_event}
  const PagedRemoteDataEvent();

  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
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
class PagedRemoteDataRestarted extends PagedRemoteDataEvent {
  /// {@macro restart_remote_data}
  const PagedRemoteDataRestarted({this.simulateError = false});

  /// If true, the [PagedRemoteDataBloc<T>] will simulate an error.
  final bool? simulateError;
  @override
  List<Object?> get props => [simulateError];
}

/// {@template fetch_remote_data}
/// Event that triggers the retry of the fetching of the next page.
/// {@endtemplate}
class PagedRemoteDataRetryFetchNextPage extends PagedRemoteDataEvent {
  /// {@macro fetch_remote_data}
  const PagedRemoteDataRetryFetchNextPage({this.simulateError = false});

  /// If true, the [PagedRemoteDataBloc<T>] will simulate an error.
  final bool? simulateError;

  @override
  List<Object?> get props => [simulateError];
}

/// {@template paged_remote_data_locally_updated}
/// Event that triggers a local update of the data.
/// {@endtemplate}
class PagedRemoteDataLocallyUpdated<T> extends PagedRemoteDataEvent {
  /// {@macro paged_remote_data_locally_updated}
  const PagedRemoteDataLocallyUpdated(this.newList);

  /// The new list of data to be set in the state.
  final List<T> newList;

  @override
  List<Object?> get props => [newList];
}
