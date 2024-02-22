import 'dart:io';

import 'package:avilatek_bloc/src/upload_file/upload_file_bloc.dart';
import 'package:bloc/bloc.dart';

/// {@template upload_file_handler}
/// A class that handles the logic for the [UploadFileBloc].
/// {@endtemplate}
class UploadFileHandler {
  /// Handler for [PickFile] event + [PickInitial] state combination.
  /// Handles initial uploading when no file has been previously uploaded yet.
  ///
  /// On success it emits: [PickingFile], [UploadingFile], [FileUploaded].
  /// There are two possible failure states: [PickFileFailure] and
  /// [UploadFileFailure]. The first is emitted when the file picking process
  /// fails, and the second when the file uploading process fails. Both temporal
  /// states are emitted before the state is set back to [PickInitial].
  ///
  /// Set [PickFile.simulateError] to ´true´ to simulate an error.
  Future<void> mapInitialPickFileToState(
    PickFile event,
    PickInitial state,
    Emitter<UploadFileState> emit,
    Future<File?> Function(PickFile) pickFile,
    Future<String> Function(UploadFileState, File) uploadFile,
  ) async {
    File? file;

    if (event.simulateError ?? false) {
      await _simulateError();
    }

    try {
      emit(const PickingFile());

      file = await pickFile(event);

      if (file == null) {
        emit(const PickInitial());
        return;
      }
    } catch (e) {
      emit(PickFileFailure(e));
      emit(const PickInitial());
      return;
    }

    // NOTE: Should first file upload be moved to its own handler function?
    try {
      emit(UploadingFile(file));

      final url = await uploadFile(state, file);

      emit(FileUploaded(url));
    } catch (e) {
      emit(UploadFileFailure(e));
      emit(const PickInitial());
    }
  }

  /// Handler for [PickFile] event + [FileUploaded] state combination.
  ///
  /// Handles re-uploading when a file has been previously uploaded.
  /// This is useful when the user wants to change the file that has been
  /// previously uploaded.
  ///
  /// On success it emits: [RepickingFile], [ReuploadingFile],
  /// [ReuploadFileSuccess], [FileUploaded].
  ///
  /// There are two possible failure states: [PickFileFailure] and
  /// [ReuploadFileFailure]. The first is emitted when the file picking process
  /// fails, and the second when the file re-uploading process fails.
  /// Both temporal states are emitted before the state is set back to
  /// [FileUploaded].
  ///
  /// Set [PickFile.simulateError] to ´true´ to simulate an error.
  Future<void> mapReuploadFileToState(
    PickFile event,
    FileUploaded state,
    Emitter<UploadFileState> emit,
    Future<File?> Function(PickFile) pickFile,
    Future<String> Function(UploadFileState, File) uploadFile,
  ) async {
    File? file;

    if (event.simulateError ?? false) {
      await _simulateError();
    }

    try {
      emit(RepickingFile(state));

      file = await pickFile(event);

      if (file == null) {
        emit(FileUploaded.clone(state));
        return;
      }
    } catch (e) {
      emit(RepickFileFailure(state, e));
      emit(FileUploaded.clone(state));
      return;
    }

    try {
      emit(ReuploadingFile(state, file));
      final url = await uploadFile(state, file);
      emit(ReuploadFileSuccess(url));
      emit(FileUploaded(url));
    } catch (e) {
      emit(ReuploadFileFailure(state, e));
      emit(FileUploaded.clone(state));
    }
  }

  Future<void> _simulateError() {
    Future<void>.delayed(const Duration(seconds: 1));
    throw Exception('Simulated error');
  }
}
