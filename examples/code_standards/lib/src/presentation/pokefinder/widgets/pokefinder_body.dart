import 'package:flutter/material.dart';
import 'package:code_standards/src/presentation/pokefinder/bloc/bloc.dart';

// NOTE: Declare all the UI widgets here, including BlocBuilders.
/// {@template pokefinder_body}
/// Body of the PokefinderPage.
/// {@endtemplate}
class PokefinderBody extends StatelessWidget {
  /// {@macro pokefinder_body}
  const PokefinderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokefinderBloc, PokefinderState>(
      builder: (context, state) {
        return Center(child: Text('PokefinderPage'));
      },
    );
  }
}
