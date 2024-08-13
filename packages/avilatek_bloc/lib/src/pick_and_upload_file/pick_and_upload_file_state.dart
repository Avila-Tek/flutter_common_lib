part of 'pick_and_upload_file_bloc.dart';

/// {@template upload_file_state_x}
/// Extension on [PickAndUploadFileState] to provide helper methods to check
/// the type of the state.
/// {@endtemplate}
extension PickAndUploadFileStateX on PickAndUploadFileState {
  /// Returns `true` if the state is in the logical area of `UnuploadedState`,
  /// meaning that no file has been uploaded yet.
  bool get hasNoFileUploaded => this is UnuploadedState;

  /// Checks if the current state is reuploading a file.
  /// Returns `true` if the state is in the logical area of `UploadedState`,
  /// meaning that a file has been uploaded.
  bool get hasFileUploaded => this is UploadedState;

  /// Returns `true` if the state is [PickingFile] or [RepickingFile].
  bool get isPickingFile => this is PickFileLoadingMixin;

  /// Returns `true` if the state is [RepickingFile].
  /// This can be useful in scenarios where you need to distinguish between the
  /// initial pick and a repick. For example, you might want to continue
  /// displaying the previously picked file to the user while a new file is
  /// being picked.
  bool get isRepickingFile => this is RepickingFile;

  /// Returns `true` if the state is uploading or reuploading a file.
  bool get isUploadingFile => this is UploadFileLoadingMixin;

  /// Returns `true` if the state is uploading the first file.
  bool get isUploadingFirstFile =>
      this is UnuploadedState && this is UploadFileLoadingMixin;

  /// This getter returns `true` if the state is in the process of reuploading
  /// a file. It can be useful in scenarios where you need to distinguish
  /// between the initial upload and a reupload. For example, you might want to
  /// continue displaying the previously uploaded file to the user while a new
  /// file is being reuploaded.
  bool get isReuploadingFile => this is ReuploadingFile;

  /// Returns `true` when the file has been successfully uploaded or reuploaded.
  bool get isUploadedFileSuccessfully => this is UploadFileSuccessMixin;

  /// Returns `true` when the file has failed to be uploaded or reuploaded.
  bool get isFailedToUploadFile => this is UploadFileFailureMixin;

  /// Returns `true` when the file picking process has failed, either if is the
  /// initial pick or a repick.
  bool get isFailedToPickFile => this is PickFileFailureMixin;
}

/// {@template upload_file_state}
/// Base class for all states of the [PickAndUploadFileBloc].
/// {@endtemplate}
abstract class PickAndUploadFileState extends Equatable {
  /// {@macro upload_file_state}
  const PickAndUploadFileState();

  @override
  List<Object?> get props => [];
}

/// Mixin for every [PickAndUploadFileState] that represents an asynchronous
/// picking process. The states are [PickingFile] and [RepickingFile].
mixin PickFileLoadingMixin on PickAndUploadFileState {}

/// Mixin for every [PickAndUploadFileState] that represents a temporary error
/// on file picking. The states are [PickFileFailure] and [RepickFileFailure].
mixin PickFileFailureMixin on PickAndUploadFileState {}

/// Mixin for every [PickAndUploadFileState] that represents an asynchronous
/// uploading process. The states are [UploadingFile] and [ReuploadingFile].
mixin UploadFileLoadingMixin on PickAndUploadFileState {}

/// Mixin for every [PickAndUploadFileState] that represents a temporary
/// success on file uploading. The states are [UploadFileSuccess] and
/// [ReuploadFileSuccess].
mixin UploadFileSuccessMixin on PickAndUploadFileState {}

/// Mixin for every [PickAndUploadFileState] that represents a temporary error
/// on file uploading. The states are [UploadFileFailure] and
/// [ReuploadFileFailure].
mixin UploadFileFailureMixin on PickAndUploadFileState {}

// #####################
// Unuploaded file states
// #####################

