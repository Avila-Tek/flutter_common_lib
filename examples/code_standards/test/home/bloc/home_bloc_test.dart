// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:code_standards/src/presentation/home/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          HomeBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final homeBloc = HomeBloc();
      expect(homeBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<HomeBloc, HomeState>(
      'CustomHomeEvent emits nothing',
      build: HomeBloc.new,
      act: (bloc) => bloc.add(const CustomHomeEvent()),
      expect: () => <HomeState>[],
    );
  });
}
