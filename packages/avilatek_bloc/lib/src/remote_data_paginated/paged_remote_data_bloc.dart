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
abstract class PagedRemoteDataBloc<T>
    extends Bloc<PagedRemoteDataEvent, PagedRemoteDataState<T>> {
  ///
  PagedRemoteDataBloc() : super(PagedRemoteDataUninitialized()) {
    _handler = PagedRemoteDataEventHandler<T>();
    on<PagedRemoteDataFetchNextPage>(_mapFetchNextPageRemoteDataToState);
  }
  late PagedRemoteDataEventHandler<T> _handler;

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
        state as PagedRemoteDataNextPageFetched<T>,
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
    } else if (state is PagedRemoteDataNextPageFetched &&
        onNextPageFetched != null) {
      return onNextPageFetched();
    } else {
      throw UnimplementedError(
        'No handler implemented for combination: ${state.runtimeType}.',
      );
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
}
