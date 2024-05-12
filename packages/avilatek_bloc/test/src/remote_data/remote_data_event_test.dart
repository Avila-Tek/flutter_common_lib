import 'package:avilatek_bloc/src/remote_data/remote_data_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RemoteDataEvent', () {
    test(
      '''FetchRemoteData.props should return a list with all the RemoteDataEvent properties''',
      () {
        expect(const FetchRemoteData().props, containsAll([false]));
        expect(
          const FetchRemoteData(simulateError: true).props,
          containsAll([true]),
        );
      },
    );
  });
}
