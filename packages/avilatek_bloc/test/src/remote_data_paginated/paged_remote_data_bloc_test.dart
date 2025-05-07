import 'package:avilatek_bloc/src/remote_data_paginated/paged_remote_data_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class PagedRemoteDataBlocImpl extends PagedRemoteDataBloc<int> {
  @override
  Future<(List<int>, bool)> fetchAndParseNextPage(
    PagedRemoteDataState<int> oldState,
    PagedRemoteDataFetchNextPage event,
  ) async {
    if (oldState is PagedRemoteDataInitialized &&
        (oldState as PagedRemoteDataInitialized).data.length > 5) {
      return ([1, 2, 3], true);
    }
    return ([1, 2, 3], false);
  }
}

class PagedRemoteDataStateFake extends Fake
    implements PagedRemoteDataState<int> {}

void main() {
  late PagedRemoteDataBlocImpl bloc;
  setUp(() {
    bloc = PagedRemoteDataBlocImpl();
    registerFallbackValue(PagedRemoteDataStateFake());
    registerFallbackValue(const PagedRemoteDataFetchNextPage());
  });
  group('PagedRemoteDataBloc tests', () {
    blocTest<PagedRemoteDataBlocImpl, PagedRemoteDataState<int>>(
      'should emit failure state when simulateError is true',
      build: () => bloc,
      act: (bloc) =>
          bloc.add(const PagedRemoteDataFetchNextPage(simulateError: true)),
      expect: () => [
        isA<PagedRemoteDataFirstPageFetching<int>>(),
        isA<PagedRemoteDataFirstPageFetchingFailure<int>>(),
        isA<PagedRemoteDataUninitialized<int>>(),
      ],
    );
    blocTest<PagedRemoteDataBlocImpl, PagedRemoteDataState<int>>(
      'should load first page and emit PagedRemoteDataNextPageFetched',
      build: () => bloc,
      act: (bloc) => bloc.add(const PagedRemoteDataFetchNextPage()),
      expect: () => [
        PagedRemoteDataFirstPageFetching<int>(),
        const PagedRemoteDataNextPageFetched<int>([1, 2, 3]),
      ],
    );
    blocTest<PagedRemoteDataBlocImpl, PagedRemoteDataState<int>>(
      '''should load two pages and emit PagedRemoteDataNextPageFetched with all accumulated data''',
      build: () => bloc,
      act: (bloc) {
        bloc
          ..add(const PagedRemoteDataFetchNextPage())
          ..add(const PagedRemoteDataFetchNextPage());
      },
      expect: () => [
        PagedRemoteDataFirstPageFetching<int>(),
        const PagedRemoteDataNextPageFetched<int>([1, 2, 3]),
        PagedRemoteDataNextPageFetching<int>(
          const PagedRemoteDataNextPageFetched<int>([1, 2, 3]),
        ),
        const PagedRemoteDataNextPageFetched<int>([1, 2, 3, 1, 2, 3]),
      ],
    );
    blocTest<PagedRemoteDataBlocImpl, PagedRemoteDataState<int>>(
      '''should load all three pages and emit PagedRemoteDataLastPageFetched''',
      build: () => bloc,
      act: (bloc) {
        bloc
          ..add(const PagedRemoteDataFetchNextPage())
          ..add(const PagedRemoteDataFetchNextPage())
          ..add(const PagedRemoteDataFetchNextPage());
      },
      expect: () => [
        PagedRemoteDataFirstPageFetching<int>(),
        const PagedRemoteDataNextPageFetched<int>([1, 2, 3]),
        PagedRemoteDataNextPageFetching<int>(
          const PagedRemoteDataNextPageFetched<int>([1, 2, 3]),
        ),
        const PagedRemoteDataNextPageFetched<int>([1, 2, 3, 1, 2, 3]),
        PagedRemoteDataNextPageFetching<int>(
          const PagedRemoteDataNextPageFetched<int>([1, 2, 3, 1, 2, 3]),
        ),
        const PagedRemoteDataLastPageFetched<int>([1, 2, 3, 1, 2, 3, 1, 2, 3]),
      ],
    );
    blocTest<PagedRemoteDataBlocImpl, PagedRemoteDataState<int>>(
      '''should emit no more states when PagedRemoteDataFetchNextPage is added on PagedRemoteDataLastPageFetched state''',
      build: () => bloc,
      seed: () => const PagedRemoteDataLastPageFetched<int>([1, 2, 3]),
      act: (bloc) => bloc.add(const PagedRemoteDataFetchNextPage()),
      expect: () => <dynamic>[],
    );
    blocTest<PagedRemoteDataBlocImpl, PagedRemoteDataState<int>>(
      '''should restart the bloc and emit PagedRemoteDataFirstPageFetching when PagedRemoteDataRestart is added''',
      build: () => bloc,
      seed: () => const PagedRemoteDataLastPageFetched<int>([1, 2, 3]),
      act: (bloc) => bloc.add(const PagedRemoteDataRestarted()),
      expect: () => <dynamic>[
        PagedRemoteDataUninitialized<int>(),
        PagedRemoteDataFirstPageFetching<int>(),
        const PagedRemoteDataNextPageFetched<int>([1, 2, 3]),
      ],
    );
  });
}
