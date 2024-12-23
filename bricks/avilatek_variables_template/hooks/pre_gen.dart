import 'dart:io';

import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

Future run(HookContext context) async {
  final logger = context.logger;

  final directory = Directory.current.path;
  List<String> folders;
  try {
    if (Platform.isWindows) {
      folders = directory.split(r'\').toList();
    } else {
      folders = directory.split('/').toList();
    }
    final libIndex = folders.indexWhere((folder) => folder == 'lib');
    final variablesPath =
        folders.sublist(libIndex + 1, folders.length).join('/');
    final pubSpecFile =
        File('${folders.sublist(0, libIndex).join('/')}/pubspec.yaml');
    final content = await pubSpecFile.readAsString();
    final yamlMap = loadYaml(content);
    final packageName = yamlMap['name'];

    if (packageName == null) {
      throw PubspecNameException();
    }

    context.vars = {
      ...context.vars,
      'full_path':
          (buildPath(packageName, variablesPath)).replaceAll('//', '/'),
    };
  } on RangeError catch (_) {
    logger.alert(
      red.wrap(
        'Could not find lib folder in $directory',
      ),
    );
    logger.alert(
      red.wrap(
        'Re-run this brick inside your lib folder',
      ),
    );
    throw Exception();
  } on FileSystemException catch (_) {
    logger.alert(
      red.wrap(
        'Could not find pubspec.yaml folder in ${directory.replaceAll('\\lib', '')}',
      ),
    );

    throw Exception();
  } on PubspecNameException catch (_) {
    logger.alert(
      red.wrap(
        'Could not read package name in pubspec.yaml',
      ),
    );
    logger.alert(
      red.wrap(
        'Does your pubspec have a name: ?',
      ),
    );
    throw Exception();
  } on Exception catch (e) {
    throw e;
  }
}

class PubspecNameException implements Exception {}

String buildPath(String packageName, String variablesPath) {
  if (variablesPath.isEmpty) {
    return packageName;
  } else {
    return '$packageName/$variablesPath';
  }
}
