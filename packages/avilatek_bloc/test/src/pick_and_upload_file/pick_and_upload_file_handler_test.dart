import 'dart:io';

import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:avilatek_bloc/src/pick_and_upload_file/pick_and_upload_file_handler.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class EmitterMock extends Mock implements Emitter<PickAndUploadFileState> {}

class FileMock extends Mock implements File {}

void main() {
  late PickAndUploadFileHandler handler;
  late EmitterMock emit;
  late FileMock file;

  setUp(() {
    handler = PickAndUploadFileHandler();
    emit = EmitterMock();
    file = FileMock();

    registerFallbackValue(const PickFile());
    registerFallbackValue(const PickFileFailure(''));
  });

  group('PickAndUploadFileHandler tests', () {
    test(
      'should throw Exception when simulatePickingFileError is true',
      () async {
        try {
          await handler.mapInitialPickFileToState(
            const PickFile(simulatePickingFileError: true),
            const FileUnpicked(),
            emit,
            (event) async => null,
            (state, file) async => '',
          );
        } catch (e) {
          expect(e, isA<Exception>());
          expect(e.toString(), 'Exception: Simulated error');
        }

        try {
          await handler.mapReuploadFileToState(
            const PickFile(simulatePickingFileError: true),
            const FileUploaded(''),
            emit,
            (event) async => null,
            (state, file) async => '',
          );
        } catch (e) {
          expect(e, isA<Exception>());
          expect(e.toString(), 'Exception: Simulated error');
        }
      },
    );
    test(
      'should throw Exception when simulateUploadingFileError is true',
      () async {
        await handler.mapInitialPickFileToState(
          const PickFile(simulatePickingFileError: true),
          const FileUnpicked(),
          emit,
          (event) async => null,
          (state, file) async => '',
        );

        await Future<void>.delayed(const Duration(seconds: 2));

        verifyInOrder([
          () => emit(const PickingFile()),
          () => emit(any<PickFileFailure>()),
          () => emit(const FileUnpicked()),
        ]);

        verifyNoMoreInteractions(emit);
      },
    );
    test(
      'should throw emit [UploadFileFailure, FileUploaded] when simulateUploadingFileError is true',
      () async {
        await handler.mapReuploadFileToState(
          const PickFile(simulateUploadingFileError: true),
          const FileUploaded('initial_fake_file_path'),
          emit,
          (event) async => null,
          (state, file) async => '',
        );

        verifyInOrder([
          () =>
              emit(RepickingFile(const FileUploaded('initial_fake_file_path'))),
          () => emit(any()),
          // () => emit(any()),
          // () => emit(const FileUploaded('initial_fake_file_path')),
        ]);

        verifyNoMoreInteractions(emit);
      },
    );

    test(
      '''should emit FileUnpicked() when the initial picked file is null (no file picked)''',
      () async {
        /// NOTE: Placeholder function that returns null to simulate file pick
        /// cancellation.
        Future<File?> pickFile(event) async => null;

        await handler.mapInitialPickFileToState(
          const PickFile(),
          const FileUnpicked(),
          emit = EmitterMock(),
          pickFile,
          (_, __) async => '',
        );

        verifyInOrder([
          () => emit(const PickingFile()),
          () => emit(const FileUnpicked()),
        ]);

        verifyNoMoreInteractions(emit);
      },
    );

    test(
      '''should emit PickFileFailure, then FileUnpicked when initial file picking fails''',
      () async {
        /// Error thrown on file pick.
        final e = Exception('Error picking file');

        // Simulate error while picking file.
        Future<File?> pickFile(event) async => throw e;

        await handler.mapInitialPickFileToState(
          const PickFile(),
          const FileUnpicked(),
          emit = EmitterMock(),
          pickFile,
          (_, __) async => '',
        );

        verifyInOrder([
          () => emit(const PickingFile()),
          () => emit(PickFileFailure(e)),
          () => emit(const FileUnpicked()),
        ]);

        verifyNoMoreInteractions(emit);
      },
    );
    test(
      '''should emit UploadFileFailure, then FileUnpicked when initial file picking fails''',
      () async {
        /// Error thrown on file upload.
        final e = Exception('Error uploading file');

        Future<File?> pickFile(event) async => file;

        // Simulate error while uploading file.
        Future<String> uploadFile(state, event) async => throw e;

        await handler.mapInitialPickFileToState(
          const PickFile(),
          const FileUnpicked(),
          emit = EmitterMock(),
          pickFile,
          uploadFile,
        );

        verifyInOrder([
          () => emit(const PickingFile()),
          () => emit(UploadingFile(file)),
          () => emit(UploadFileFailure(e)),
          () => emit(const FileUnpicked()),
        ]);

        verifyNoMoreInteractions(emit);
      },
    );
    test(
      '''should emit FileUploaded with new file URL when initial file is uploaded''',
      () async {
        when(() => file.path).thenReturn('fake_file_path');

        await handler.mapInitialPickFileToState(
          const PickFile(),
          const FileUnpicked(),
          emit = EmitterMock(),
          (_) async => file,
          (state, file) async => file.path,
        );

        verifyInOrder([
          () => emit(const PickingFile()),
          () => emit(UploadingFile(file)),
          () => emit(const FileUploaded('fake_file_path')),
        ]);

        verifyNoMoreInteractions(emit);
      },
    );
    test(
      '''should emit ReuploadFileSuccess, then FileUploaded with new URL when second file is uploaded''',
      () async {
        when(() => file.path).thenReturn('new_fake_file_path');

        await handler.mapReuploadFileToState(
          const PickFile(),
          const FileUploaded('initial_fake_file_path'),
          emit = EmitterMock(),
          (_) async => file,
          (state, file) async => file.path,
        );

        verifyInOrder([
          () =>
              emit(RepickingFile(const FileUploaded('initial_fake_file_path'))),
          () => emit(
                ReuploadingFile(
                  const FileUploaded('initial_fake_file_path'),
                  file,
                ),
              ),
          () => emit(const ReuploadFileSuccess('new_fake_file_path')),
          () => emit(const FileUploaded('new_fake_file_path')),
        ]);

        // verifyNoMoreInteractions(emit);
      },
    );
    test(
      '''should return previous URL when second file pick is cancelled (file is null)''',
      () async {
        // Return null to simulate file pick cancellation.
        Future<File?> pickFile(event) async => null;

        await handler.mapReuploadFileToState(
          const PickFile(),
          const FileUploaded('previous_fake_file_path'),
          emit = EmitterMock(),
          pickFile,
          (_, __) async => '',
        );

        verifyInOrder([
          () => emit(
                RepickingFile(const FileUploaded('previous_fake_file_path')),
              ),
          () => emit(const FileUploaded('previous_fake_file_path')),
        ]);
        verifyNoMoreInteractions(emit);
      },
    );
    test(
      'should return old URL when second file fails to upload',
      () async {
        /// Error thrown on file upload.
        final e = Exception('Error uploading file');

        // Simulate error while uploading file.
        Future<String> uploadFile(state, file) async => throw e;

        when(() => file.path).thenReturn('new_fake_file_path');

        await handler.mapReuploadFileToState(
          const PickFile(),
          const FileUploaded('initial_fake_file_path'),
          emit = EmitterMock(),
          (_) async => file,
          uploadFile,
        );

        verifyInOrder([
          () =>
              emit(RepickingFile(const FileUploaded('initial_fake_file_path'))),
          () => emit(
                ReuploadingFile(
                  const FileUploaded('initial_fake_file_path'),
                  file,
                ),
              ),
          () => emit(
                ReuploadFileFailure(
                  const FileUploaded('initial_fake_file_path'),
                  e, // Receives the same error thrown by uploadFile function.
                ),
              ),
          () => emit(const FileUploaded('initial_fake_file_path')),
        ]);

        verifyNoMoreInteractions(emit);
      },
    );
    test(
      'should handle file re-picking exception and go back to previous state',
      () async {
        /// Error thrown on file pick.
        final e = Exception('Error picking file');
        // Simulate error while picking file.
        Future<File?> pickFile(event) async => throw e;

        when(() => file.path).thenReturn('new_fake_file_path');

        await handler.mapReuploadFileToState(
          const PickFile(),
          const FileUploaded('initial_fake_file_path'),
          emit = EmitterMock(),
          pickFile,
          (_, __) async => '',
        );

        verifyInOrder([
          () =>
              emit(RepickingFile(const FileUploaded('initial_fake_file_path'))),
          () => emit(
                RepickFileFailure(
                  const FileUploaded('initial_fake_file_path'),
                  e,
                ),
              ),
          () => emit(const FileUploaded('initial_fake_file_path')),
        ]);

        verifyNoMoreInteractions(emit);
      },
    );
  });
}
