import 'package:flutter/material.dart';

class PokedexEmpty extends StatelessWidget {
  const PokedexEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No Pokémons found in the database'),
    );
  }
}
