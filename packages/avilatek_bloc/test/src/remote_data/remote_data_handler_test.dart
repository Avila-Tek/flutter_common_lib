// ignore_for_file: strict_raw_type, inference_failure_on_instance_creation, must_be_immutable

import 'package:avilatek_bloc/src/remote_data/remote_data_bloc.dart';
import 'package:avilatek_bloc/src/remote_data/remote_data_handler.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class EmitterMock extends Mock implements Emitter<RemoteDataState<dynamic>> {}

class RemoteDataStateFake extends Fake implements RemoteDataState {}

class RemoteDataFetchedFake extends Fake implements RemoteDataFetched {
  @override
  dynamic data = Object();
}

void main() async {
  late RemoteDataEventHandler<dynamic> handler;
  late EmitterMock emit;

  setUp(() {
    handler = const RemoteDataEventHandler();
    emit = EmitterMock();
    registerFallbackValue(RemoteDataStateFake());
    registerFallbackValue(RemoteDataFetchedFake());
  });
  group('RemoteDataEventHandler tests', () {
    test(
      '''should emit failure state, then go back to uninitialized state when simulateError is true on initial fetch''',
      () async {
        await handler.mapInitialFetchRemoteDataToState(
          const FetchRemoteData(simulateError: true),
          RemoteDataUninitialized(),
          emit,
          (state, event) async => Object(),
        );

        verifyInOrder([
          () => emit(RemoteDataInitialFetching()),
          () => emit(
                any<RemoteDataStateFake>(
                  that: isA<RemoteDataInitialFetchingFailure>(),
                ),
              ),
          () => emit(RemoteDataUninitialized()),
        ]);
        verifyNoMoreInteractions(emit);
      },
    );
    test(
      '''should emit failure state, then go back to fetched state when simulateError is true on refetch''',
      () async {
        await handler.mapRefetchRemoteDataToState(
          const FetchRemoteData(simulateError: true),
          RemoteDataFetchedFake(),
          emit,
          (state, event) async => Object(),
        );

        verifyInOrder([
          () => emit(
                any<RemoteDataStateFake>(
                  that: isA<RemoteDataRefetching>(),
                ),
              ),
          () => emit(
                any<RemoteDataStateFake>(
                  that: isA<RemoteDataRefetchingFailure>(),
                ),
              ),
          () => emit(
                any<RemoteDataStateFake>(that: isA<RemoteDataFetched>()),
              ),
        ]);
        verifyNoMoreInteractions(emit);
      },
    );
    test(
      '''should emit failure state, then go back to uninitialized state when initial fetch call fails''',
      () async {
        await handler.mapInitialFetchRemoteDataToState(
          const FetchRemoteData(),
          RemoteDataUninitialized(),
          emit,
          (state, event) async => throw Exception(), // Simulate error on fetch
        );

        verifyInOrder([
          () => emit(RemoteDataInitialFetching()),
          () => emit(
                any<RemoteDataStateFake>(
                  that: isA<RemoteDataInitialFetchingFailure>(),
                ),
              ),
          () => emit(RemoteDataUninitialized()),
        ]);
        verifyNoMoreInteractions(emit);
      },
    );
    test(
      '''should emit failure state, then go back to fetched state when refetching call fails''',
      () async {
        await handler.mapRefetchRemoteDataToState(
          const FetchRemoteData(),
          RemoteDataFetchedFake(),
          emit,
          (state, event) async => throw Exception(), // Simulate error on fetch
        );

        verifyInOrder([
          () => emit(
                any<RemoteDataStateFake>(
                  that: isA<RemoteDataRefetching>(),
                ),
              ),
          () => emit(
                any<RemoteDataStateFake>(
                  that: isA<RemoteDataRefetchingFailure>(),
                ),
              ),
          () => emit(
                any<RemoteDataStateFake>(that: isA<RemoteDataFetched>()),
              ),
        ]);
        verifyNoMoreInteractions(emit);
      },
    );
    test(
      '''should emit success state with data when initial fetch is successful''',
      () async {
        await handler.mapInitialFetchRemoteDataToState(
          const FetchRemoteData(),
          RemoteDataUninitialized(),
          emit,
          (state, event) async => 1, // Mock data
        );

        verifyInOrder([
          () => emit(RemoteDataInitialFetching()),
          () => emit(const RemoteDataFetched(1)),
        ]);

        verifyNoMoreInteractions(emit);
      },
    );
    test(
      '''should emit success state with data when refetching is successful''',
      () async {
        final initState = RemoteDataFetchedFake();
        await handler.mapRefetchRemoteDataToState(
          const FetchRemoteData(),
          initState,
          emit,
          (state, event) async => 1, // Mock data
        );

        verifyInOrder([
          () => emit(RemoteDataRefetching(initState)),
          () => emit(const RemoteDataRefetchingSuccess(1)),
          () => emit(const RemoteDataFetched(1)),
        ]);

        verifyNoMoreInteractions(emit);
      },
    );
  });
}
