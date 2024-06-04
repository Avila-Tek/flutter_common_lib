import 'package:code_standards/core/constants.dart';
import 'package:code_standards/src/domain/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'src/presentation/pokedex/mocks.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    required Widget child,
    IPokemonRepository? pokemonRepository,
  }) {
    return pumpWidget(
      RepositoryProvider<IPokemonRepository>(
        create: (context) => pokemonRepository ?? PokemonRepositoryMock(),
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Material(child: child),
        ),
      ),
    );
  }
}
