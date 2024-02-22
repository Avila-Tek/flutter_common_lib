part of 'upload_file_bloc.dart';

/// {@template upload_file_event}
/// Abstract class that represents the events that can be dispatched to the
/// [UploadFileBloc].
/// {@endtemplate}
abstract class UploadFileEvent extends Equatable {
  /// {@macro upload_file_event}
  const UploadFileEvent();

  @override
  List<Object?> get props => [];
}

/// {@template pick_file}
/// Event that triggers the file picking and uploading.
/// {@endtemplate}
class PickFile extends UploadFileEvent {
  /// {@macro pick_file}
  const PickFile({this.simulateError = false});

  /// If true, the [UploadFileBloc] will simulate an error.
  final bool? simulateError;

  @override
  List<Object?> get props => [simulateError];
}
