import 'package:equatable/equatable.dart';

///
extension RemoteDataStateX on RemoteDataState<dynamic> {
  /// Returns `true` if the state is not initialized and has no data to show.
  bool get isUnititialized => this is! RemoteDataInitialized;

  /// Returns `true` if the state is initialized and has data.
  bool get isInitialized => this is RemoteDataInitialized;

  /// Returns `true` if the state is either [RemoteDataInitialFetching] or
  /// [RemoteDataRefetching].
  bool get isFetching =>
      this is RemoteDataRefetching || this is RemoteDataInitialFetching;

  /// Returns `true` if the state is [RemoteDataInitialFetching].
  bool get isInitialFetching => this is RemoteDataInitialFetching;

  /// Returns `true` if the state is [RemoteDataRefetching].
  bool get isRefetching => this is RemoteDataRefetching;

  /// Returns `true` if the state is [RemoteDataInitialFetchingFailure] or
  /// [RemoteDataRefetchingFailure]
  bool get isFailure => this is RemoteDataError;
}

/// Base class for all states of the [RemoteDataBloc<T>].
abstract class RemoteDataState<T> extends Equatable {
  ///
  const RemoteDataState();

  @override
  List<Object?> get props => [];
}

/// Mixin for every [RemoteDataState] that represents network activity.
mixin RemoteDataFetching<T> on RemoteDataState<T> {}

/// Mixin for every [RemoteDataState] that represents a temporary success.
mixin RemoteDataSuccess<T> on RemoteDataState<T> {}

/// Mixin for every [RemoteDataState] that represents a temporary error.
mixin RemoteDataError<T> on RemoteDataState<T> {}

// #####################
// Uninitialized States
// #####################

/// Initial state of the [RemoteDataBloc<T>].
class RemoteDataUninitialized<T> extends RemoteDataState<T> {}

/// State that represents the initial fetching of the remote data. This state
/// is only emitted once, when the [FetchRemoteData<T>] event is dispatched
/// when the [RemoteDataBloc<T>] is in the [RemoteDataUninitialized] state.
///
class RemoteDataInitialFetching<T> extends RemoteDataState<T>
    with RemoteDataFetching<T> {}

/// State that represents the initial fetching of the remote data that failed.
///
/// This state is only emitted from the [RemoteDataInitialFetching] state.
class RemoteDataInitialFetchingFailure<T> extends RemoteDataState<T>
    with RemoteDataError<T> {
  ///
  const RemoteDataInitialFetchingFailure(this.error);

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
/// [RemoteDataFetched], [RemoteDataRefetching], [RemoteDataRefetchingSuccess]
/// and [RemoteDataRefetchingFailure].
///
/// All the subclasses of this class have the [data] property with
/// information that can be displayed even after failure.
/// {@endtemplate}
abstract class RemoteDataInitialized<T> extends RemoteDataState<T> {
  /// {@macro remote_data_loaded}
  const RemoteDataInitialized(this.data);

  /// {@template remote_data_initialized.clone}
  /// Creates a copy of the current state with the old state's data.
  /// {@endtemplate}
  RemoteDataInitialized.clone(RemoteDataInitialized<T> other)
      : this(other.data);

  /// The data that was fetched.
  final T data;

  @override
  List<Object?> get props => [...super.props, data];
}

/// {@template remote_data_loaded}
/// State that represents the successful fetching of the remote data.
/// {@endtemplate}
class RemoteDataFetched<T> extends RemoteDataInitialized<T> {
  /// {@macro remote_data_loaded}
  const RemoteDataFetched(super.data);

  /// {@macro remote_data_initialized.clone}
  RemoteDataFetched.clone(super.oldState) : super.clone();
}

/// {@template remote_data_refetching}
/// State that represents the refetching of the remote data.
/// {@endtemplate
class RemoteDataRefetching<T> extends RemoteDataInitialized<T>
    with RemoteDataFetching<T> {
  /// {@macro remote_data_refetching}
  RemoteDataRefetching(super.oldState) : super.clone();
}

/// {@template remote_data_refetching_success}
/// State that represents the successful refetching of the remote data.
/// {@endtemplate}
class RemoteDataRefetchingSuccess<T> extends RemoteDataInitialized<T>
    with RemoteDataSuccess<T> {
  /// {@macro remote_data_refetching_success}
  const RemoteDataRefetchingSuccess(super.data);

  /// {@macro remote_data_initialized.clone}
  RemoteDataRefetchingSuccess.clone(super.oldState) : super.clone();
}

/// {@template remote_data_refetching_failed}
/// State that represents the failed refetching of the remote data.
/// {@endtemplate}
class RemoteDataRefetchingFailure<T> extends RemoteDataInitialized<T>
    with RemoteDataError<T> {
  /// {@macro remote_data_refetching_failed}
  RemoteDataRefetchingFailure(super.oldState, this.error) : super.clone();

  /// The error that caused the refetching to fail.
  final dynamic error;

  @override
  List<Object?> get props => [...super.props, error];
}
