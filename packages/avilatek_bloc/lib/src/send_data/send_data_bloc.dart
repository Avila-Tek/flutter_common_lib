import 'package:avilatek_bloc/src/send_data/send_data_event.dart';
import 'package:avilatek_bloc/src/send_data/send_data_handler.dart';
import 'package:avilatek_bloc/src/send_data/send_data_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

export 'package:avilatek_bloc/src/send_data/send_data_event.dart';
export 'package:avilatek_bloc/src/send_data/send_data_state.dart';

/// Abstract Bloc simple "Send Data" blocs.
abstract class SendDataBloc<T> extends Bloc<SendDataEvent, SendDataState> {
  ///
  SendDataBloc() : super(SendDataReady()) {
    _handler = SendDataEventHandler<T>();
    on<DataSent>(_mapDataSentToState);
  }
  late SendDataEventHandler<T> _handler;

  /// Propagates the [DataSent] event down to the corresponding event
  /// handler.
  Future<void> _mapDataSentToState(
    DataSent event,
    Emitter<SendDataState> emit,
  ) async {
    return _handleStatesOnEvent(
      isNoOp: state is SendDataLoading ||
          state is SendDataFailure<T> ||
          state is SendDataSuccess<T>,
      onDataSent: () => _handler.mapDataSentToState(
        event,
        state as SendDataReady,
        emit,
        sendData,
      ),
    );
  }

  /// Helper function that can be used by [_mapDataSentToState] function
  /// for cleaner propagation of the events to the corresponding event handler.
  Future<void> _handleStatesOnEvent({
    required bool isNoOp,
    Future<void> Function()? onDataSent,
  }) async {
    if (isNoOp) {
      return;
    } else if (state is SendDataReady && onDataSent != null) {
      return onDataSent();
    } else {
      throw UnimplementedError(
        'No handler implemented for combination: ${state.runtimeType}.',
      );
    }
  }

  /// Implements the code that calls the data sending function.
  ///
  /// Sent data must be returned by this function.
  @visibleForTesting
  Future<T> sendData(
    SendDataState oldState,
    DataSent event,
  );
}
