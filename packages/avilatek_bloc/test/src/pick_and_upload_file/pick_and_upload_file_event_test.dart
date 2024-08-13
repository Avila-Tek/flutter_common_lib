import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PickAndUploadFileEvent', () {
    test('should return a list with all the PickAndUploadFileEvent properties',
        () {
      expect(const PickFile().props, [false, false]);
      expect(
        const PickFile(simulateUploadingFileError: true).props,
        <Object>[false, true],
      );
      expect(
        const PickFile(simulatePickingFileError: true).props,
        <Object>[true, false],
      );
      expect(
        const PickFile(
          simulatePickingFileError: true,
          simulateUploadingFileError: true,
        ).props,
        <Object>[true, true],
      );
    });
  });
}
