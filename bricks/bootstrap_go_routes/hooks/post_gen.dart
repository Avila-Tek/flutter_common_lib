import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final logger = context.logger;
  final directory = Directory.current.path;

  // Add go_router package if it doesn't exist

  final pubspecFile = File('$directory/pubspec.yaml');
  final pubspec = await pubspecFile.readAsString();

  if (!pubspec.contains('go_router')) {
    final progress = logger.progress('Updating pubspec.yaml...');

    await Process.run('flutter', ['pub', 'add', 'go_router']);

    progress.complete(green.wrap('Done.') as String);
  }
}
