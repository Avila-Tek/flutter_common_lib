import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final isTabbed = context.vars['isTabbed'] as bool? ?? false;
  final isStepper = context.vars['isStepper'] as bool? ?? false;

  if (isTabbed || isStepper) {
    createCompoundFolders(context, isTab: isTabbed);
  }

  final includeTests = context.vars['include_tests'] as bool;
  if (!includeTests) {
    return;
  }
  final logger = context.logger;
  final directory = Directory.current.path;

  List<String> folders;
  if (Platform.isWindows) {
    folders = directory.split(r'\').toList();
  } else {
    folders = directory.split('/').toList();
  }
  final libIndex = folders.indexWhere((folder) => folder == 'lib');

  final progress = logger.progress('Creating your tests!');

  final featureTestGen =
      await MasonGenerator.fromBundle(featureBrickTestsBundle);
  await featureTestGen.generate(
    DirectoryGeneratorTarget(
      Directory(('${folders.sublist(0, libIndex).join('/')}/test')),
    ),
    logger: logger,
    vars: context.vars,
  );

  progress.complete(green.wrap('Tests created!') as String);
}

// Future<void> createSteps(HookContext context) {
//   final fullPath = context.vars['fullPath'];
// }

Future<void> createCompoundFolders(HookContext context,
    {required bool isTab}) async {
  // final fullPath = context.vars['fullPath'];
  final featureName = (context.vars['feature_name'] as String).snakeCase;
  final directory = Directory.current.path;

  String pathName;

  if (Platform.isWindows) {
    pathName = directory + r'\' + featureName;
  } else {
    pathName = directory + '/' + featureName;
  }

  final featureAmount = context.vars['childrenAmount'] as int? ?? 0;
  int index = 0;
  final namesList = context.vars['childrenNames'];

  while (index <= (featureAmount - 1)) {
    final name = namesList[index];
    final compoundFeatureGen = await MasonGenerator.fromBundle(
        compoundFeatureBundle(tabName: name, isTab: isTab));
    context.vars = {
      ...context.vars,
      'tab_name': name,
    };
    await compoundFeatureGen.generate(
      DirectoryGeneratorTarget(
        Directory(pathName),
      ),
      logger: context.logger,
      vars: context.vars,
    );
    index++;
  }
}

