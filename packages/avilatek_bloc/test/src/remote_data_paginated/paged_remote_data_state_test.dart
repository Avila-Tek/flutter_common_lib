import 'package:avilatek_bloc/src/remote_data_paginated/paged_remote_data_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class PagedRemoteDataNextPageFetchingFake extends Fake
    implements PagedRemoteDataNextPageFetching<void> {}

class PagedRemoteDataNextPageFetchingFailureFake extends Fake
    implements PagedRemoteDataNextPageFetchingFailure<void> {}

void main() {
  group('PagedRemoteDataState tests', () {
    test(
      '''should return correct PagedRemoteDataUninitialized boolean getter values''',
      () {
        final state = PagedRemoteDataUninitialized<void>();
        expect(state.isUnititialized, isTrue);
        expect(state.isFetchingAnyPage, isFalse);
        expect(state.isFetchingFirstPage, isFalse);
        expect(state.isFetchingFirstPageError, isFalse);
        expect(state.isFetchingNextPage, isFalse);
        expect(state.isFetchingNextPageError, isFalse);
        expect(state.isFetchingNextPageSuccess, isFalse);
        expect(state.isInitialized, isFalse);
        expect(state.isLastPageFetched, isFalse);
      },
    );
    test(
      '''should return correct PagedRemoteDataFirstPageFetchingFailure boolean getter values''',
      () {
        const state = PagedRemoteDataFirstPageFetchingFailure<void>('error');
        expect(state.isUnititialized, isTrue);
        expect(state.isFetchingAnyPage, isFalse);
        expect(state.isFetchingFirstPage, isFalse);
        expect(state.isFetchingFirstPageError, isTrue);
        expect(state.isFetchingNextPage, isFalse);
        expect(state.isFetchingNextPageError, isFalse);
        expect(state.isFetchingNextPageSuccess, isFalse);
        expect(state.isInitialized, isFalse);
        expect(state.isLastPageFetched, isFalse);
      },
    );
    test(
      '''should return correct PagedRemoteDataNextPageFetched boolean getter values''',
      () {
        const state = PagedRemoteDataNextPageFetched<void>([]);
        expect(state.isUnititialized, isFalse);
        expect(state.isFetchingAnyPage, isFalse);
        expect(state.isFetchingFirstPage, isFalse);
        expect(state.isFetchingFirstPageError, isFalse);
        expect(state.isFetchingNextPage, isFalse);
        expect(state.isFetchingNextPageError, isFalse);
        expect(state.isFetchingNextPageSuccess, isFalse);
        expect(state.isInitialized, isTrue);
        expect(state.isLastPageFetched, isFalse);
      },
    );
    test(
      '''should return correct PagedRemoteDataLastPageFetched boolean getter values''',
      () {
        const state = PagedRemoteDataLastPageFetched<void>([]);
        expect(state.isUnititialized, isFalse);
        expect(state.isFetchingAnyPage, isFalse);
        expect(state.isFetchingFirstPage, isFalse);
        expect(state.isFetchingFirstPageError, isFalse);
        expect(state.isFetchingNextPage, isFalse);
        expect(state.isFetchingNextPageError, isFalse);
        expect(state.isFetchingNextPageSuccess, isFalse);
        expect(state.isInitialized, isTrue);
        expect(state.isLastPageFetched, isTrue);
      },
    );
    test(
      '''should return correct PagedRemoteDataNextPageFetching boolean getter values''',
      () {
        final state = PagedRemoteDataNextPageFetchingFake();
        expect(state.isUnititialized, isFalse);
        expect(state.isFetchingAnyPage, isTrue);
        expect(state.isFetchingFirstPage, isFalse);
        expect(state.isFetchingFirstPageError, isFalse);
        expect(state.isFetchingNextPage, isTrue);
        expect(state.isFetchingNextPageError, isFalse);
        expect(state.isFetchingNextPageSuccess, isFalse);
        expect(state.isInitialized, isTrue);
        expect(state.isLastPageFetched, isFalse);
      },
    );
    test(
      '''should return correct PagedRemoteDataNextPageFetchingSuccess boolean getter values''',
      () {
        const state = PagedRemoteDataNextPageFetchingSuccess([1, 2, 3]);
        expect(state.isUnititialized, isFalse);
        expect(state.isFetchingAnyPage, isFalse);
        expect(state.isFetchingFirstPage, isFalse);
        expect(state.isFetchingFirstPageError, isFalse);
        expect(state.isFetchingNextPage, isFalse);
        expect(state.isFetchingNextPageError, isFalse);
        expect(state.isFetchingNextPageSuccess, isTrue);
        expect(state.isInitialized, isTrue);
        expect(state.isLastPageFetched, isFalse);
      },
    );
    test(
      '''should return correct PagedRemoteDataNextPageFetchingFailure boolean getter values''',
      () {
        final state = PagedRemoteDataNextPageFetchingFailureFake();
        expect(state.isUnititialized, isFalse);
        expect(state.isFetchingAnyPage, isFalse);
        expect(state.isFetchingFirstPage, isFalse);
        expect(state.isFetchingFirstPageError, isFalse);
        expect(state.isFetchingNextPage, isFalse);
        expect(state.isFetchingNextPageError, isTrue);
        expect(state.isFetchingNextPageSuccess, isFalse);
        expect(state.isInitialized, isTrue);
        expect(state.isLastPageFetched, isFalse);
      },
    );
    test(
      '''should return the correct properties of PagedRemoteDataNextPageFetchingFailure''',
      () {
        const oldState = PagedRemoteDataNextPageFetched([1, 2, 3]);
        expect(
          PagedRemoteDataNextPageFetchingFailure(oldState, 'Error').props,
          containsAll(
            [
              [1, 2, 3],
              'Error',
            ],
          ),
        );
      },
    );
    test(
      '''should return the correct properties of PagedRemoteDataFirstPageFetchingFailure''',
      () {
        const state = PagedRemoteDataFirstPageFetchingFailure<void>('Error');
        expect(
          state.props,
          equals(['Error']),
        );
      },
    );
    test(
      '''should return the correct properties of PagedRemoteDataNextPageFetched''',
      () {
        const state = PagedRemoteDataNextPageFetched([1, 2, 3]);
        expect(
          state.props,
          equals([
            [1, 2, 3],
          ]),
        );
      },
    );

    test(
      '''should clone previous state into PagedRemoteDataNextPageFetchingSuccess''',
      () {
        const firstState = PagedRemoteDataNextPageFetched([1, 2, 3]);
        final secondState = PagedRemoteDataNextPageFetching(firstState);

        final state = PagedRemoteDataNextPageFetchingSuccess.clone(secondState);
        expect(
          state.data,
          equals([1, 2, 3]),
        );
      },
    );
    test(
      '''should clone previous state into PagedRemoteDataLastPageFetched''',
      () {
        const oldState = PagedRemoteDataNextPageFetchingSuccess([1, 2, 3]);
        final state = PagedRemoteDataLastPageFetched.clone(oldState);
        expect(
          state.data,
          equals([1, 2, 3]),
        );
      },
    );
    test(
      '''should clone previous state into PagedRemoteDataNextPageFetched''',
      () {
        const oldState = PagedRemoteDataNextPageFetchingSuccess([1, 2, 3]);
        final state = PagedRemoteDataNextPageFetched.clone(oldState);
        expect(
          state.data,
          equals([1, 2, 3]),
        );
      },
    );
  });
}
