import 'dart:io';

import 'package:avilatek_bloc/src/pick_and_upload_file/src/pick_and_upload_file_handler.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'package:avilatek_bloc/src/pick_and_upload_file/src/pick_and_upload_file_event.dart';
part 'package:avilatek_bloc/src/pick_and_upload_file/src/pick_and_upload_file_state.dart';

/// {@template upload_file_bloc}
/// A [Bloc] that handles the picking and uploading of files.
/// {@endtemplate}
abstract class PickAndUploadFileBloc
    extends Bloc<PickAndUploadFileEvent, PickAndUploadFileState> {
  /// {@macro upload_file_bloc}
  PickAndUploadFileBloc() : super(const FileUnpicked()) {
    _handler = PickAndUploadFileHandler();
    on<PickFile>(_mapPickFileToState);
  }

  late PickAndUploadFileHandler _handler;

  Future<void> _mapPickFileToState(
    PickFile event,
    Emitter<PickAndUploadFileState> emit,
  ) async {
    return _handleStatesOnEvent(
      isNoOp: state is PickFileLoadingMixin ||
          state is PickFileFailureMixin ||
          state is UploadFileLoadingMixin ||
          state is UploadFileSuccessMixin ||
          state is UploadFileFailureMixin,
      onPickInitial: () => _handler.mapInitialPickFileToState(
        event,
        state as FileUnpicked,
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
    } else if (state is FileUnpicked && onPickInitial != null) {
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
  /// When `null` is returned, the state will be set back to [FileUnpicked]. No
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
  /// such case, make sure that [oldState] is of type [UploadedState].
  @visibleForTesting
  Future<String> uploadFile(
    PickAndUploadFileState oldState,
    File file,
  );
}
