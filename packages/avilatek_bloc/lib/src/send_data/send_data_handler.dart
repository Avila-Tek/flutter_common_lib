import 'package:avilatek_bloc/src/send_data/send_data_event.dart';
import 'package:avilatek_bloc/src/send_data/send_data_state.dart';
import 'package:bloc/bloc.dart';

///
class SendDataEventHandler<T> {
  ///
  const SendDataEventHandler();

  /// Handler for [DataSent] + [SendDataReady] combination.
  /// Handles initial fetch when the send data is not yet present.
  ///
  /// On success it emits: [SendDataLoading], [SendDataSuccess], [SendDataReady]
  /// On failure it emits: [SendDataLoading],
  /// [SendDataFailure], [SendDataReady].
  Future<void> mapDataSentToState(
    DataSent<T> event,
    SendDataReady state,
    Emitter<SendDataState> emit,
    Future<T> Function(SendDataState, DataSent<T>) sendData,
  ) async {
    try {
      emit(SendDataLoading());

      if (event.simulateError ?? false) {
        await _simulateError();
      }

      await sendData(state, event);

      emit(SendDataSuccess<T>(event.data));
      emit(SendDataReady());
    } catch (e) {
      emit(SendDataFailure(event.data, e));
      emit(SendDataReady());
    }
  }

  Future<void> _simulateError() {
    Future<void>.delayed(const Duration(seconds: 1));
    throw Exception('Simulated error');
  }
}
