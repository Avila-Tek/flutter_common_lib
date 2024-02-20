import 'dart:io';

import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

Future run(HookContext context) async {
  final logger = context.logger;

  final projectHasSecondaryColor =
      context.vars['project_includes_secondary_color'];

  if (projectHasSecondaryColor) {
    String secondaryColor = 'ACBCC1';

    secondaryColor = context.logger.prompt(
        'Please enter the hex value of the secondary color used for the project (not includig #)');

    context.vars = {
      ...context.vars,
      'secondary_color_seed_value': secondaryColor,
    };
  }
}

class PubspecNameException implements Exception {}
