// ignore_for_file: lines_longer_than_80_chars

import 'package:avilatek_bloc/src/remote_data_paginated/paged_remote_data_event.dart';
import 'package:avilatek_bloc/src/remote_data_paginated/paged_remote_data_state.dart';
import 'package:bloc/bloc.dart';

///
class PagedRemoteDataEventHandler<T> {
  ///
  const PagedRemoteDataEventHandler();

  /// Handler for [PagedRemoteDataFetchNextPage] + [PagedRemoteDataUninitialized] combination.
  /// Handles initial fetch when the remote data is not yet present.
  ///
  /// On success it emits: [PagedRemoteDataFirstPageFetching], and [PagedRemoteDataNextPageFetched]
  /// or [PagedRemoteDataLastPageFetched].
  /// On failure it emits: [PagedRemoteDataFirstPageFetching],
  /// [PagedRemoteDataFirstPageFetchingFailure], [PagedRemoteDataUninitialized].
  Future<void> mapInitialFetchNextPageToState(
    PagedRemoteDataFetchNextPage event,
    PagedRemoteDataUninitialized<T> state,
    Emitter<PagedRemoteDataState<T>> emit,
    Future<(List<T>, bool)> Function(
      PagedRemoteDataState<T>,
      PagedRemoteDataFetchNextPage,
    ) fetchAndParseNextPage,
  ) async {
    try {
      emit(PagedRemoteDataFirstPageFetching());

      if (event.simulateError ?? false) {
        await _simulateError();
      }

      final (data, isLastPage) = await fetchAndParseNextPage(state, event);

      if (isLastPage) {
        emit(PagedRemoteDataLastPageFetched(data));
      } else {
        emit(PagedRemoteDataNextPageFetched(data));
      }
    } catch (e) {
      emit(PagedRemoteDataFirstPageFetchingFailure(e));
      emit(PagedRemoteDataUninitialized());
    }
  }

  /// Handler for [PagedRemoteDataFetchNextPage] + [PagedRemoteDataNextPageFetched] combination.
  /// Handles refetch of the remote data.
  ///
  /// On success it emits: [PagedRemoteDataNextPageFetching],
  /// [PagedRemoteDataNextPageFetchingSuccess], and [PagedRemoteDataNextPageFetched]
  /// or [PagedRemoteDataLastPageFetched].
  /// On failure it emits: [PagedRemoteDataNextPageFetching],
  /// [PagedRemoteDataNextPageFetchingFailure].
  Future<void> mapFetchNextPageRemoteDataToState(
    PagedRemoteDataFetchNextPage event,
    PagedRemoteDataNextPageFetched<T> state,
    Emitter<PagedRemoteDataState<T>> emit,
    Future<(List<T>, bool)> Function(
      PagedRemoteDataState<T>,
      PagedRemoteDataFetchNextPage,
    ) fetchAndParseNextPage,
  ) async {
    try {
      emit(PagedRemoteDataNextPageFetching(state));

      if (event.simulateError ?? false) {
        await _simulateError();
      }

      final (nextPageData, isLastPage) =
          await fetchAndParseNextPage(state, event);

      final data = [...state.data, ...nextPageData];

      if (isLastPage) {
        emit(PagedRemoteDataLastPageFetched(data));
      } else {
        emit(PagedRemoteDataNextPageFetched(data));
      }
    } catch (e) {
      emit(PagedRemoteDataNextPageFetchingFailure(state, e));
    }
  }

  Future<void> _simulateError() {
    Future<void>.delayed(const Duration(seconds: 1));
    throw Exception('Simulated error');
  }
}
