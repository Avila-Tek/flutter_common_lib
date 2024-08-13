import 'package:avilatek_bloc/src/remote_data/remote_data_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

class UnhandledRemoteDataState<T> extends RemoteDataState<T> {}

class RemoteDataInitializedFake extends Fake
    implements RemoteDataInitialized<dynamic> {}

class RemoteDataBlocImpl extends RemoteDataBloc<int> {
  RemoteDataBlocImpl({super.initialData});

  @override
  Future<int> fetchAndParseData(
    RemoteDataState<int> oldState,
    FetchRemoteData event,
  ) async {
    if (oldState is RemoteDataInitialized) {
      return (oldState as RemoteDataInitialized<int>).data + 1;
    }

    return 1;
  }
}

void main() {
  late RemoteDataBlocImpl bloc;
  setUp(() {
    bloc = RemoteDataBlocImpl();
  });
  group(
    'RemoteDataBloc',
    () {
      blocTest<RemoteDataBloc<int>, RemoteDataState<int>>(
        '''should initialize in RemoteDataUninitialized state and emit no other states''',
        build: () => bloc,
        verify: (bloc) =>
            expect(bloc.state, isA<RemoteDataUninitialized<int>>()),
        expect: () => <RemoteDataState<int>>[],
      );
      blocTest<RemoteDataBloc<int>, RemoteDataState<int>>(
        '''should emit RemoteDataInitialFetching and RemoteDataFetched states when FetchRemoteData event is added''',
        build: () => bloc,
        act: (bloc) => bloc.add(const FetchRemoteData()),
        expect: () => [
          RemoteDataInitialFetching<int>(),
          const RemoteDataFetched<int>(1),
        ],
      );
      blocTest<RemoteDataBloc<int>, RemoteDataState<int>>(
        '''should emit RemoteDataRefetching and RemoteDataFetched states when FetchRemoteData event is added from initialized state''',
        build: () => bloc,
        seed: () => const RemoteDataFetched<int>(2),
        act: (bloc) => bloc.add(const FetchRemoteData()),
        expect: () => [
          RemoteDataRefetching<int>(const RemoteDataFetched<int>(2)),
          const RemoteDataRefetchingSuccess<int>(1),
          const RemoteDataFetched<int>(1),
        ],
      );
      blocTest<RemoteDataBloc<int>, RemoteDataState<int>>(
        '''should emit RemoteDataInitialFetching and RemoteDataInitialFetchingFailure states when initial fetch call fails''',
        build: () => bloc,
        act: (bloc) => bloc.add(const FetchRemoteData(simulateError: true)),
        expect: () {
          return [
            RemoteDataInitialFetching<int>(),
            isA<RemoteDataInitialFetchingFailure<int>>(),
            RemoteDataUninitialized<int>(),
          ];
        },
      );
      blocTest<RemoteDataBloc<int>, RemoteDataState<int>>(
        '''should emit RemoteDataRefetching and RemoteDataRefetchingFailure states when refetch call fails''',
        build: () => bloc,
        seed: () => const RemoteDataFetched<int>(2),
        act: (bloc) => bloc.add(const FetchRemoteData(simulateError: true)),
        expect: () {
          // Ensure every state is emitted with the previous state.data value
          // (2)
          return [
            RemoteDataRefetching<int>(const RemoteDataFetched<int>(2)),
            isA<RemoteDataRefetchingFailure<int>>()
                .having((state) => state.data, 'data', equals(2)),
            // Finally, the state should go back to the previous state (2)
            const RemoteDataFetched<int>(2),
          ];
        },
      );

      blocTest<RemoteDataBloc<int>, RemoteDataState<int>>(
        '''should emit incrementing values when FetchRemoteData event is added multiple times, and persists the last value when the call fails''',
        build: () => bloc,
        seed: () => const RemoteDataFetched<int>(2),
        act: (bloc) {
          bloc
            ..add(const FetchRemoteData())
            ..add(const FetchRemoteData(simulateError: true))
            ..add(const FetchRemoteData());
        },
        skip: 8,
        expect: () => [const RemoteDataFetched<int>(4)],
      );
      blocTest<RemoteDataBloc<int>, RemoteDataState<int>>(
        '''should start in RemoteDataFetched when initialData parameter is provided''',
        build: () => RemoteDataBlocImpl(initialData: 3),
        verify: (bloc) {
          expect(bloc.state, isA<RemoteDataFetched<int>>());
          expect((bloc.state as RemoteDataFetched<int>).data, 3);
        },
      );
    },
  );
}
