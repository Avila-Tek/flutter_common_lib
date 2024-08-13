import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SendDataState', () {
    test(
      'should return correct SendDataReady boolean getter values',
      () async {
        final state = SendDataReady();
        expect(state.isReady, isTrue);
        expect(state.isLoading, isFalse);
        expect(state.isFailure, isFalse);
        expect(state.isSuccess, isFalse);
      },
    );
    test(
      'should return correct SendDataLoading boolean getter values',
      () async {
        final state = SendDataLoading();
        expect(state.isReady, isFalse);
        expect(state.isLoading, isTrue);
        expect(state.isFailure, isFalse);
        expect(state.isSuccess, isFalse);
      },
    );
    test(
      'should return correct SendDataFailure boolean getter values',
      () async {
        const state = SendDataFailure<int>(0, '');
        expect(state.isReady, isFalse);
        expect(state.isLoading, isFalse);
        expect(state.isFailure, isTrue);
        expect(state.isSuccess, isFalse);
      },
    );
    test(
      'should return correct SendDataSuccess boolean getter values',
      () async {
        const state = SendDataSuccess<int>(0);
        expect(state.isReady, isFalse);
        expect(state.isLoading, isFalse);
        expect(state.isFailure, isFalse);
        expect(state.isSuccess, isTrue);
      },
    );
    test(
      'should return correct properties for SendDataFailure',
      () async {
        const state = SendDataFailure<int>(1, 'Error');
        expect(state.props, containsAll([1, 'Error']));
      },
    );
    test(
      'should return correct properties for SendDataSuccess',
      () async {
        const state = SendDataSuccess<int>(1);
        expect(state.props, containsAll([1]));
      },
    );
  });
}
