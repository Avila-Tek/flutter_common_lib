import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_standards/core/constants.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:flutter/material.dart';

class PokemonListTile extends StatelessWidget {
  const PokemonListTile({required this.pokemon, super.key});

  final Pokemon pokemon;

  static const imageDimensions = Size.square(110);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          /// NOTE: We are using a CachedNetworkImage here, but you can use any
          /// other widget that can display an image. It is highly encouraged
          /// to use a CachedNetworkImage for performance reasons.
          SizedBox(
            height: imageDimensions.height,
            width: imageDimensions.width,
            child: CachedNetworkImage(
              imageUrl: pokemon.sprite,
            ),
          ),
          const SizedBox(width: Consts.padding),
          Text(
            pokemon.name,
            style: context.textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
