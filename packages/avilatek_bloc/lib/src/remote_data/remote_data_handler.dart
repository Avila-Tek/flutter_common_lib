import 'package:avilatek_bloc/src/remote_data/remote_data_event.dart';
import 'package:avilatek_bloc/src/remote_data/remote_data_state.dart';
import 'package:bloc/bloc.dart';

///
class RemoteDataEventHandler<T> {
  ///
  const RemoteDataEventHandler();

  /// Handler for [FetchRemoteData] + [RemoteDataUninitialized] combination.
  /// Handles initial fetch when the remote data is not yet present.
  ///
  /// On success it emits: [RemoteDataInitialFetching], [RemoteDataLoaded].
  /// On failure it emits: [RemoteDataInitialFetching],
  /// [RemoteDataInitialFetchingError], [RemoteDataUninitialized].
  Future<void> mapInitialFetchRemoteDataToState(
    FetchRemoteData<T> event,
    RemoteDataUninitialized<T> state,
    Emitter<RemoteDataState<T>> emit,
    Future<T> Function(RemoteDataState<T>, FetchRemoteData<T>)
        fetchAndParseData,
  ) async {
    try {
      emit(RemoteDataInitialFetching());

      if (event.simulateError ?? false) {
        await _simulateError();
      }

      final data = await fetchAndParseData(state, event);
      emit(RemoteDataLoaded(data));
    } catch (e) {
      emit(RemoteDataInitialFetchingError(e));
      emit(RemoteDataUninitialized());
    }
  }

  /// Handler for [FetchRemoteData] + [RemoteDataLoaded] combination.
  /// Handles refetch of the remote data.
  ///
  /// On success it emits: [RemoteDataRefetching], [RemoteDataLoaded].
  /// On failure it emits: [RemoteDataRefetching], [RemoteDataRefetchingFailed],
  /// [RemoteDataLoaded].
  Future<void> mapRefetchRemoteDataToState(
    FetchRemoteData<T> event,
    RemoteDataLoaded<T> state,
    Emitter<RemoteDataState<T>> emit,
    Future<T> Function(RemoteDataState<T>, FetchRemoteData<T>)
        fetchAndParseData,
  ) async {
    try {
      emit(RemoteDataRefetching(state));

      if (event.simulateError ?? false) {
        await _simulateError();
      }

      final data = await fetchAndParseData(state, event);
      emit(RemoteDataRefetchingSuccess(data));
      emit(RemoteDataLoaded(data));
    } catch (e) {
      emit(RemoteDataRefetchingFailed(state, e));
      emit(RemoteDataLoaded.clone(state));
    }
  }

  Future<void> _simulateError() {
    Future<void>.delayed(const Duration(seconds: 1));
    throw Exception('Simulated error');
  }
}