final featureBrickTestsBundle = MasonBundle.fromJson(<String, dynamic>{
  "files": [
    {
      "path":
          "{{feature_name.snakeCase()}}\\base\\{{feature_name.snakeCase()}}_page_test.dart",
      "data":
          "Ly8gaWdub3JlX2Zvcl9maWxlOiBwcmVmZXJfY29uc3RfY29uc3RydWN0b3JzCgppbXBvcnQgJ3BhY2thZ2U6Zmx1dHRlci9tYXRlcmlhbC5kYXJ0JzsKaW1wb3J0ICdwYWNrYWdlOnt7e2Z1bGxQYXRofX19L3t7ZmVhdHVyZV9uYW1lLnNuYWtlQ2FzZSgpfX0uZGFydCc7CmltcG9ydCAncGFja2FnZTpmbHV0dGVyX3Rlc3QvZmx1dHRlcl90ZXN0LmRhcnQnOwoKdm9pZCBtYWluKCkgewogIGdyb3VwKCd7e2ZlYXR1cmVfbmFtZS5wYXNjYWxDYXNlKCl9fVBhZ2UnLCAoKSB7CiAgIAoKICAgIHRlc3RXaWRnZXRzKCdyZW5kZXJzIGJhc2UgU2NhZmZvbGQnLCAodGVzdGVyKSBhc3luYyB7CiAgICAgIGF3YWl0IHRlc3Rlci5wdW1wV2lkZ2V0KE1hdGVyaWFsQXBwKGhvbWU6IHt7ZmVhdHVyZV9uYW1lLnBhc2NhbENhc2UoKX19UGFnZSgpKSk7CiAgICAgIGV4cGVjdChmaW5kLmJ5VHlwZShTY2FmZm9sZCksIGZpbmRzT25lV2lkZ2V0KTsKICAgIH0pOwogIH0pOwp9Cg==",
      "type": "text"
    },
    {
      "path":
          "{{feature_name.snakeCase()}}\\bloc\\{{feature_name.snakeCase()}}_bloc_test.dart",
      "data":
          "Ly8gaWdub3JlX2Zvcl9maWxlOiBwcmVmZXJfY29uc3RfY29uc3RydWN0b3JzCgppbXBvcnQgJ3BhY2thZ2U6YmxvY190ZXN0L2Jsb2NfdGVzdC5kYXJ0JzsKaW1wb3J0ICdwYWNrYWdlOmZsdXR0ZXJfdGVzdC9mbHV0dGVyX3Rlc3QuZGFydCc7CmltcG9ydCAncGFja2FnZTp7e3tmdWxsUGF0aH19fS9ibG9jL2Jsb2MuZGFydCc7Cgp2b2lkIG1haW4oKSB7CiAgZ3JvdXAoJ3t7ZmVhdHVyZV9uYW1lLnBhc2NhbENhc2UoKX19QmxvYycsICgpIHsKICAgIGdyb3VwKCdjb25zdHJ1Y3RvcicsICgpIHsKICAgICAgdGVzdCgnY2FuIGJlIGluc3RhbnRpYXRlZCcsICgpIHsKICAgICAgICBleHBlY3QoCiAgICAgICAgICB7e2ZlYXR1cmVfbmFtZS5wYXNjYWxDYXNlKCl9fUJsb2MoKSwKICAgICAgICAgIGlzTm90TnVsbCwKICAgICAgICApOwogICAgICB9KTsKICAgIH0pOwoKICAgIHRlc3QoJ2luaXRpYWwgc3RhdGUgaGFzIGRlZmF1bHQgdmFsdWUgZm9yIHN0YXR1cycsICgpIHsKICAgICAgZmluYWwge3tmZWF0dXJlX25hbWUuY2FtZWxDYXNlKCl9fUJsb2MgPSB7e2ZlYXR1cmVfbmFtZS5wYXNjYWxDYXNlKCl9fUJsb2MoKTsKICAgICAgZXhwZWN0KHt7ZmVhdHVyZV9uYW1lLmNhbWVsQ2FzZSgpfX1CbG9jLnN0YXRlLnN0YXR1cywgZXF1YWxzKHt7ZmVhdHVyZV9uYW1lLnBhc2NhbENhc2UoKX19U3RhdHVzLmluaXRpYWwpKTsKICAgIH0pOwoKICAgICAgIHt7I2lzU3RlcHBlcn19YmxvY1Rlc3Q8e3tmZWF0dXJlX25hbWUucGFzY2FsQ2FzZSgpfX1CbG9jLCB7e2ZlYXR1cmVfbmFtZS5wYXNjYWxDYXNlKCl9fVN0YXRlPigKICAgICAgJ05leHRTdGVwIGVtaXRzIGEgbmV3IHN0YXRlIHdpdGggZGlmZmVyZW50IHN0ZXAgYW5kIGN1cnJlbnRQYWdlSW5kZXgnLAogICAgICBidWlsZDoge3tmZWF0dXJlX25hbWUucGFzY2FsQ2FzZSgpfX1CbG9jLm5ldywKICAgICAgYWN0OiAoYmxvYykgPT4gYmxvYy5hZGQoY29uc3Qge3tmZWF0dXJlX25hbWUucGFzY2FsQ2FzZSgpfX1OZXh0U3RlcChuZXh0U3RlcDogIHt7ZmVhdHVyZV9uYW1lLnBhc2NhbENhc2UoKX19U3RlcC57eyNjaGlsZHJlbn19e3sjaXNMYXN0fX17e25hbWUuY2FtZWxDYXNlKCl9fXt7L2lzTGFzdH19e3svY2hpbGRyZW59fSkpLAogICAgICAvLyBUT0RPOiBVcGRhdGUgdGhlIGV4cGVjdGVkIHZhbHVlCiAgICAgIGV4cGVjdDogKCkgPT4gPHt7ZmVhdHVyZV9uYW1lLnBhc2NhbENhc2UoKX19U3RhdGU+WwogICAgICAgIGNvbnN0IHt7ZmVhdHVyZV9uYW1lLnBhc2NhbENhc2UoKX19U3RhdGUoCiAgICAgICAgICBzdGVwOiB7e2ZlYXR1cmVfbmFtZS5wYXNjYWxDYXNlKCl9fVN0ZXAue3sjY2hpbGRyZW59fXt7I2lzTGFzdH19e3tuYW1lLmNhbWVsQ2FzZSgpfX17ey9pc0xhc3R9fXt7L2NoaWxkcmVufX0sCiAgICAgICAgICBjdXJyZW50UGFnZUluZGV4OiAxLAogICAgICAgICksCiAgICAgIF0sCiAgICApOwogICAge3svaXNTdGVwcGVyfX0KICB9KTsKfQo=",
      "type": "text"
    },
    {
      "path":
          "{{feature_name.snakeCase()}}\\bloc\\{{feature_name.snakeCase()}}_event_test.dart",
      "data":
          "Ly8gaWdub3JlX2Zvcl9maWxlOiBwcmVmZXJfY29uc3RfY29uc3RydWN0b3JzCgppbXBvcnQgJ3BhY2thZ2U6Zmx1dHRlcl90ZXN0L2ZsdXR0ZXJfdGVzdC5kYXJ0JzsKaW1wb3J0ICdwYWNrYWdlOnt7e2Z1bGxQYXRofX19L2Jsb2MvYmxvYy5kYXJ0JzsKCnZvaWQgbWFpbigpIHsKICBncm91cCgne3tmZWF0dXJlX25hbWUucGFzY2FsQ2FzZSgpfX1FdmVudCcsICgpIHsKICAgIGdyb3VwKCdDdXN0b217e2ZlYXR1cmVfbmFtZS5wYXNjYWxDYXNlKCl9fUV2ZW50JywgKCkgewogICAgICB0ZXN0KCdzdXBwb3J0cyB2YWx1ZSBlcXVhbGl0eScsICgpIHsKICAgICAgICBleHBlY3QoCiAgICAgICAgICBDdXN0b217e2ZlYXR1cmVfbmFtZS5wYXNjYWxDYXNlKCl9fUV2ZW50KCksCiAgICAgICAgICBlcXVhbHMoY29uc3QgQ3VzdG9te3tmZWF0dXJlX25hbWUucGFzY2FsQ2FzZSgpfX1FdmVudCgpKSwKICAgICAgICApOwogICAgICB9KTsKICAgIH0pOwogICAgZ3JvdXAoJ2NvbnN0cnVjdG9yJywgKCkgewogICAgICB0ZXN0KCdjYW4gYmUgaW5zdGFudGlhdGVkJywgKCkgewogICAgICAgIGV4cGVjdCgKICAgICAgICAgIGNvbnN0IEN1c3RvbXt7ZmVhdHVyZV9uYW1lLnBhc2NhbENhc2UoKX19RXZlbnQoKSwKICAgICAgICAgIGlzTm90TnVsbAogICAgICAgICk7CiAgICAgIH0pOwogICAgfSk7CiAgfSk7Cn0K",
      "type": "text"
    },
    {
      "path":
          "{{feature_name.snakeCase()}}\\bloc\\{{feature_name.snakeCase()}}_state_test.dart",
      "data":
          "Ly8gaWdub3JlX2Zvcl9maWxlOiBwcmVmZXJfY29uc3RfY29uc3RydWN0b3JzCgppbXBvcnQgJ3BhY2thZ2U6Zmx1dHRlcl90ZXN0L2ZsdXR0ZXJfdGVzdC5kYXJ0JzsKaW1wb3J0ICdwYWNrYWdlOnt7e2Z1bGxQYXRofX19L2Jsb2MvYmxvYy5kYXJ0JzsKCnZvaWQgbWFpbigpIHsKICBncm91cCgne3tmZWF0dXJlX25hbWUucGFzY2FsQ2FzZSgpfX1TdGF0ZScsICgpIHsKICAgIHRlc3QoJ3N1cHBvcnRzIHZhbHVlIGVxdWFsaXR5JywgKCkgewogICAgICBleHBlY3QoCiAgICAgICAge3tmZWF0dXJlX25hbWUucGFzY2FsQ2FzZSgpfX1TdGF0ZSgpLAogICAgICAgIGVxdWFscygKICAgICAgICAgIGNvbnN0IHt7ZmVhdHVyZV9uYW1lLnBhc2NhbENhc2UoKX19U3RhdGUoKSwKICAgICAgICApLAogICAgICApOwogICAgfSk7CgogICAgZ3JvdXAoJ2NvbnN0cnVjdG9yJywgKCkgewogICAgICB0ZXN0KCdjYW4gYmUgaW5zdGFudGlhdGVkJywgKCkgewogICAgICAgIGV4cGVjdCgKICAgICAgICAgIGNvbnN0IHt7ZmVhdHVyZV9uYW1lLnBhc2NhbENhc2UoKX19U3RhdGUoKSwKICAgICAgICAgIGlzTm90TnVsbCwKICAgICAgICApOwogICAgICB9KTsKICAgIH0pOwoKZ3JvdXAoJ2NvcHlXaXRoJywgKCkgewogICAgICB0ZXN0KAogICAgICAgICdjb3BpZXMgY29ycmVjdGx5ICcKICAgICAgICAnd2hlbiBubyBhcmd1bWVudCBzcGVjaWZpZWQnLAogICAgICAgICgpIHsKICAgICAgICAgIGNvbnN0IHt7ZmVhdHVyZV9uYW1lLmNhbWVsQ2FzZSgpfX1TdGF0ZSA9IHt7ZmVhdHVyZV9uYW1lLnBhc2NhbENhc2UoKX19U3RhdGUoCiAgICAgICAgICAgIHN0YXR1czoge3tmZWF0dXJlX25hbWUucGFzY2FsQ2FzZSgpfX1TdGF0dXMuaW5pdGlhbCwKICAgICAgICAgICk7CiAgICAgICAgICBleHBlY3QoCiAgICAgICAgICAgIHt7ZmVhdHVyZV9uYW1lLmNhbWVsQ2FzZSgpfX1TdGF0ZS5jb3B5V2l0aCgpLAogICAgICAgICAgICBlcXVhbHMoe3tmZWF0dXJlX25hbWUuY2FtZWxDYXNlKCl9fVN0YXRlKSwKICAgICAgICAgICk7CiAgICAgICAgfSwKICAgICAgKTsKCiAgICAgIHRlc3QoCiAgICAgICAgJ2NvcGllcyBjb3JyZWN0bHkgJwogICAgICAgICd3aGVuIGFsbCBhcmd1bWVudHMgc3BlY2lmaWVkJywKICAgICAgICAoKSB7CiAgICAgICAgICBjb25zdCB7e2ZlYXR1cmVfbmFtZS5jYW1lbENhc2UoKX19U3RhdGUgPSB7e2ZlYXR1cmVfbmFtZS5wYXNjYWxDYXNlKCl9fVN0YXRlKAogICAgICAgICAgICBzdGF0dXM6IHt7ZmVhdHVyZV9uYW1lLnBhc2NhbENhc2UoKX19U3RhdHVzLmluaXRpYWwsCiAgICAgICAgICAgIHt7I2lzU3RlcHBlcn19c3RlcDoge3tmZWF0dXJlX25hbWUucGFzY2FsQ2FzZSgpfX1TdGVwLnt7I2NoaWxkcmVufX17eyNpc0ZpcnN0fX17e25hbWUuY2FtZWxDYXNlKCl9fXt7L2lzRmlyc3R9fXt7L2NoaWxkcmVufX0sCiAgICAgICAgICAgIGN1cnJlbnRQYWdlSW5kZXg6IDAsCiAgICAgICAgICAgIHt7L2lzU3RlcHBlcn19CiAgICAgICAgICApOwogICAgICAgICAgZmluYWwgb3RoZXJ7e2ZlYXR1cmVfbmFtZS5wYXNjYWxDYXNlKCl9fVN0YXRlID0ge3tmZWF0dXJlX25hbWUucGFzY2FsQ2FzZSgpfX1TdGF0ZSgKICAgICAgICAgICAgc3RhdHVzOiB7e2ZlYXR1cmVfbmFtZS5wYXNjYWxDYXNlKCl9fVN0YXR1cy5sb2FkaW5nLAogICAgICAgICAgICB7eyNpc1N0ZXBwZXJ9fXN0ZXA6IHt7ZmVhdHVyZV9uYW1lLnBhc2NhbENhc2UoKX19U3RlcC57eyNjaGlsZHJlbn19e3sjaXNMYXN0fX17e25hbWUuY2FtZWxDYXNlKCl9fXt7L2lzTGFzdH19e3svY2hpbGRyZW59fSwKICAgICAgICAgICAgY3VycmVudFBhZ2VJbmRleDogMSwKICAgICAgICAgICAge3svaXNTdGVwcGVyfX0KICAgICAgICAgICk7CiAgICAgICAgICBleHBlY3Qoe3tmZWF0dXJlX25hbWUuY2FtZWxDYXNlKCl9fVN0YXRlLCBpc05vdChlcXVhbHMob3RoZXJ7e2ZlYXR1cmVfbmFtZS5wYXNjYWxDYXNlKCl9fVN0YXRlKSkpOwoKICAgICAgICAgIGV4cGVjdCgKICAgICAgICAgICAge3tmZWF0dXJlX25hbWUuY2FtZWxDYXNlKCl9fVN0YXRlLmNvcHlXaXRoKAogICAgICAgICAgICAgIHN0YXR1czogb3RoZXJ7e2ZlYXR1cmVfbmFtZS5wYXNjYWxDYXNlKCl9fVN0YXRlLnN0YXR1cywKICAgICAgICAgICAgICB7eyNpc1N0ZXBwZXJ9fXN0ZXA6IG90aGVye3tmZWF0dXJlX25hbWUucGFzY2FsQ2FzZSgpfX1TdGF0ZS5zdGVwLAogICAgICAgICAgICAgIGN1cnJlbnRQYWdlSW5kZXg6IG90aGVye3tmZWF0dXJlX25hbWUucGFzY2FsQ2FzZSgpfX1TdGF0ZS5jdXJyZW50UGFnZUluZGV4LAogICAgICAgICAgICAgIHt7L2lzU3RlcHBlcn19CiAgICAgICAgICAgICksCiAgICAgICAgICAgIGVxdWFscyhvdGhlcnt7ZmVhdHVyZV9uYW1lLnBhc2NhbENhc2UoKX19U3RhdGUpLAogICAgICAgICAgKTsKICAgICAgICB9LAogICAgICApOwogICAgfSk7CiAgfSk7Cn0K",
      "type": "text"
    },
  ],
  "hooks": [
    {
      "path": "pre_gen.dart",
      "data":
          "aW1wb3J0ICdwYWNrYWdlOm1hc29uL21hc29uLmRhcnQnOw0KDQp2b2lkIHJ1bihIb29rQ29udGV4dCBjb250ZXh0KSB7DQogIC8vIFRPRE86IGFkZCBwcmUtZ2VuZXJhdGlvbiBsb2dpYy4NCn0NCg==",
      "type": "text"
    },
    {
      "path": "pubspec.yaml",
      "data":
          "bmFtZTogZmVhdHVyZV9icmlja190ZXN0c19ob29rcw0KDQplbnZpcm9ubWVudDoNCiAgc2RrOiAiPj0yLjEyLjAgPDMuMC4wIg0KDQpkZXBlbmRlbmNpZXM6DQogIG1hc29uOiBeMC4xLjAtZGV2DQo=",
      "type": "text"
    }
  ],
  "name": "feature_brick_tests",
  "description":
      "A supporting brick for feature_brick that creates tests with 100% coverage",
  "version": "0.0.1",
  "environment": {"mason": ">=0.1.0-dev.26 <0.1.0"},
  "repository":
      "https://github.com/LukeMoody01/mason_bricks/tree/master/bricks/feature_brick_tests",
  "readme": {
    "path": "README.md",
    "data":
        "IyBGZWF0dXJlIEJyaWNrIFRlc3RzDQoNCkEgc3VwcG9ydGluZyBicmljayB0byBjcmVhdGUgeW91ciBmZWF0dXJlcyB0ZXN0cyB3aXRoIDEwMCUgY292ZXJhZ2UgdXNpbmcgYmVzdCBwcmFjdGljZXMgYW5kIHlvdXIgc3RhdGUgbWFuYWdlbWVudCBvZiBjaG9pY2UhIFN1cHBvcnRzIEJsb2MsIEN1Yml0LCBOb25lLg0KDQojIyBIb3cgdG8gdXNlIPCfmoANCg0KYGBgDQptYXNvbiBtYWtlIGZlYXR1cmVfYnJpY2sgLS1mZWF0dXJlX25hbWUgbG9naW4gLS1zdGF0ZV9tYW5hZ2VtZW50IGJsb2MNCmBgYA0KDQojIyBWYXJpYWJsZXMg4pyoDQoNCk4vQSBhcyB0aGlzIGlzIGEgc3VwcG9ydGluZyBicmljayBmb3IgZmVhdHVyZV9icmljaw0KDQojIyBPdXRwdXRzIPCfk6YNCg0KYGBgDQotLWZlYXR1cmVfbmFtZSBsb2dpbiAtLXN0YXRlX21hbmFnZW1lbnQgYmxvYw0K4pSc4pSA4pSAIGxvZ2luDQrilIIgICDilJzilIDilIAgYmxvYw0K4pSCICAg4pSCICAg4pSc4pSA4pSAIGxvZ2luX2Jsb2NfdGVzdC5kYXJ0DQrilIIgICDilIIgICDilJzilIDilIAgbG9naW5fZXZlbnRfdGVzdC5kYXJ0DQrilIIgICDilIIgICDilJTilIDilIAgbG9naW5fc3RhdGVfdGVzdC5kYXJ0DQrilIIgICDilJzilIDilIAgdmlldw0K4pSCICAg4pSCICAg4pSc4pSA4pSAIGxvZ2luX3BhZ2VfdGVzdC5kYXJ0DQrilIIgICDilIIgICDilJTilIDilIB3aWRnZXRzDQrilIIgICDilIIgICAgICAg4pSU4pSA4pSAIGxvZ2luX2JvZHlfdGVzdC5kYXJ0DQrilJTilIDilIAgLi4uDQpgYGANCg0KYGBgDQotLWZlYXR1cmVfbmFtZSBsb2dpbiAtLXN0YXRlX21hbmFnZW1lbnQgY3ViaXQNCuKUnOKUgOKUgCBsb2dpbg0K4pSCICAg4pSc4pSA4pSAIGN1Yml0DQrilIIgICDilIIgICDilJzilIDilIAgbG9naW5fY3ViaXRfdGVzdC5kYXJ0DQrilIIgICDilIIgICDilJTilIDilIAgbG9naW5fc3RhdGVfdGVzdC5kYXJ0DQrilIIgICDilJzilIDilIAgdmlldw0K4pSCICAg4pSCICAg4pSc4pSA4pSAIGxvZ2luX3BhZ2VfdGVzdC5kYXJ0DQrilIIgICDilIIgICDilJTilIDilIB3aWRnZXRzDQrilIIgICDilIIgICAgICAg4pSU4pSA4pSAIGxvZ2luX2JvZHlfdGVzdC5kYXJ0DQrilJTilIDilIAgLi4uDQpgYGANCg==",
    "type": "text"
  },
  "changelog": {
    "path": "CHANGELOG.md",
    "data":
        "IyAwLjAuMQ0KDQotIENyZWF0ZSBpbml0aWFsIEZlYXR1cmUgQnJpY2sgVGVzdHMgd2hpY2ggc3VwcG9ydHMgYmxvYywgY3ViaXQsIGFuZCBub25lDQo=",
    "type": "text"
  },
  "license": {
    "path": "LICENSE",
    "data":
        "TUlUIExpY2Vuc2UNCg0KQ29weXJpZ2h0IChjKSAyMDIyIEx1a2UgTW9vZHkNCg0KUGVybWlzc2lvbiBpcyBoZXJlYnkgZ3JhbnRlZCwgZnJlZSBvZiBjaGFyZ2UsIHRvIGFueSBwZXJzb24gb2J0YWluaW5nIGEgY29weQ0Kb2YgdGhpcyBzb2Z0d2FyZSBhbmQgYXNzb2NpYXRlZCBkb2N1bWVudGF0aW9uIGZpbGVzICh0aGUgIlNvZnR3YXJlIiksIHRvIGRlYWwNCmluIHRoZSBTb2Z0d2FyZSB3aXRob3V0IHJlc3RyaWN0aW9uLCBpbmNsdWRpbmcgd2l0aG91dCBsaW1pdGF0aW9uIHRoZSByaWdodHMNCnRvIHVzZSwgY29weSwgbW9kaWZ5LCBtZXJnZSwgcHVibGlzaCwgZGlzdHJpYnV0ZSwgc3VibGljZW5zZSwgYW5kL29yIHNlbGwNCmNvcGllcyBvZiB0aGUgU29mdHdhcmUsIGFuZCB0byBwZXJtaXQgcGVyc29ucyB0byB3aG9tIHRoZSBTb2Z0d2FyZSBpcw0KZnVybmlzaGVkIHRvIGRvIHNvLCBzdWJqZWN0IHRvIHRoZSBmb2xsb3dpbmcgY29uZGl0aW9uczoNCg0KVGhlIGFib3ZlIGNvcHlyaWdodCBub3RpY2UgYW5kIHRoaXMgcGVybWlzc2lvbiBub3RpY2Ugc2hhbGwgYmUgaW5jbHVkZWQgaW4gYWxsDQpjb3BpZXMgb3Igc3Vic3RhbnRpYWwgcG9ydGlvbnMgb2YgdGhlIFNvZnR3YXJlLg0KDQpUSEUgU09GVFdBUkUgSVMgUFJPVklERUQgIkFTIElTIiwgV0lUSE9VVCBXQVJSQU5UWSBPRiBBTlkgS0lORCwgRVhQUkVTUyBPUg0KSU1QTElFRCwgSU5DTFVESU5HIEJVVCBOT1QgTElNSVRFRCBUTyBUSEUgV0FSUkFOVElFUyBPRiBNRVJDSEFOVEFCSUxJVFksDQpGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRSBBTkQgTk9OSU5GUklOR0VNRU5ULiBJTiBOTyBFVkVOVCBTSEFMTCBUSEUNCkFVVEhPUlMgT1IgQ09QWVJJR0hUIEhPTERFUlMgQkUgTElBQkxFIEZPUiBBTlkgQ0xBSU0sIERBTUFHRVMgT1IgT1RIRVINCkxJQUJJTElUWSwgV0hFVEhFUiBJTiBBTiBBQ1RJT04gT0YgQ09OVFJBQ1QsIFRPUlQgT1IgT1RIRVJXSVNFLCBBUklTSU5HIEZST00sDQpPVVQgT0YgT1IgSU4gQ09OTkVDVElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBPUiBUSEUgVVNFIE9SIE9USEVSIERFQUxJTkdTIElOIFRIRQ0KU09GVFdBUkUuDQo=",
    "type": "text"
  },
  "vars": {}
});

