import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_standards/core/constants.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PokefinderFinder extends StatelessWidget {
  const PokefinderFinder({
    required this.onInputChanged,
    this.pokemon,
    super.key,
  });

  final Pokemon? pokemon;
  final void Function(String value) onInputChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Consts.margin),
      children: [
        SizedBox.square(
          key: const ValueKey('pokefinder_finder_pokemon_sprite_sized_box'),
          dimension: 100,
          child: pokemon == null
              ? null
              : CachedNetworkImage(
                  key: const ValueKey('pokefinder_finder_pokemon_sprite_image'),
                  imageUrl: pokemon!.sprite,
                ),
        ),
        const SizedBox(height: Consts.sectionPadding),
        Center(
          child: ConstrainedBox(
            constraints:
                BoxConstraints.loose(const Size(300, double.maxFinite)),
            child: TextField(
              key: const ValueKey('pokefinder_finder_id_input'),
              onChanged: onInputChanged,
              decoration: InputDecoration(
                hintText: context.l10n.pokedexFinderInputHint,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 4,
            ),
          ),
        ),
      ],
    );
  }
}
