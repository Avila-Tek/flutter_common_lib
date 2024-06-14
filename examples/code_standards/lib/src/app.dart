import 'package:code_standards/core/theme/theme.dart';
import 'package:code_standards/l10n/l10n.dart';
import 'package:code_standards/src/data/data_sources/pokemon/pokemon_api_rest.dart';
import 'package:code_standards/src/data/repositories/pokemon_repository.dart';
import 'package:code_standards/src/domain/repositories/repositories.dart';
import 'package:code_standards/src/presentation/home/home.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IPokemonRepository>(
          create: (context) => PokemonRepository(
            pokemonApi: PokemonApiRest(baseUrl: 'https://pokeapi.co/api/v2'),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeLightMode(context),
        darkTheme: AppTheme.themeDarkMode(context),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomePage(),
      ),
    );
  }
}