MasonBundle compoundFeatureBundle(
    {required String tabName, required bool isTab}) {
  final snakeCaseName = toSnakeCase(tabName);
  return MasonBundle.fromJson(<String, dynamic>{
    "files": [
      {
        "path":
            "${isTab ? 'tabs' : 'steps'}/${snakeCaseName}/bloc/${snakeCaseName}_bloc.dart",
        "data":
            "cGFydCBvZiAncGFja2FnZTp7e3tmdWxsUGF0aH19fS9iYXNlL3t7ZmVhdHVyZV9uYW1lLnNuYWtlQ2FzZSgpfX1fcGFnZS5kYXJ0JzsKCmNsYXNzIF97e3RhYl9uYW1lLnBhc2NhbENhc2UoKX19QmxvYyBleHRlbmRzIEJsb2M8X3t7dGFiX25hbWUucGFzY2FsQ2FzZSgpfX1FdmVudCwgX3t7dGFiX25hbWUucGFzY2FsQ2FzZSgpfX1TdGF0ZT4gewogIF97e3RhYl9uYW1lLnBhc2NhbENhc2UoKX19QmxvYygpIDogc3VwZXIoY29uc3QgX3t7dGFiX25hbWUucGFzY2FsQ2FzZSgpfX1TdGF0ZSgpKTsKfQo=",
        "type": "text"
      },
      {
        "path":
            "${isTab ? 'tabs' : 'steps'}/${snakeCaseName}/bloc/${snakeCaseName}_event.dart",
        "data":
            "cGFydCBvZiAncGFja2FnZTp7e3tmdWxsUGF0aH19fS9iYXNlL3t7ZmVhdHVyZV9uYW1lLnNuYWtlQ2FzZSgpfX1fcGFnZS5kYXJ0JzsKCmFic3RyYWN0IGNsYXNzIF97e3RhYl9uYW1lLnBhc2NhbENhc2UoKX19RXZlbnQgZXh0ZW5kcyBFcXVhdGFibGUgewogIGNvbnN0IF97e3RhYl9uYW1lLnBhc2NhbENhc2UoKX19RXZlbnQoKTsKCiAgQG92ZXJyaWRlCiAgTGlzdDxPYmplY3Q+IGdldCBwcm9wcyA9PiBbXTsKfQo=",
        "type": "text"
      },
      {
        "path":
            "${isTab ? 'tabs' : 'steps'}/${snakeCaseName}/bloc/${snakeCaseName}_state.dart",
        "data":
            "cGFydCBvZiAncGFja2FnZTp7e3tmdWxsUGF0aH19fS9iYXNlL3t7ZmVhdHVyZV9uYW1lLnNuYWtlQ2FzZSgpfX1fcGFnZS5kYXJ0JzsKCmVudW0gX3t7dGFiX25hbWUucGFzY2FsQ2FzZSgpfX1TdGF0dXMgewogIGluaXRpYWwsCiAgbG9hZGluZywKICBzdWNjZXNzLAogIGZhaWx1cmU7CgogIGJvb2wgZ2V0IGlzSW5pdGlhbCA9PiB0aGlzID09IF97e3RhYl9uYW1lLnBhc2NhbENhc2UoKX19U3RhdHVzLmluaXRpYWw7CiAgYm9vbCBnZXQgaXNMb2FkaW5nID0+IHRoaXMgPT0gX3t7dGFiX25hbWUucGFzY2FsQ2FzZSgpfX1TdGF0dXMubG9hZGluZzsKICBib29sIGdldCBpc1N1Y2Nlc3MgPT4gdGhpcyA9PSBfe3t0YWJfbmFtZS5wYXNjYWxDYXNlKCl9fVN0YXR1cy5zdWNjZXNzOwogIGJvb2wgZ2V0IGlzRmFpbHVyZSA9PiB0aGlzID09IF97e3RhYl9uYW1lLnBhc2NhbENhc2UoKX19U3RhdHVzLmZhaWx1cmU7Cn0KCi8vLyB7QHRlbXBsYXRlIHN0ZXBfb25lX3N0YXRlfQovLy8ge3t0YWJfbmFtZS5wYXNjYWxDYXNlKCl9fVN0YXRlIGRlc2NyaXB0aW9uCi8vLyB7QGVuZHRlbXBsYXRlfQpjbGFzcyBfe3t0YWJfbmFtZS5wYXNjYWxDYXNlKCl9fVN0YXRlIGV4dGVuZHMgRXF1YXRhYmxlIHsKICAvLy8ge0BtYWNybyBzdGVwX29uZV9zdGF0ZX0KICBjb25zdCBfe3t0YWJfbmFtZS5wYXNjYWxDYXNlKCl9fVN0YXRlKHsKICAgIHRoaXMuc3RhdHVzID0gX3t7dGFiX25hbWUucGFzY2FsQ2FzZSgpfX1TdGF0dXMuaW5pdGlhbCwKICB9KTsKCiAgLy8vIFN0YXR1cyBvZiB0aGUgc3RhdGUKICBmaW5hbCBfe3t0YWJfbmFtZS5wYXNjYWxDYXNlKCl9fVN0YXR1cyBzdGF0dXM7CgogIEBvdmVycmlkZQogIExpc3Q8T2JqZWN0PiBnZXQgcHJvcHMgPT4gW3N0YXR1c107CgogIC8vLyBDcmVhdGVzIGEgY29weSBvZiB0aGUgY3VycmVudCB7e3RhYl9uYW1lLnBhc2NhbENhc2UoKX19U3RhdGUgd2l0aCBwcm9wZXJ0eSBjaGFuZ2VzCiAgX3t7dGFiX25hbWUucGFzY2FsQ2FzZSgpfX1TdGF0ZSBjb3B5V2l0aCh7CiAgICBfe3t0YWJfbmFtZS5wYXNjYWxDYXNlKCl9fVN0YXR1cz8gc3RhdHVzLAogIH0pIHsKICAgIHJldHVybiBfe3t0YWJfbmFtZS5wYXNjYWxDYXNlKCl9fVN0YXRlKAogICAgICBzdGF0dXM6IHN0YXR1cyA/PyB0aGlzLnN0YXR1cywKICAgICk7CiAgfQp9Cg==",
        "type": "text"
      },
      {
        "path":
            "${isTab ? 'tabs' : 'steps'}/${snakeCaseName}/base/${snakeCaseName}_page.dart",
        "data":
            "cGFydCBvZiAncGFja2FnZTp7e3tmdWxsUGF0aH19fS9iYXNlL3t7ZmVhdHVyZV9uYW1lLnNuYWtlQ2FzZSgpfX1fcGFnZS5kYXJ0JzsKCmNsYXNzIF97e3RhYl9uYW1lLnBhc2NhbENhc2UoKX19UGFnZSBleHRlbmRzIFN0YXRlbGVzc1dpZGdldCB7CiAgLy8vIHtAbWFjcm8gc3RlcF9vbmVfcGFnZX0KICBjb25zdCBfe3t0YWJfbmFtZS5wYXNjYWxDYXNlKCl9fVBhZ2UoKTsKCiAgQG92ZXJyaWRlCiAgV2lkZ2V0IGJ1aWxkKEJ1aWxkQ29udGV4dCBjb250ZXh0KSB7CiAgICByZXR1cm4gQmxvY1Byb3ZpZGVyKAogICAgICBjcmVhdGU6IChjb250ZXh0KSA9PiBfe3t0YWJfbmFtZS5wYXNjYWxDYXNlKCl9fUJsb2MoKSwKICAgICAgY2hpbGQ6IGNvbnN0IFNjYWZmb2xkKAogICAgICAgIC8vIGFwcEJhcjogQXBwQmFyKAogICAgICAgIC8vICAgdGl0bGU6IGNvbnN0IFRleHQoJ3t7dGFiX25hbWUucGFzY2FsQ2FzZSgpfX0nKSwKICAgICAgICAvLyApLAogICAgICAgIGJvZHk6IF97e3RhYl9uYW1lLnBhc2NhbENhc2UoKX19VmlldygpLAogICAgICApLAogICAgKTsKICB9Cn0KCi8vIE5PVEU6IERlY2xhcmUgYWxsIEJsb2NMaXN0ZW5lcnMgb2Yge3t0YWJfbmFtZS5wYXNjYWxDYXNlKCl9fSBoZXJlIHRvIGhhbmRsZSBuYXZpZ2F0aW9uLAovLyBzaG93aW5nIGRpYWxvZ3MsIGV0Yy4KLy8vIHtAdGVtcGxhdGUgc3RlcF9vbmVfdmlld30KLy8vIERpc3BsYXlzIHRoZSBCb2R5IG9mIF97e3RhYl9uYW1lLnBhc2NhbENhc2UoKX19VmlldwovLy8ge0BlbmR0ZW1wbGF0ZX0KLy8vCmNsYXNzIF97e3RhYl9uYW1lLnBhc2NhbENhc2UoKX19VmlldyBleHRlbmRzIFN0YXRlbGVzc1dpZGdldCB7CiAgLy8vIHtAbWFjcm8gc3RlcF9vbmVfdmlld30KICBjb25zdCBfe3t0YWJfbmFtZS5wYXNjYWxDYXNlKCl9fVZpZXcoKTsKCiAgQG92ZXJyaWRlCiAgV2lkZ2V0IGJ1aWxkKEJ1aWxkQ29udGV4dCBjb250ZXh0KSB7CiAgICByZXR1cm4gY29uc3QgX3t7dGFiX25hbWUucGFzY2FsQ2FzZSgpfX1Cb2R5KCk7CiAgfQp9Cg==",
        "type": "text"
      },
      {
        "path":
            "${isTab ? 'tabs' : 'steps'}/${snakeCaseName}/base/${snakeCaseName}_body.dart",
        "data":
            "Ly8gaWdub3JlX2Zvcl9maWxlOiBwcmVmZXJfY29uc3RfY29uc3RydWN0b3JzCnBhcnQgb2YgJ3BhY2thZ2U6e3t7ZnVsbFBhdGh9fX0vYmFzZS97e2ZlYXR1cmVfbmFtZS5zbmFrZUNhc2UoKX19X3BhZ2UuZGFydCc7CgovLyBOT1RFOiBEZWNsYXJlIGFsbCB0aGUgVUkgd2lkZ2V0cyBoZXJlLCBpbmNsdWRpbmcgQmxvY0J1aWxkZXJzLgovLy8ge0B0ZW1wbGF0ZSBzdGVwX29uZV9ib2R5fQovLy8gQm9keSBvZiB0aGUge3t0YWJfbmFtZS5wYXNjYWxDYXNlKCl9fVBhZ2UuCi8vLyB7QGVuZHRlbXBsYXRlfQpjbGFzcyBfe3t0YWJfbmFtZS5wYXNjYWxDYXNlKCl9fUJvZHkgZXh0ZW5kcyBTdGF0ZWxlc3NXaWRnZXQgewogIC8vLyB7QG1hY3JvIHN0ZXBfb25lX2JvZHl9CiAgY29uc3QgX3t7dGFiX25hbWUucGFzY2FsQ2FzZSgpfX1Cb2R5KCk7CgogIEBvdmVycmlkZQogIFdpZGdldCBidWlsZChCdWlsZENvbnRleHQgY29udGV4dCkgewogICAgcmV0dXJuIEJsb2NCdWlsZGVyPF97e3RhYl9uYW1lLnBhc2NhbENhc2UoKX19QmxvYywgX3t7dGFiX25hbWUucGFzY2FsQ2FzZSgpfX1TdGF0ZT4oCiAgICAgIGJ1aWxkZXI6IChjb250ZXh0LCBzdGF0ZSkgewogICAgICAgIHJldHVybiBjb25zdCBDZW50ZXIoY2hpbGQ6IFRleHQoJ3t7dGFiX25hbWUucGFzY2FsQ2FzZSgpfX1QYWdlJykpOwogICAgICB9LAogICAgKTsKICB9Cn0K",
        "type": "text"
      },
      {
        "path":
            "${isTab ? 'tabs' : 'steps'}/${snakeCaseName}/widgets/widgets.dart",
        "data":
            "Ly8gVE9ETzogYWRkIGFueSB3aWRnZXRzIGNyZWF0ZWQgZm9yIHRoaXMgdGFiLiBJbiBjYXNlIHRoZXJlIGFyZW4ndCBhbnksIGRlbGV0ZSB0aGlzIGZvbGRlci4=",
        "type": "text"
      },
    ],
    "name": "tabbed_feature_brick",
    "description":
        "A supporting brick for feature_brick that creates a tabbed feature",
    "version": "0.0.1",
    "readme": {
      "path": "README.md",
      "data":
          "IyBGZWF0dXJlIEJyaWNrIFRlc3RzDQoNCkEgc3VwcG9ydGluZyBicmljayB0byBjcmVhdGUgeW91ciBmZWF0dXJlcyB0ZXN0cyB3aXRoIDEwMCUgY292ZXJhZ2UgdXNpbmcgYmVzdCBwcmFjdGljZXMgYW5kIHlvdXIgc3RhdGUgbWFuYWdlbWVudCBvZiBjaG9pY2UhIFN1cHBvcnRzIEJsb2MsIEN1Yml0LCBOb25lLg0KDQojIyBIb3cgdG8gdXNlIPCfmoANCg0KYGBgDQptYXNvbiBtYWtlIGZlYXR1cmVfYnJpY2sgLS1mZWF0dXJlX25hbWUgbG9naW4gLS1zdGF0ZV9tYW5hZ2VtZW50IGJsb2MNCmBgYA0KDQojIyBWYXJpYWJsZXMg4pyoDQoNCk4vQSBhcyB0aGlzIGlzIGEgc3VwcG9ydGluZyBicmljayBmb3IgZmVhdHVyZV9icmljaw0KDQojIyBPdXRwdXRzIPCfk6YNCg0KYGBgDQotLWZlYXR1cmVfbmFtZSBsb2dpbiAtLXN0YXRlX21hbmFnZW1lbnQgYmxvYw0K4pSc4pSA4pSAIGxvZ2luDQrilIIgICDilJzilIDilIAgYmxvYw0K4pSCICAg4pSCICAg4pSc4pSA4pSAIGxvZ2luX2Jsb2NfdGVzdC5kYXJ0DQrilIIgICDilIIgICDilJzilIDilIAgbG9naW5fZXZlbnRfdGVzdC5kYXJ0DQrilIIgICDilIIgICDilJTilIDilIAgbG9naW5fc3RhdGVfdGVzdC5kYXJ0DQrilIIgICDilJzilIDilIAgdmlldw0K4pSCICAg4pSCICAg4pSc4pSA4pSAIGxvZ2luX3BhZ2VfdGVzdC5kYXJ0DQrilIIgICDilIIgICDilJTilIDilIB3aWRnZXRzDQrilIIgICDilIIgICAgICAg4pSU4pSA4pSAIGxvZ2luX2JvZHlfdGVzdC5kYXJ0DQrilJTilIDilIAgLi4uDQpgYGANCg0KYGBgDQotLWZlYXR1cmVfbmFtZSBsb2dpbiAtLXN0YXRlX21hbmFnZW1lbnQgY3ViaXQNCuKUnOKUgOKUgCBsb2dpbg0K4pSCICAg4pSc4pSA4pSAIGN1Yml0DQrilIIgICDilIIgICDilJzilIDilIAgbG9naW5fY3ViaXRfdGVzdC5kYXJ0DQrilIIgICDilIIgICDilJTilIDilIAgbG9naW5fc3RhdGVfdGVzdC5kYXJ0DQrilIIgICDilJzilIDilIAgdmlldw0K4pSCICAg4pSCICAg4pSc4pSA4pSAIGxvZ2luX3BhZ2VfdGVzdC5kYXJ0DQrilIIgICDilIIgICDilJTilIDilIB3aWRnZXRzDQrilIIgICDilIIgICAgICAg4pSU4pSA4pSAIGxvZ2luX2JvZHlfdGVzdC5kYXJ0DQrilJTilIDilIAgLi4uDQpgYGANCg==",
      "type": "text"
    },
    "changelog": {
      "path": "CHANGELOG.md",
      "data":
          "IyAwLjAuMQ0KDQotIENyZWF0ZSBpbml0aWFsIEZlYXR1cmUgQnJpY2sgVGVzdHMgd2hpY2ggc3VwcG9ydHMgYmxvYywgY3ViaXQsIGFuZCBub25lDQo=",
      "type": "text"
    },
    "license": {
      "path": "LICENSE",
      "data":
          "TUlUIExpY2Vuc2UNCg0KQ29weXJpZ2h0IChjKSAyMDIyIEx1a2UgTW9vZHkNCg0KUGVybWlzc2lvbiBpcyBoZXJlYnkgZ3JhbnRlZCwgZnJlZSBvZiBjaGFyZ2UsIHRvIGFueSBwZXJzb24gb2J0YWluaW5nIGEgY29weQ0Kb2YgdGhpcyBzb2Z0d2FyZSBhbmQgYXNzb2NpYXRlZCBkb2N1bWVudGF0aW9uIGZpbGVzICh0aGUgIlNvZnR3YXJlIiksIHRvIGRlYWwNCmluIHRoZSBTb2Z0d2FyZSB3aXRob3V0IHJlc3RyaWN0aW9uLCBpbmNsdWRpbmcgd2l0aG91dCBsaW1pdGF0aW9uIHRoZSByaWdodHMNCnRvIHVzZSwgY29weSwgbW9kaWZ5LCBtZXJnZSwgcHVibGlzaCwgZGlzdHJpYnV0ZSwgc3VibGljZW5zZSwgYW5kL29yIHNlbGwNCmNvcGllcyBvZiB0aGUgU29mdHdhcmUsIGFuZCB0byBwZXJtaXQgcGVyc29ucyB0byB3aG9tIHRoZSBTb2Z0d2FyZSBpcw0KZnVybmlzaGVkIHRvIGRvIHNvLCBzdWJqZWN0IHRvIHRoZSBmb2xsb3dpbmcgY29uZGl0aW9uczoNCg0KVGhlIGFib3ZlIGNvcHlyaWdodCBub3RpY2UgYW5kIHRoaXMgcGVybWlzc2lvbiBub3RpY2Ugc2hhbGwgYmUgaW5jbHVkZWQgaW4gYWxsDQpjb3BpZXMgb3Igc3Vic3RhbnRpYWwgcG9ydGlvbnMgb2YgdGhlIFNvZnR3YXJlLg0KDQpUSEUgU09GVFdBUkUgSVMgUFJPVklERUQgIkFTIElTIiwgV0lUSE9VVCBXQVJSQU5UWSBPRiBBTlkgS0lORCwgRVhQUkVTUyBPUg0KSU1QTElFRCwgSU5DTFVESU5HIEJVVCBOT1QgTElNSVRFRCBUTyBUSEUgV0FSUkFOVElFUyBPRiBNRVJDSEFOVEFCSUxJVFksDQpGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRSBBTkQgTk9OSU5GUklOR0VNRU5ULiBJTiBOTyBFVkVOVCBTSEFMTCBUSEUNCkFVVEhPUlMgT1IgQ09QWVJJR0hUIEhPTERFUlMgQkUgTElBQkxFIEZPUiBBTlkgQ0xBSU0sIERBTUFHRVMgT1IgT1RIRVINCkxJQUJJTElUWSwgV0hFVEhFUiBJTiBBTiBBQ1RJT04gT0YgQ09OVFJBQ1QsIFRPUlQgT1IgT1RIRVJXSVNFLCBBUklTSU5HIEZST00sDQpPVVQgT0YgT1IgSU4gQ09OTkVDVElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBPUiBUSEUgVVNFIE9SIE9USEVSIERFQUxJTkdTIElOIFRIRQ0KU09GVFdBUkUuDQo=",
      "type": "text"
    },
    "vars": {}
  });
}

String toSnakeCase(String input) {
  return input
      .replaceAllMapped(RegExp(r'([a-z])([A-Z])'),
          (match) => '${match.group(1)}_${match.group(2)}')
      .replaceAll(RegExp(r'\s+'), '_')
      .toLowerCase();
}
