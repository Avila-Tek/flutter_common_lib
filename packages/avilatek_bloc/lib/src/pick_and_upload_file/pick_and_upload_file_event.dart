part of 'pick_and_upload_file_bloc.dart';

/// {@template upload_file_event}
/// Abstract class that represents the events that can be dispatched to the
/// [PickAndUploadFileBloc].
/// {@endtemplate}
abstract class PickAndUploadFileEvent extends Equatable {
  /// {@macro upload_file_event}
  const PickAndUploadFileEvent();
}

/// {@template pick_file}
/// Event that triggers the file picking and uploading.
/// {@endtemplate}
class PickFile extends PickAndUploadFileEvent {
  /// {@macro pick_file}
  const PickFile({
    this.simulatePickingFileError = false,
    this.simulateUploadingFileError = false,
  });

  /// If true, the [PickAndUploadFileBloc] will simulate an error on picking
  /// and emit [PickFileFailure].
  final bool? simulatePickingFileError;

  /// If true, the [PickAndUploadFileBloc] will simulate an error on upload
  /// and emit [UploadFileFailure].
  final bool? simulateUploadingFileError;

  @override
  List<Object?> get props =>
      [simulatePickingFileError, simulateUploadingFileError];
}
