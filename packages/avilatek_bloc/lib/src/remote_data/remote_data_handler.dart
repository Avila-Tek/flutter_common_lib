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
  /// On success it emits: [RemoteDataInitialFetching], [RemoteDataFetched].
  /// On failure it emits: [RemoteDataInitialFetching],
  /// [RemoteDataInitialFetchingFailure], [RemoteDataUninitialized].
  Future<void> mapInitialFetchRemoteDataToState(
    FetchRemoteData event,
    RemoteDataUninitialized<T> state,
    Emitter<RemoteDataState<T>> emit,
    Future<T> Function(RemoteDataState<T>, FetchRemoteData) fetchAndParseData,
  ) async {
    try {
      emit(RemoteDataInitialFetching());

      if (event.simulateError ?? false) {
        await _simulateError();
      }

      final data = await fetchAndParseData(state, event);

      emit(RemoteDataFetched(data));
    } catch (e) {
      emit(RemoteDataInitialFetchingFailure(e));
    }
  }

  /// Handler for [FetchRemoteData] + [RemoteDataFetched] combination.
  /// Handles refetch of the remote data.
  ///
  /// On success it emits: [RemoteDataRefetching], [RemoteDataFetched].
  /// On failure it emits: [RemoteDataRefetching],
  /// [RemoteDataRefetchingFailure],
  /// [RemoteDataFetched].
  Future<void> mapRefetchRemoteDataToState(
    FetchRemoteData event,
    RemoteDataFetched<T> state,
    Emitter<RemoteDataState<T>> emit,
    Future<T> Function(RemoteDataState<T>, FetchRemoteData) fetchAndParseData,
  ) async {
    try {
      emit(RemoteDataRefetching(state));

      if (event.simulateError ?? false) {
        await _simulateError();
      }

      final data = await fetchAndParseData(state, event);
      emit(RemoteDataRefetchingSuccess(data));
      emit(RemoteDataFetched(data));
    } catch (e) {
      emit(RemoteDataRefetchingFailure(state, e));
      emit(RemoteDataFetched.clone(state));
    }
  }

  Future<void> _simulateError() {
    Future<void>.delayed(const Duration(seconds: 1));
    throw Exception();
  }
}
