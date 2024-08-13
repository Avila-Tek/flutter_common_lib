import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:avilatek_bloc/src/send_data/send_data_handler.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class EmitterMock extends Mock implements Emitter<SendDataState> {}

class SendDataStateFake extends Fake implements SendDataState {}

void main() {
  late EmitterMock emit;
  late SendDataEventHandler<dynamic> handler;

  setUp(() {
    emit = EmitterMock();
    handler = const SendDataEventHandler();
    registerFallbackValue(SendDataStateFake());
  });

  group('SendDataEventHandler tests', () {
    test('should emit error state when simulateError is true', () async {
      await handler.mapDataSentToState(
        const DataSent(1, simulateError: true),
        SendDataReady(),
        emit,
        (state, event) async => null,
      );

      verifyInOrder([
        () => emit(SendDataLoading()),
        () => emit(
              any(
                that: isA<SendDataFailure<dynamic>>()
                    .having((state) => state.data, 'data', equals(1)),
              ),
            ),
        () => emit(SendDataReady()),
      ]);
      verifyNoMoreInteractions(emit);
    });
    test('should emit error state when the petition fails', () async {
      await handler.mapDataSentToState(
        const DataSent(1),
        SendDataReady(),
        emit,
        (state, event) async => throw Exception(), // Simulate error on petition
      );

      verifyInOrder([
        () => emit(SendDataLoading()),
        () => emit(
              any(
                that: isA<SendDataFailure<dynamic>>()
                    .having((state) => state.data, 'data', equals(1)),
              ),
            ),
        () => emit(SendDataReady()),
      ]);
      verifyNoMoreInteractions(emit);
    });

    test('should emit success state when the petition is successful', () async {
      await handler.mapDataSentToState(
        const DataSent(1),
        SendDataReady(),
        emit,
        (state, event) async => null,
      );

      verifyInOrder([
        () => emit(SendDataLoading()),
        () => emit(
              any(
                that: isA<SendDataSuccess<dynamic>>()
                    .having((state) => state.data, 'data', equals(1)),
              ),
            ),
        () => emit(SendDataReady()),
      ]);
      verifyNoMoreInteractions(emit);
    });
  });
}
