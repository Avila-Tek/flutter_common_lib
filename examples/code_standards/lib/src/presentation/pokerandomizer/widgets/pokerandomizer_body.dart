import 'package:flutter/material.dart';
import 'package:code_standards/src/presentation/pokerandomizer/bloc/bloc.dart';

// NOTE: Declare all the UI widgets here, including BlocBuilders.
/// {@template pokerandomizer_body}
/// Body of the PokerandomizerPage.
/// {@endtemplate}
class PokerandomizerBody extends StatelessWidget {
  /// {@macro pokerandomizer_body}
  const PokerandomizerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokerandomizerBloc, PokerandomizerState>(
      builder: (context, state) {
        return Center(child: Text('PokerandomizerPage'));
      },
    );
  }
}
