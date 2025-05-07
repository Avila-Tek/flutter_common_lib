// ignore_for_file: lines_longer_than_80_chars

import 'package:avilatek_bloc/src/remote_data_paginated/paged_remote_data_event.dart';
import 'package:avilatek_bloc/src/remote_data_paginated/paged_remote_data_handler.dart';
import 'package:avilatek_bloc/src/remote_data_paginated/paged_remote_data_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

export 'package:avilatek_bloc/src/remote_data_paginated/paged_remote_data_event.dart';
export 'package:avilatek_bloc/src/remote_data_paginated/paged_remote_data_state.dart';

/// Abstract Bloc implementation for simple hydrated "Fetch and Store Data"
/// Blocs.
///
/// Any Object/Primitive Data can be accessed via the
/// [PagedRemoteDataInitialized.data] property.
/// Or via the [getDataFromState] method.
abstract class PagedRemoteDataBloc<T>
    extends Bloc<PagedRemoteDataEvent, PagedRemoteDataState<T>> {
  ///
  PagedRemoteDataBloc() : super(PagedRemoteDataUninitialized()) {
    _handler = PagedRemoteDataEventHandler<T>();
    on<PagedRemoteDataFetchNextPage>(_mapFetchNextPageRemoteDataToState);

    on<PagedRemoteDataRestarted>((event, emit) {
      emit(PagedRemoteDataUninitialized<T>());
      add(const PagedRemoteDataFetchNextPage());
    });

    on<PagedRemoteDataRetryFetchNextPage>((event, emit) {
      add(const PagedRemoteDataFetchNextPage());
    });
  }
  late PagedRemoteDataEventHandler<T> _handler;

  /// This method is used to access the data from the current state.
  /// It returns a [List<T>] if the state is [PagedRemoteDataInitialized],
  /// otherwise it returns null.
  /// This method is useful for accessing the data from the current state
  /// without having to check the state type.
  List<T>? getDataFromState(PagedRemoteDataState<T> state) {
    if (state is PagedRemoteDataInitialized<T>) {
      return state.data;
    }
    return null;
  }

  /// Propagates the [PagedRemoteDataFetchNextPage] event down to the corresponding event
  /// handler.
  Future<void> _mapFetchNextPageRemoteDataToState(
    PagedRemoteDataFetchNextPage event,
    Emitter<PagedRemoteDataState<T>> emit,
  ) async {
    return _handleStatesOnEvent(
      isNoOp: state is PagedRemoteDataFetching ||
          state is PagedRemoteDataFailure ||
          state is PagedRemoteDataSuccess ||
          state is PagedRemoteDataLastPageFetched,
      onPagedRemoteDataUninitialized: () =>
          _handler.mapInitialFetchNextPageToState(
        event,
        state as PagedRemoteDataUninitialized<T>,
        emit,
        fetchAndParseNextPage,
      ),
      onNextPageFetched: () => _handler.mapFetchNextPageRemoteDataToState(
        event,
        state as PagedRemoteDataInitialized<T>,
        emit,
        fetchAndParseNextPage,
      ),
    );
  }

  /// Helper function that can be used by [_mapFetchNextPageRemoteDataToState] function
  /// for cleaner propagation of the events to the corresponding event handler.
  Future<void> _handleStatesOnEvent({
    required bool isNoOp,
    Future<void> Function()? onPagedRemoteDataUninitialized,
    Future<void> Function()? onNextPageFetched,
  }) async {
    if (isNoOp) {
      return;
    } else if (state is PagedRemoteDataUninitialized &&
        onPagedRemoteDataUninitialized != null) {
      return onPagedRemoteDataUninitialized();
    } else if ((state is PagedRemoteDataNextPageFetched ||
            state is PagedRemoteDataNextPageFetchingFailure) &&
        onNextPageFetched != null) {
      return onNextPageFetched();
    } else {
      // coverage:ignore-start
      throw UnimplementedError(
        'No handler implemented for combination: ${state.runtimeType}.',
      );
      // coverage:ignore-end
    }
  }

  /// Function called to retrieve the next page of data and update the current
  /// state.
  /// It is called when a [PagedRemoteDataFetchNextPage] event is dispatched.
  ///
  /// **Important Note:**
  /// Do not return the data from previous pages, as it is by the
  /// [PagedRemoteDataBloc] state handler.
  ///
  /// The [oldState] and thus the old [List<T>] with the data from previous
  /// pages is also accesible, if merging of the new page and previous pages is
  /// required to make any calculations.
  ///
  /// Must resolve in a [List<T>] with the next page of data,
  /// and a [bool] value that indicates whether the last page has been fetched,
  /// in which case the [PagedRemoteDataBloc] will emit a
  /// [PagedRemoteDataLastPageFetched] state instead of a [PagedRemoteDataNextPageFetched]
  /// state if successful.
  @visibleForTesting
  Future<(List<T>, bool)> fetchAndParseNextPage(
    PagedRemoteDataState<T> oldState,
    PagedRemoteDataFetchNextPage event,
  );

  // NOTE: Leaving this here in case adding pre or post fetch hooks is required for restart method
  // /// Fetches and returns the first page of data from the remote source. Use this
  // /// method when you want to restart the view and fetch the first page of data.
  // ///
  // /// This method is called when a [PagedRemoteDataRestart] event is dispatched.
  // ///
  // /// The [oldState] parameter represents the previous state of the paged remote data.
  // /// The [event] parameter represents the event triggering the fetch of the next page.
  // ///
  // /// Returns a [Future] that completes with a tuple containing a list of [T] items and a boolean value.
  // /// The list represents the fetched data for the first page, while the boolean value indicates whether there are more pages to fetch.
  // @visibleForTesting
  // Future<(List<T>, bool)> restart(
  //   PagedRemoteDataState<T> oldState,
  //   PagedRemoteDataFetchNextPage event,
  // );
}
