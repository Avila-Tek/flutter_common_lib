import 'package:code_standards/core/constants.dart';
import 'package:code_standards/src/presentation/home/bloc/bloc.dart';
import 'package:code_standards/src/presentation/pokedex/view/pokedex_page.dart';
import 'package:code_standards/src/presentation/pokefinder/pokefinder.dart';
import 'package:code_standards/src/presentation/pokerandomizer/pokerandomizer.dart';
import 'package:flutter/material.dart';

// NOTE: Declare all the UI widgets here, including BlocBuilders.
/// {@template home_body}
/// Body of the HomePage.
/// {@endtemplate}
class HomeBody extends StatelessWidget {
  /// {@macro home_body}
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return ListView(
          key: const Key('home_listview'),
          children: [
            ...ListTile.divideTiles(
              context: context,
              tiles: [
                ListTile(
                  key: const Key('pokedex_list_tile'),
                  title: Text(context.l10n.pokedexListTileTitle),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const PokedexPage(),
                    ),
                  ),
                ),
                ListTile(
                  key: const Key('poke_finder_list_tile'),
                  title: Text(context.l10n.pokeFinderListTileTitle),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const PokefinderPage(),
                    ),
                  ),
                ),
                ListTile(
                  key: const Key('poke_random_list_tile'),
                  title: Text(context.l10n.pokeRandomListTileTitle),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const PokerandomizerPage(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
