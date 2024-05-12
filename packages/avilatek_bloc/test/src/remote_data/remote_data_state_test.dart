import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'remote_data_handler_test.dart';

void main() {
  test(
    'should return correct RemoteDataUninitialized boolean getter values',
    () async {
      final state = RemoteDataUninitialized<void>();
      expect(state.isUnititialized, isTrue);
      expect(state.isFetching, isFalse);
      expect(state.isInitialFetching, isFalse);
      expect(state.isInitialized, isFalse);
      expect(state.isRefetching, isFalse);
    },
  );
  test(
    'should return correct RemoteDataInitialFetching boolean getter values',
    () async {
      final state = RemoteDataInitialFetching<void>();
      expect(state.isUnititialized, isTrue);
      expect(state.isFetching, isTrue);
      expect(state.isInitialFetching, isTrue);
      expect(state.isInitialized, isFalse);
      expect(state.isRefetching, isFalse);
    },
  );

  test(
    'should return correct RemoteDataRefetching boolean getter values',
    () async {
      final state = RemoteDataRefetching<void>(RemoteDataFetchedFake());
      expect(state.isUnititialized, isFalse);
      expect(state.isFetching, isTrue);
      expect(state.isInitialFetching, isFalse);
      expect(state.isInitialized, isTrue);
      expect(state.isRefetching, isTrue);
    },
  );
  test(
    'should return correct RemoteDataInitialFetchingFailure boolean getter values',
    () async {
      const state = RemoteDataInitialFetchingFailure<void>('');
      expect(state.isUnititialized, isTrue);
      expect(state.isFetching, isFalse);
      expect(state.isInitialFetching, isFalse);
      expect(state.isInitialized, isFalse);
      expect(state.isRefetching, isFalse);
    },
  );
  test(
    'should return correct RemoteDataRefetchingFailure boolean getter values',
    () async {
      final state = RemoteDataRefetchingFailure(RemoteDataFetchedFake(), '');
      expect(state.isUnititialized, isFalse);
      expect(state.isFetching, isFalse);
      expect(state.isInitialFetching, isFalse);
      expect(state.isInitialized, isTrue);
      expect(state.isRefetching, isFalse);
    },
  );
  test(
    'should return correct RemoteDataFetched boolean getter values',
    () async {
      const state = RemoteDataFetched('');
      expect(state.isUnititialized, isFalse);
      expect(state.isFetching, isFalse);
      expect(state.isInitialFetching, isFalse);
      expect(state.isInitialized, isTrue);
      expect(state.isRefetching, isFalse);
    },
  );
  test(
    'should return correct RemoteDataRefetchingSuccess boolean getter values',
    () async {
      const state = RemoteDataRefetchingSuccess('');
      expect(state.isUnititialized, isFalse);
      expect(state.isFetching, isFalse);
      expect(state.isInitialFetching, isFalse);
      expect(state.isInitialized, isTrue);
      expect(state.isRefetching, isFalse);
    },
  );
}
