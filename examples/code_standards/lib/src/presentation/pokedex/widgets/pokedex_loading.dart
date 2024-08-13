import 'package:code_standards/core/constants.dart';
import 'package:flutter/material.dart';

class PokedexLoading extends StatelessWidget {
  const PokedexLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(Consts.padding * 6),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class PokedexLoadingListTile extends StatelessWidget {
  const PokedexLoadingListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(Consts.padding * 2),
        child: SizedBox.square(
          dimension: 15,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
