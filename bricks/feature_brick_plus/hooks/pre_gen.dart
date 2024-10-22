import 'dart:io';

import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

Future run(HookContext context) async {
  final logger = context.logger;

  final featureType = context.vars['feature_type'].toString().toLowerCase();

  final isConventional = featureType == 'conventional';
  final isStepper = featureType == 'stepper';
  final isTabbed = featureType == 'tabbed';
  final isBottomModal = featureType == 'bottom_modal';

  int childrenAmount = 0;
  List<String> childrenNames = [];
  String firstChild = '';
  String lastChild = '';
  List<Map<String, dynamic>> children = [];

  if (isStepper || isTabbed) {
    bool isAmountCorrect = false;
    while (!isAmountCorrect) {
      final amount = context.logger.prompt(
        '? How many ${(isStepper) ? 'steps' : 'tabs'} do you want your feature to have?',
        defaultValue: '2',
      );

      childrenAmount = int.tryParse(amount) ?? 0;

      if (childrenAmount <= 0) {
        logger.warn(
            'Please enter a valid positive integer for the number of ${(isStepper) ? 'steps' : 'tabs'}.');
        continue;
      }

      childrenNames = context.logger.promptAny(
        '? What are the names of these ${(isStepper) ? 'steps' : 'tabs'}? Please use commas (,) to separate them: ',
        separator: ',',
      );

      if (childrenNames.length != childrenAmount) {
        logger.warn(
            'The amount of ${(isStepper) ? 'steps' : 'tabs'} does not match the number of names provided.');
        logger.warn(
            'Please make sure to input as many names as the amount of children and separate each one with commas (,).');
        continue;
      }

      firstChild = childrenNames.first;
      lastChild = childrenNames.last;
      children = childrenNames
          .map((child) => {
                'name': child,
                'isFirst': child == firstChild,
                'isLast': child == lastChild,
                'index': childrenNames.indexOf(child),
              })
          .toList();
      isAmountCorrect = true;
    }
  }

  final includeTests = context.logger.confirm(
    'Do you want to create tests for your feature?',
    defaultValue: false,
  );

  final directory = Directory.current.path;
  List<String> folders;
  try {
    if (Platform.isWindows) {
      folders = directory.split(r'\').toList();
    } else {
      folders = directory.split('/').toList();
    }
    final libIndex = folders.indexWhere((folder) => folder == 'lib');
    final featurePath = folders.sublist(libIndex + 1, folders.length).join('/');
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
      'fullPath':
          ('$packageName/$featurePath/${(context.vars['feature_name'] as String).snakeCase}')
              .replaceAll('//', '/'),
      'isConventional': isConventional,
      'isStepper': isStepper,
      'isTabbed': isTabbed,
      'isBottomModal': isBottomModal,
      'childrenAmount': childrenAmount,
      'childrenNames': childrenNames,
      'firstChild': firstChild,
      'lastChild': lastChild,
      'include_tests': includeTests,
      'children': children,
      // 'isBloc': isBloc,
      // 'isCubit': isCubit,
      // 'isProvider': isProvider,
      // 'isRiverpod': isRiverpod,
      // 'isNone': isNone,
      // 'use_equatable': useEquatable
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

class InvalidChildrenException implements Exception {}
