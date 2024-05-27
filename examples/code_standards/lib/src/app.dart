import 'package:code_standards/core/theme/theme.dart';
import 'package:code_standards/l10n/l10n.dart';
import 'package:code_standards/src/presentation/home/home.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.themeLightMode(context),
      darkTheme: AppTheme.themeDarkMode(context),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
