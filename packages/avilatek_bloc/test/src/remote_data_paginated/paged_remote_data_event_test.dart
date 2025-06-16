import 'package:avilatek_bloc/src/remote_data_paginated/paged_remote_data_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PagedRemoteDataEvent tests', () {
    test(
      'should return the correct properties of PagedRemoteDataFetchNextPage',
      () {
        expect(
          const PagedRemoteDataFetchNextPage().props,
          containsAll([false]),
        );
        expect(
          const PagedRemoteDataFetchNextPage(simulateError: true).props,
          containsAll([true]),
        );
      },
    );
    test(
      'should return the correct properties of PagedRemoteDataRestart',
      () {
        expect(
          const PagedRemoteDataRestarted().props,
          containsAll([false]),
        );
        expect(
          const PagedRemoteDataRestarted(simulateError: true).props,
          containsAll([true]),
        );
      },
    );
  });
}
