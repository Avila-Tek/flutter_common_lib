part of 'pick_and_upload_file_bloc.dart';

/// {@template upload_file_event}
/// Abstract class that represents the events that can be dispatched to the
/// [PickAndUploadFileBloc].
/// {@endtemplate}
abstract class PickAndUploadFileEvent extends Equatable {
  /// {@macro upload_file_event}
  const PickAndUploadFileEvent();

  @override
  List<Object?> get props => [];
}

/// {@template pick_file}
/// Event that triggers the file picking and uploading.
/// {@endtemplate}
class PickFile extends PickAndUploadFileEvent {
  /// {@macro pick_file}
  const PickFile({this.simulateError = false});

  /// If true, the [PickAndUploadFileBloc] will simulate an error.
  final bool? simulateError;

  @override
  List<Object?> get props => [simulateError];
}
