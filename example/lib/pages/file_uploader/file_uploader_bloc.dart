import 'dart:io';

import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:file_picker/file_picker.dart';

export 'package:avilatek_bloc/avilatek_bloc.dart';

class FileUploaderBloc extends PickAndUploadFileBloc {
  FileUploaderBloc() : super();

  @override
  Future<File?> pickFile(PickFile event) async {
    //Use file_picker library to pick a file

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    final file = result?.files.single;

    if (file != null && file.path != null) {
      return File(file.path!);
    }
    return null;
  }

  @override
  Future<String> uploadFile(PickAndUploadFileState oldState, File file) async {
    const url = 'https://picsum.photos/500';

    await Future.delayed(const Duration(seconds: 2));

    return url;
  }
}
