part of 'upload_file_bloc.dart';

/// {@template upload_file_state_x}
/// Extension on [UploadFileState] to provide helper methods to check the type
/// of the state.
/// {@endtemplate}
extension UploadFileStateX on UploadFileState {
  /// Returns `true` if the state is [PickingFile] or [RepickingFile].
  bool get isPickingFile => this is PickingFile || this is RepickingFile;

  /// Returns `true` if the state is [UploadingFile] or [ReuploadingFile].
  bool get isUploadingFile => this is UploadingFile || this is ReuploadingFile;

  /// Returns `true` if the state is [PickInitial] or
  /// [PickingFile] or [UploadingFile]. This means that a file no file has been
  /// uploaded yet.
  bool get hasNotUploadedFile =>
      this is PickInitial || this is PickingFile || this is UploadingFile;

  /// Returns `true` if the state is [FileUploadedState], meaning that a file
  /// has been picked and uploaded.
  bool get hasFileUploaded => this is FileUploadedState;

  /// Returns `true` if the state is [UploadFileSuccess] or
  /// [ReuploadFileSuccess].
  bool get hasUploadedFileSuccessfully =>
      this is UploadFileSuccess || this is ReuploadFileSuccess;

  /// Returns `true` if the state is [UploadFileFailure] or
  /// [ReuploadFileFailure].
  bool get hasFailedToUploadFile =>
      this is UploadFileFailure || this is ReuploadFileFailure;
}

/// {@template upload_file_state}
/// Base class for all states of the [UploadFileBloc].
/// {@endtemplate}
abstract class UploadFileState extends Equatable {
  /// {@macro upload_file_state}
  const UploadFileState();

  @override
  List<Object?> get props => [];
}

/// Mixin for every [UploadFileState] that represents asynchronous activity.
mixin PickAndUploadFileLoading on UploadFileState {}

/// Mixin for every [UploadFileState] that represents a temporary success.
mixin PickAndUploadFileSuccess on UploadFileState {}

/// Mixin for every [UploadFileState] that represents a temporary error.
mixin PickAndUploadFileFailure on UploadFileState {}

// #####################
// Not uploaded file states
// #####################

/// {@template pick_initial}
/// Initial state of the [UploadFileBloc].
/// This represents a state when a file has not been picked or uploaded.
/// {@endtemplate}
class PickInitial extends UploadFileState {
  /// {@macro pick_initial}
  const PickInitial();
}

/// {@template picking_file}
/// This state is emitted when the asynchronous task of file picking is in
/// progress.
/// {@endtemplate}
class PickingFile extends UploadFileState with PickAndUploadFileLoading {
  /// {@macro picking_file}
  const PickingFile();
}

/// {@template picking_file_failure}
/// This state is emitted when the file picking process has failed.
/// {@endtemplate}
class PickFileFailure extends UploadFileState with PickAndUploadFileFailure {
  /// {@macro picking_file_failure}
  const PickFileFailure(this.error);

  /// The error that caused the file picking to fail.
  final dynamic error;

  @override
  List<Object?> get props => [...super.props, error];
}

/// {@template uploading_file}
/// This state is emitted when file uploading is in progress.
/// {@endtemplate}
class UploadingFile extends UploadFileState with PickAndUploadFileLoading {
  /// {@macro uploading_file}
  const UploadingFile(this.file);

  /// The file that is being uploaded.
  final File file;

  @override
  List<Object?> get props => [...super.props, file];
}

/// {@template uploading_file_success}
/// This state is emitted when the file has been successfully uploaded.
/// {@endtemplate}
class UploadFileSuccess extends UploadFileState with PickAndUploadFileSuccess {
  /// {@macro uploading_file_success}
  const UploadFileSuccess();
}

/// {@template uploading_file_failure}
/// This state is emitted when the file uploading process has failed.
/// {@endtemplate}
class UploadFileFailure extends UploadFileState with PickAndUploadFileFailure {
  /// {@macro uploading_file_failure}
  const UploadFileFailure(this.error);

  /// The error that caused the file uploading to fail.
  final dynamic error;

  @override
  List<Object?> get props => [...super.props, error];
}

// #####################
// Uploaded file states
// #####################

/// {@template file_uploaded_initialized}
/// Base class for states of the [UploadFileBloc] that represent a file that has
/// already been picked and uploaded. The last uploaded file will be available
/// in the [fileUrl] property of all subclasses.
/// {@endtemplate}
abstract class FileUploadedState extends UploadFileState {
  /// {@macro file_uploaded_initialized}
  const FileUploadedState(this.fileUrl);

  /// {@template remote_data_initialized.clone}
  /// Creates a copy of the current state with the old state's file.
  /// {@endtemplate}
  FileUploadedState.clone(FileUploadedState other) : this(other.fileUrl);

  /// The file that has been picked and uploaded.
  final String fileUrl;

  @override
  List<Object?> get props => [...super.props, fileUrl];
}

/// {@template file_uploaded}
/// State that represents a file that has been picked and uploaded.
/// {@endtemplate}
class FileUploaded extends FileUploadedState {
  /// {@macro file_uploaded}
  const FileUploaded(super.fileUrl);

  /// {@template remote_data_initialized.clone}
  FileUploaded.clone(super.oldState) : super.clone();
}

/// {@template repicking_file}
/// State that represents the picking of a new file having already uploaded a
/// file.
/// {@endtemplate}
class RepickingFile extends FileUploadedState with PickAndUploadFileLoading {
  /// {@macro repicking_file}
  RepickingFile(super.oldState) : super.clone();
}

/// {@template repicking_file_failure}
/// State that represents the failure of the picking of a new file having
/// already uploaded a file.
/// {@endtemplate}
class RepickFileFailure extends FileUploadedState
    with PickAndUploadFileFailure {
  /// {@macro repicking_file_failure}
  RepickFileFailure(super.oldState, this.error) : super.clone();

  /// The error that caused the file picking to fail.
  final dynamic error;

  @override
  List<Object?> get props => [...super.props, error];
}

/// {@template reuploading_file}
/// State that represents the uploading of a new file having already uploaded
/// one.
/// {@endtemplate}
class ReuploadingFile extends FileUploadedState with PickAndUploadFileLoading {
  /// {@macro reuploading_file}
  ReuploadingFile(super.oldState, this.newFile) : super.clone();

  /// The new file that is being uploaded.
  final File newFile;
}

/// {@template reuploading_file_success}
/// State that represents the successful uploading of a new file having already
/// uploaded one.
/// {@endtemplate}
class ReuploadFileSuccess extends FileUploadedState
    with PickAndUploadFileSuccess {
  /// {@macro reuploading_file_success}
  const ReuploadFileSuccess(super.fileUrl);

  /// {@template remote_data_initialized.clone}
  ReuploadFileSuccess.clone(super.oldState) : super.clone();
}

/// {@template reuploading_file_failure}
/// State that represents the failure of the uploading of a new file having
/// already uploaded one.
/// {@endtemplate}
class ReuploadFileFailure extends FileUploadedState
    with PickAndUploadFileFailure {
  /// {@macro reuploading_file_failure}
  ReuploadFileFailure(super.oldState, this.error) : super.clone();

  /// The error that caused the file uploading to fail.
  final dynamic error;

  @override
  List<Object?> get props => [...super.props, error];
}
