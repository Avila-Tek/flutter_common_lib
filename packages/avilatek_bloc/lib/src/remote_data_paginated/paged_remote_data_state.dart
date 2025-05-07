// ignore_for_file: lines_longer_than_80_chars

import 'package:equatable/equatable.dart';

///
extension PagedRemoteDataStateX on PagedRemoteDataState<dynamic> {
  /// Returns `true` if the state is not initialized and has no data to show.
  bool get isUnititialized => this is! PagedRemoteDataInitialized;

  /// Returns `true` if the state is initialized and has data.
  bool get isInitialized => this is PagedRemoteDataInitialized;

  /// Returns `true` if the state is either [PagedRemoteDataFirstPageFetching] or
  /// [PagedRemoteDataNextPageFetching].
  bool get isFetchingAnyPage =>
      this is PagedRemoteDataNextPageFetching ||
      this is PagedRemoteDataFirstPageFetching;

  /// Returns `true` if the state is [PagedRemoteDataFirstPageFetching].
  bool get isFetchingFirstPage => this is PagedRemoteDataFirstPageFetching;

  /// Returns `true` if the state is [PagedRemoteDataNextPageFetching].
  bool get isFetchingNextPage => this is PagedRemoteDataNextPageFetching;

  /// Returns `true` if the state is [PagedRemoteDataFirstPageFetchingFailure].
  bool get isFetchingFirstPageError =>
      this is PagedRemoteDataFirstPageFetchingFailure;

  /// Returns `true` if the state is [PagedRemoteDataNextPageFetchingFailure].
  bool get isFetchingNextPageError =>
      this is PagedRemoteDataNextPageFetchingFailure;

  /// Returns `true` if the state is [PagedRemoteDataNextPageFetchingSuccess].
  bool get isFetchingNextPageSuccess =>
      this is PagedRemoteDataNextPageFetchingSuccess;

  /// Returns `true` if the state is [PagedRemoteDataLastPageFetched].
  bool get isLastPageFetched => this is PagedRemoteDataLastPageFetched;
}

/// Base class for all states of the [RemoteDataBloc<T>].
abstract class PagedRemoteDataState<T> extends Equatable {
  ///
  const PagedRemoteDataState();

  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

/// Mixin for every [PagedRemoteDataState] that represents network activity.
mixin PagedRemoteDataFetching<T> on PagedRemoteDataState<T> {}

/// Mixin for every [PagedRemoteDataState] that represents a temporary success.
mixin PagedRemoteDataSuccess<T> on PagedRemoteDataState<T> {}

/// Mixin for every [PagedRemoteDataState] that represents a temporary error.
mixin PagedRemoteDataFailure<T> on PagedRemoteDataState<T> {}

// #####################
// Uninitialized States
// #####################

/// Initial state of the [RemoteDataBloc<T>].
class PagedRemoteDataUninitialized<T> extends PagedRemoteDataState<T> {}

/// State that represents the fetching of the first page of data. This state
/// is only emitted once, when the [FetchRemoteDataPaginated<T>] event is dispatched
/// when the [RemoteDataBloc<T>] is in the [PagedRemoteDataUninitialized] state.
///
class PagedRemoteDataFirstPageFetching<T> extends PagedRemoteDataState<T>
    with PagedRemoteDataFetching<T> {}

/// State that represents the fetching of the first page of data failed.
///
/// This state is only emitted from the [PagedRemoteDataFirstPageFetching] state.
class PagedRemoteDataFirstPageFetchingFailure<T> extends PagedRemoteDataState<T>
    with PagedRemoteDataFailure<T> {
  ///
  const PagedRemoteDataFirstPageFetchingFailure(this.error);

  /// The error that caused the fetching to fail.
  final dynamic error;

  @override
  List<Object?> get props => [...super.props, error];
}

// ###################
// Initialized States
// ###################

/// {@template remote_data_loaded}
/// Base class for states with fetched data:
/// [PagedRemoteDataNextPageFetched], [PagedRemoteDataNextPageFetching], [PagedRemoteDataNextPageFetchingSuccess]
/// and [PagedRemoteDataNextPageFetchingFailure].
///
/// All the subclasses of this class have the [data] property with
/// information that can be displayed even after failure.
/// {@endtemplate}
abstract class PagedRemoteDataInitialized<T> extends PagedRemoteDataState<T> {
  /// {@macro remote_data_loaded}
  const PagedRemoteDataInitialized(this.data);

  /// {@template remote_data_initialized.clone}
  /// Creates a copy of the current state with the old state's data.
  /// {@endtemplate}
  PagedRemoteDataInitialized.clone(PagedRemoteDataInitialized<T> other)
      : this(other.data);

  /// The data that was fetched.
  final List<T> data;

  @override
  List<Object?> get props => [...super.props, data];
}

/// {@template remote_data_loaded}
/// State that represents the successful fetching of the next page of data.
/// {@endtemplate}
class PagedRemoteDataNextPageFetched<T> extends PagedRemoteDataInitialized<T> {
  /// {@macro remote_data_loaded}
  const PagedRemoteDataNextPageFetched(super.data);

  /// {@macro remote_data_initialized.clone}
  PagedRemoteDataNextPageFetched.clone(super.oldState) : super.clone();
}

/// {@template remote_data_loaded}
/// State that represents the successful fetching of the last page of data. No
/// more pages will be fetched.
/// {@endtemplate}
class PagedRemoteDataLastPageFetched<T> extends PagedRemoteDataInitialized<T> {
  /// {@macro remote_data_loaded}
  const PagedRemoteDataLastPageFetched(super.data);

  /// {@macro remote_data_initialized.clone}
  PagedRemoteDataLastPageFetched.clone(super.oldState) : super.clone();
}

/// {@template remote_data_refetching}
/// State that represents the fetching of the next page of data.
/// {@endtemplate
class PagedRemoteDataNextPageFetching<T> extends PagedRemoteDataInitialized<T>
    with PagedRemoteDataFetching<T> {
  /// {@macro remote_data_refetching}
  PagedRemoteDataNextPageFetching(super.oldState) : super.clone();
}

/// {@template remote_data_refetching_success}
/// Temporal State that represents the successful fetch of the next page of data.
/// {@endtemplate}
class PagedRemoteDataNextPageFetchingSuccess<T>
    extends PagedRemoteDataInitialized<T> with PagedRemoteDataSuccess<T> {
  /// {@macro remote_data_refetching_success}
  const PagedRemoteDataNextPageFetchingSuccess(super.data);

  /// {@macro remote_data_initialized.clone}
  PagedRemoteDataNextPageFetchingSuccess.clone(super.oldState) : super.clone();
}

/// {@template remote_data_refetching_failed}
/// Temporal State that represents the failed fetch of the next page of data.
/// {@endtemplate}
class PagedRemoteDataNextPageFetchingFailure<T>
    extends PagedRemoteDataInitialized<T> with PagedRemoteDataFailure<T> {
  /// {@macro remote_data_refetching_failed}
  PagedRemoteDataNextPageFetchingFailure(super.oldState, this.error)
      : super.clone();

  /// The error that caused the refetching to fail.
  final dynamic error;

  @override
  List<Object?> get props => [...super.props, error];
}

/// This state is emitted when the next page is being fetched again after a
/// failure.
class PagedRemoteDataRetryNextPageFetching<T> extends PagedRemoteDataState<T> {}