/// {@template unuploaded_state}
/// Base class for logic state of the [PickAndUploadFileBloc] when a file has
/// not been uploaded yet. All subclasses of this class represents a state when
/// the first file has not been uploaded yet.
/// {@endtemplate}
abstract class UnuploadedState extends PickAndUploadFileState {
  /// {@macro unuploaded_state}
  const UnuploadedState();
}

/// {@template pick_initial}
/// Initial state of the [PickAndUploadFileBloc].
/// This represents a state when a file has not been picked
/// {@endtemplate}
class FileUnpicked extends UnuploadedState {
  /// {@macro pick_initial}
  const FileUnpicked();
}

/// {@template picking_file}
/// This state is emitted when the asynchronous task of file picking is in
/// progress.
/// {@endtemplate}
class PickingFile extends UnuploadedState with PickFileLoadingMixin {
  /// {@macro picking_file}
  const PickingFile();
}

/// {@template picking_file_failure}
/// This state is emitted when the file picking process has failed.
/// {@endtemplate}
class PickFileFailure extends UnuploadedState with PickFileFailureMixin {
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
class UploadingFile extends UnuploadedState with UploadFileLoadingMixin {
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
class UploadFileSuccess extends UnuploadedState with UploadFileSuccessMixin {
  /// {@macro uploading_file_success}
  const UploadFileSuccess();
}

/// {@template uploading_file_failure}
/// This state is emitted when the file uploading process has failed.
/// {@endtemplate}
class UploadFileFailure extends UnuploadedState with UploadFileFailureMixin {
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
/// Base class for logic states of the [PickAndUploadFileBloc] when a file has
/// been uploaded. All subclasses of this class will have the [fileUrl]
/// property of the previously uploaded file.
/// {@endtemplate}
abstract class UploadedState extends PickAndUploadFileState {
  /// {@macro file_uploaded_initialized}
  const UploadedState(this.fileUrl);

  /// {@template remote_data_initialized.clone}
  /// Creates a copy of the current state with the old state's file.
  /// {@endtemplate}
  UploadedState.clone(UploadedState other) : this(other.fileUrl);

  /// The file that has been picked and uploaded.
  final String fileUrl;

  @override
  List<Object?> get props => [...super.props, fileUrl];
}

/// {@template file_uploaded}
/// State that represents a file that has been picked and uploaded.
/// {@endtemplate}
class FileUploaded extends UploadedState {
  /// {@macro file_uploaded}
  const FileUploaded(super.fileUrl);

  /// {@macro remote_data_initialized.clone}
  FileUploaded.clone(super.oldState) : super.clone();
}

/// {@template repicking_file}
/// State that represents the picking of a new file having already uploaded a
/// file.
/// {@endtemplate}
class RepickingFile extends UploadedState with PickFileLoadingMixin {
  /// {@macro repicking_file}
  RepickingFile(super.oldState) : super.clone();
}

/// {@template repicking_file_failure}
/// State that represents the failure of the picking of a new file having
/// already uploaded a file.
/// {@endtemplate}
class RepickFileFailure extends UploadedState with PickFileFailureMixin {
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
class ReuploadingFile extends UploadedState with UploadFileLoadingMixin {
  /// {@macro reuploading_file}
  ReuploadingFile(super.oldState, this.newFile) : super.clone();

  /// The new file that is being uploaded.
  final File newFile;
}

/// {@template reuploading_file_success}
/// State that represents the successful uploading of a new file having already
/// uploaded one.
/// {@endtemplate}
class ReuploadFileSuccess extends UploadedState with UploadFileSuccessMixin {
  /// {@macro reuploading_file_success}
  const ReuploadFileSuccess(super.fileUrl);

  /// {@macro remote_data_initialized.clone}
  ReuploadFileSuccess.clone(super.oldState) : super.clone();
}

/// {@template reuploading_file_failure}
/// State that represents the failure of the uploading of a new file having
/// already uploaded one.
/// {@endtemplate}
class ReuploadFileFailure extends UploadedState with UploadFileFailureMixin {
  /// {@macro reuploading_file_failure}
  ReuploadFileFailure(super.oldState, this.error) : super.clone();

  /// The error that caused the file uploading to fail.
  final dynamic error;

  @override
  List<Object?> get props => [...super.props, error];
}
