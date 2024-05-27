import 'package:flutter/material.dart';
import 'package:code_standards/src/presentation/home/bloc/bloc.dart';

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
        return Center(child: Text('HomePage'));
      },
    );
  }
}
