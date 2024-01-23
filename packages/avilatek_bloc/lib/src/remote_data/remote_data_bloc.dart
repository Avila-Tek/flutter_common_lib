import 'package:avilatek_bloc/src/remote_data/remote_data_event.dart';
import 'package:avilatek_bloc/src/remote_data/remote_data_handler.dart';
import 'package:avilatek_bloc/src/remote_data/remote_data_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

export 'package:avilatek_bloc/src/remote_data/remote_data_event.dart';
export 'package:avilatek_bloc/src/remote_data/remote_data_state.dart';

/// Abstract Bloc implementation for simple hydrated "Fetch and Store Data"
/// Blocs.
///
/// Any Object/Primitive Data can be accessed via the
/// [RemoteDataInitialized.data] property.
abstract class RemoteDataBloc<T>
    extends Bloc<RemoteDataEvent, RemoteDataState<T>> {
  ///
  RemoteDataBloc() : super(RemoteDataUninitialized()) {
    _handler = RemoteDataEventHandler<T>();
    on<FetchRemoteData<T>>(_mapFetchRemoteDataToState);
  }
  late RemoteDataEventHandler<T> _handler;

  /// Propagates the [FetchRemoteData] event down to the corresponding event
  /// handler.
  Future<void> _mapFetchRemoteDataToState(
    FetchRemoteData<T> event,
    Emitter<RemoteDataState<T>> emit,
  ) async {
    return _handleStatesOnEvent(
      isNoOp: state is RemoteDataFetching ||
          state is RemoteDataError ||
          state is RemoteDataSuccess,
      onRemoteDataUninitialized: () =>
          _handler.mapInitialFetchRemoteDataToState(
        event,
        state as RemoteDataUninitialized<T>,
        emit,
        fetchAndParseData,
      ),
      onRemoteDataLoaded: () => _handler.mapRefetchRemoteDataToState(
        event,
        state as RemoteDataLoaded<T>,
        emit,
        fetchAndParseData,
      ),
    );
  }

  /// Helper function that can be used by [_mapFetchRemoteDataToState] function
  /// for cleaner propagation of the events to the corresponding event handler.
  Future<void> _handleStatesOnEvent({
    required bool isNoOp,
    Future<void> Function()? onRemoteDataUninitialized,
    Future<void> Function()? onRemoteDataLoaded,
  }) async {
    if (isNoOp) {
      return;
    } else if (state is RemoteDataUninitialized &&
        onRemoteDataUninitialized != null) {
      return onRemoteDataUninitialized();
    } else if (state is RemoteDataLoaded && onRemoteDataLoaded != null) {
      return onRemoteDataLoaded();
    } else {
      throw UnimplementedError(
        'No handler implemented for combination: ${state.runtimeType}.',
      );
    }
  }

  /// Function which retrieves the blocs data from the backend,
  /// parses the response and returns the parsed [T] Object.
  /// The [oldState] and thus the old [T] object is also accesible,
  /// if merging of the new and old data is required.
  @visibleForTesting
  Future<T> fetchAndParseData(
    RemoteDataState<T> oldState,
    FetchRemoteData<T> event,
  );
}
