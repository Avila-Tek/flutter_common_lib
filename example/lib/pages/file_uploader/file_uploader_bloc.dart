import 'dart:io';

import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:file_picker/file_picker.dart';

export 'package:avilatek_bloc/avilatek_bloc.dart';

class FileUploaderBloc extends UploadFileBloc {
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
  Future<String> uploadFile(UploadFileState oldState, File file) async {
    // Here, you would usually upload the file to a server and get the URL
    // of the uploaded file. For the sake of this example, we'll use a fake
    // response URL.

    // final client = http.Client();
    // const url = 'URL TO UPLOAD FILE TO';

    // final response = await client.post(
    //   Uri.parse(url),
    //   headers: {
    //     'Content-Type': 'multipart/form-data',
    //   },
    //   body: {'file': file.readAsBytesSync().buffer.asInt64List()},
    // );

    // if (response.statusCode == 200) {
    //   final json = jsonDecode(response.body);
    //   return json['location'] ?? '';
    // } else {
    //   throw Exception('Failed to load file');
    // }

    const url = 'https://picsum.photos/500';

    await Future.delayed(const Duration(seconds: 2));

    return url;
  }
}
