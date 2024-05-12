import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'SendDataEvent tests',
    () {
      test(
        'should return correct properties for DataSent event',
        () async {
          expect(const DataSent(1).props, containsAll([1, false]));
          expect(
            const DataSent(1, simulateError: true).props,
            containsAll([1, true]),
          );
        },
      );
    },
  );
}
