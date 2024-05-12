import 'package:avilatek_bloc/src/remote_data_paginated/paged_remote_data_bloc.dart';
import 'package:avilatek_bloc/src/remote_data_paginated/paged_remote_data_handler.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class EmitterMock extends Mock
    implements Emitter<PagedRemoteDataState<dynamic>> {}

class PagedRemoteDataStateFake extends Fake
    implements PagedRemoteDataState<dynamic> {}

void main() {
  late PagedRemoteDataEventHandler<dynamic> pagedRemoteDataHandler;
  late EmitterMock emit;

  setUp(() {
    pagedRemoteDataHandler = const PagedRemoteDataEventHandler();
    emit = EmitterMock();
    registerFallbackValue(PagedRemoteDataStateFake());
  });

  group('PagedRemoteDataHandler tests', () {
    test('should emit error state when simulateError is true', () async {
      await pagedRemoteDataHandler.mapInitialFetchNextPageToState(
        const PagedRemoteDataFetchNextPage(simulateError: true),
        PagedRemoteDataUninitialized(),
        emit,
        (state, event) async => (<dynamic>[], true),
      );

      verifyInOrder([
        () => emit(PagedRemoteDataFirstPageFetching<dynamic>()),
        () => emit(
              any(
                that: isA<PagedRemoteDataFirstPageFetchingFailure<dynamic>>(),
              ),
            ),
        () => emit(PagedRemoteDataUninitialized<dynamic>()),
      ]);

      verifyNoMoreInteractions(emit);

      const initState = PagedRemoteDataNextPageFetched<dynamic>([1, 2, 3]);

      await pagedRemoteDataHandler.mapFetchNextPageRemoteDataToState(
        const PagedRemoteDataFetchNextPage(simulateError: true),
        initState,
        emit,
        (state, event) async => (<dynamic>[], true),
      );

      verifyInOrder([
        () => emit(PagedRemoteDataNextPageFetching<dynamic>(initState)),
        () => emit(
              any(
                that: isA<PagedRemoteDataNextPageFetchingFailure<dynamic>>()
                    .having((state) => state.data, 'data', equals([1, 2, 3])),
              ),
            ),
        () => emit(initState),
      ]);
      verifyNoMoreInteractions(emit);
    });

    test(
      '''should fail fethching first page and emit PagedRemoteDataFirstPageFetchingFailure''',
      () async {
        await pagedRemoteDataHandler.mapInitialFetchNextPageToState(
          const PagedRemoteDataFetchNextPage(simulateError: true),
          PagedRemoteDataUninitialized(),
          emit,
          (state, event) async => ([1, 2, 3], false),
        );

        verifyInOrder([
          () => emit(PagedRemoteDataFirstPageFetching<dynamic>()),
          () => emit(
                any(
                  that: isA<PagedRemoteDataFirstPageFetchingFailure<dynamic>>(),
                ),
              ),
          () => emit(PagedRemoteDataUninitialized()),
        ]);
        verifyNoMoreInteractions(emit);
      },
    );
    test(
      '''should fail fetching next page and emit PagedRemoteDataNextPageFetchingFailure''',
      () async {
        const initState = PagedRemoteDataNextPageFetched([1, 2, 3]);
        await pagedRemoteDataHandler.mapFetchNextPageRemoteDataToState(
          const PagedRemoteDataFetchNextPage(simulateError: true),
          initState,
          emit,
          (state, event) async => ([4, 5, 6], false),
        );

        verifyInOrder([
          () => emit(PagedRemoteDataNextPageFetching<dynamic>(initState)),
          () => emit(
                any(
                  that: isA<PagedRemoteDataNextPageFetchingFailure<dynamic>>()
                      .having((state) => state.data, 'data', equals([1, 2, 3])),
                ),
              ),
          () => emit(const PagedRemoteDataNextPageFetched([1, 2, 3])),
        ]);
        verifyNoMoreInteractions(emit);
      },
    );
    test(
      'should fetch first page and emit PagedRemoteDataFirstPageFetched',
      () async {
        await pagedRemoteDataHandler.mapInitialFetchNextPageToState(
          const PagedRemoteDataFetchNextPage(),
          PagedRemoteDataUninitialized(),
          emit,
          (state, event) async => ([1, 2, 3], false),
        );

        verifyInOrder([
          () => emit(PagedRemoteDataFirstPageFetching<dynamic>()),
          () => emit(const PagedRemoteDataNextPageFetched([1, 2, 3])),
        ]);
        verifyNoMoreInteractions(emit);
      },
    );
    test(
      'should fetch last page and emit PagedRemoteDataLastPageFetched',
      () async {
        await pagedRemoteDataHandler.mapInitialFetchNextPageToState(
          const PagedRemoteDataFetchNextPage(),
          PagedRemoteDataUninitialized(),
          emit,
          (state, event) async => ([1, 2, 3], true),
        );

        verifyInOrder([
          () => emit(PagedRemoteDataFirstPageFetching<dynamic>()),
          () => emit(const PagedRemoteDataLastPageFetched([1, 2, 3])),
        ]);
        verifyNoMoreInteractions(emit);
      },
    );
    test(
      'should fetch next pages and emit PagedRemoteDataNextPageFetched',
      () async {
        const initState = PagedRemoteDataNextPageFetched<dynamic>([1, 2, 3]);

        await pagedRemoteDataHandler.mapFetchNextPageRemoteDataToState(
          const PagedRemoteDataFetchNextPage(),
          initState,
          emit,
          (state, event) async => ([4, 5, 6], false),
        );

        verifyInOrder([
          () => emit(PagedRemoteDataNextPageFetching<dynamic>(initState)),
          () => emit(const PagedRemoteDataNextPageFetched([1, 2, 3, 4, 5, 6])),
        ]);
        verifyNoMoreInteractions(emit);
      },
    );
    test(
      'should fetch three pages and emit PagedRemoteDataLastPageFetched',
      () async {
        await pagedRemoteDataHandler.mapInitialFetchNextPageToState(
          const PagedRemoteDataFetchNextPage(),
          PagedRemoteDataUninitialized(),
          emit,
          (state, event) async => ([1, 2, 3], false),
        );
        await pagedRemoteDataHandler.mapFetchNextPageRemoteDataToState(
          const PagedRemoteDataFetchNextPage(),
          const PagedRemoteDataNextPageFetched<dynamic>([1, 2, 3]),
          emit,
          (state, event) async => ([4, 5, 6], false),
        );
        await pagedRemoteDataHandler.mapFetchNextPageRemoteDataToState(
          const PagedRemoteDataFetchNextPage(),
          const PagedRemoteDataNextPageFetched<dynamic>([1, 2, 3, 4, 5, 6]),
          emit,
          (state, event) async => ([7, 8, 9], false),
        );

        verifyInOrder([
          () => emit(PagedRemoteDataFirstPageFetching<dynamic>()),
          () => emit(const PagedRemoteDataNextPageFetched([1, 2, 3])),
          () =>
              emit(any(that: isA<PagedRemoteDataNextPageFetching<dynamic>>())),
          () => emit(const PagedRemoteDataNextPageFetched([1, 2, 3, 4, 5, 6])),
          () =>
              emit(any(that: isA<PagedRemoteDataNextPageFetching<dynamic>>())),
          () => emit(
                const PagedRemoteDataNextPageFetched(
                  [1, 2, 3, 4, 5, 6, 7, 8, 9],
                ),
              ),
        ]);
        verifyNoMoreInteractions(emit);
      },
    );
  });
}
