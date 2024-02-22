import 'dart:io';

import 'package:avilatek_bloc/src/upload_file/upload_file_handler.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'package:avilatek_bloc/src/upload_file/upload_file_event.dart';
part 'package:avilatek_bloc/src/upload_file/upload_file_state.dart';

/// {@template upload_file_bloc}
/// A [Bloc] that handles the picking and uploading of files.
/// {@endtemplate}
abstract class UploadFileBloc extends Bloc<UploadFileEvent, UploadFileState> {
  /// {@macro upload_file_bloc}
  UploadFileBloc() : super(const PickInitial()) {
    _handler = UploadFileHandler();
    on<PickFile>(_mapPickFileToState);
  }

  late UploadFileHandler _handler;

  Future<void> _mapPickFileToState(
    PickFile event,
    Emitter<UploadFileState> emit,
  ) async {
    return _handleStatesOnEvent(
      isNoOp: state is PickAndUploadFileLoading ||
          state is PickAndUploadFileSuccess ||
          state is PickAndUploadFileFailure,
      onPickInitial: () => _handler.mapInitialPickFileToState(
        event,
        state as PickInitial,
        emit,
        pickFile,
        uploadFile,
      ),
      onFileUploaded: () => _handler.mapReuploadFileToState(
        event,
        state as FileUploaded,
        emit,
        pickFile,
        uploadFile,
      ),
    );
  }

  Future<void> _handleStatesOnEvent({
    required bool isNoOp,
    Future<void> Function()? onPickInitial,
    Future<void> Function()? onFileUploaded,
  }) async {
    if (isNoOp) {
      return;
    } else if (state is PickInitial && onPickInitial != null) {
      return onPickInitial();
    } else if (state is FileUploaded && onFileUploaded != null) {
      return onFileUploaded();
    } else {
      throw UnimplementedError(
        'No handler implemented for combination: ${state.runtimeType}.',
      );
    }
  }

  /// This function handles the file picking logic. It must return a [File]
  /// object with the data of the file picked by the user, or `null` if the
  /// user cancelled the picking.
  ///
  /// When `null` is returned, the state will be set back to [PickInitial]. No
  /// failure state will be emitted.
  ///
  /// This function will be called when a [PickFile] event is added to the bloc.
  /// Do not call this function directly.
  ///
  /// Any file picking mechanism may be used, as libraries or dart:io methods.
  ///
  /// Some popular libraries to check out are:
  /// - [flutter:file_picker](https://pub.dev/packages/file_picker)
  /// - [flutter:image_picker](https://pub.dev/packages/image_picker)
  @visibleForTesting
  Future<File?> pickFile(PickFile event);

  /// **Do not call this function manually, the bloc calls it internally**
  ///
  /// Function that handles file uploading. It should return the URL of the
  /// uploaded file.
  ///
  /// This function will be called after file picking is successful. This
  /// happens when [pickFile] callback returns a non-null value
  /// (when the user picks a file and is loaded correctly).
  ///
  /// The [oldState] returns the previous state of the bloc. This can be useful,
  /// for example, to access the file that was picked in the previous state; in
  /// such case, make sure that [oldState] is of type [FileUploadedState].
  @visibleForTesting
  Future<String> uploadFile(
    UploadFileState oldState,
    File file,
  );
}
