import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  final groups = context.vars['groups'] as List? ?? [];
  final emailRecipients = context.vars['email_recipients'] as List? ?? [];
  final betaGroups = context.vars['beta_groups'] as List? ?? [];

  /// If groups is empty, we don't want to show the 'groups' attribute
  /// in the codemagic.yaml file, to avoid errors.
  if (groups.isNotEmpty) {
    context.vars['show_groups'] = true;
  }

  /// If betaGroups is empty, we don't want to show the 'beta_groups' attribute
  /// in the codemagic.yaml file, to avoid errors.
  if (betaGroups.isNotEmpty) {
    context.vars['show_beta_groups'] = true;
  }

  /// If emailRecipients is empty, we don't want to show the 'email' attribute
  /// in the codemagic.yaml file, to avoid errors.
  if (emailRecipients.isNotEmpty) {
    context.vars['show_email_recipients'] = true;
  }

  final directory = await getDirectoryToMainFiles(context);

  final files = await getFilesFromPathToMain(context, directory: directory);

  final flavors = context.vars['flavors'] as List;

  if (files.length < flavors.length) {
    context.logger.err(
        'You selected ${flavors.length} flavors, but it seems your path is missing main files. Create the missing dart files or select less flavors.');
  }

  final mappedFiles = await mapFilesToFlavors(context, mainFilesUris: files);

  for (var flavor in flavors) {
    context.vars['show_$flavor'] = true;
    context.vars['${flavor}_main_path'] = mappedFiles[flavor];
  }
}

Future<List<String>> getDartFiles(
  HookContext context, {
  required Directory directory,
}) async {
  final mainFiles = <String>[];

  await directory.list().forEach((element) {
    if (element.path.endsWith('.dart')) {
      mainFiles.add(element.path);
    }
  });

  return mainFiles;
}

Future<Directory> getDirectoryToMainFiles(
  HookContext context, {
  bool shouldPromptPath = false,
}) async {
  String pathToMainFiles;

  if (shouldPromptPath) {
    pathToMainFiles =
        context.logger.prompt('Enter the path to the main files: ');
  } else {
    pathToMainFiles = context.vars['path_to_main_files'] as String;
  }

  Directory directory;

  while (true) {
    directory = Directory.fromUri(Uri.parse(pathToMainFiles));
    final exists = await directory.exists();

    if (!exists) {
      context.logger.alert("The path '${directory.absolute}' does not exist.");
      pathToMainFiles =
          context.logger.prompt('Enter the path to the main files: ');
    } else {
      break;
    }
  }

  return directory;
}

Future<List<String>> getFilesFromPathToMain(
  HookContext context, {
  required Directory directory,
}) async {
  List<String> files;

  while (true) {
    files = await getDartFiles(context, directory: directory);

    if (files.isEmpty) {
      context.logger.alert("No dart files found in '${directory.absolute}'");

      directory =
          await getDirectoryToMainFiles(context, shouldPromptPath: true);
    } else {
      break;
    }
  }

  return files;
}

Future<Map<String, String>> mapFilesToFlavors(
  HookContext context, {
  required List<String> mainFilesUris,
}) {
  Map<String, String> mappedFiles = {};

  List<String> flavors = List<String>.from(context.vars['flavors']);

  for (var flavor in flavors) {
    final filePath = context.logger
        .chooseOne('Select a main file for $flavor: ', choices: mainFilesUris);

    mappedFiles[flavor] = filePath;
  }

  return Future.value(mappedFiles);
}
