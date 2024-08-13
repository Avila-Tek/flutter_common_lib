import 'dart:io';

import 'package:avilatek_bloc/src/pick_and_upload_file/pick_and_upload_file_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFile extends Mock implements File {}

class PickAndUploadFileBlocImpl extends PickAndUploadFileBloc {
  @override
  Future<File?> pickFile(PickFile event) async {
    return MockFile();
  }

  @override
  Future<String> uploadFile(PickAndUploadFileState oldState, File file) async {
    return 'mock_file_path_url';
  }
}

void main() {
  group('PickAndUploadFileBloc', () {
    late PickAndUploadFileBloc pickAndUploadFileBloc;

    setUp(() {
      pickAndUploadFileBloc = PickAndUploadFileBlocImpl();
      registerFallbackValue(const PickFile());
      registerFallbackValue(File(''));
    });

    blocTest<PickAndUploadFileBloc, PickAndUploadFileState>(
      'emits [] when nothing is added',
      build: () => pickAndUploadFileBloc,
      // ignore: inference_failure_on_collection_literal
      expect: () => [],
    );

    blocTest<PickAndUploadFileBloc, PickAndUploadFileState>(
      'emits [PickingFile, UploadingFile, FileUploaded] when PickFile is added',
      build: () => pickAndUploadFileBloc,
      act: (bloc) => bloc.add(const PickFile()),
      expect: () => [
        isA<PickingFile>(),
        isA<UploadingFile>(),
        const FileUploaded('mock_file_path_url'),
      ],
    );

    blocTest<PickAndUploadFileBloc, PickAndUploadFileState>(
      '''emits [PickFileFailure, FileUnpicked] when simulatePickingFileError is true''',
      build: () {
        return pickAndUploadFileBloc;
      },
      act: (bloc) => bloc.add(const PickFile(simulatePickingFileError: true)),
      expect: () => [
        isA<PickingFile>(),
        isA<PickFileFailure>(),
        const FileUnpicked(),
      ],
    );
    blocTest<PickAndUploadFileBloc, PickAndUploadFileState>(
      '''emits [UploadFileFailure, FileUnpicked] when simulateUploadingFileError is true''',
      build: () {
        return pickAndUploadFileBloc;
      },
      act: (bloc) => bloc.add(const PickFile(simulateUploadingFileError: true)),
      expect: () => [
        isA<PickingFile>(),
        isA<UploadingFile>(),
        isA<UploadFileFailure>(),
        const FileUnpicked(),
      ],
    );

    blocTest<PickAndUploadFileBloc, PickAndUploadFileState>(
      '''emits [RepickingFile, ReuploadingFile] when picking file from FileUploaded state''',
      build: () => pickAndUploadFileBloc,
      seed: () => const FileUploaded('first_file_path_url'),
      act: (bloc) {
        bloc.add(const PickFile());
      },
      expect: () => [
        isA<RepickingFile>(),
        isA<ReuploadingFile>(),
        isA<ReuploadFileSuccess>(),
        const FileUploaded('mock_file_path_url'),
      ],
    );

    // Add more tests for different events and expected states
  });
}
