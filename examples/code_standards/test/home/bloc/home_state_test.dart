// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:code_standards/src/presentation/home/bloc/bloc.dart';

void main() {
  group('HomeState', () {
    test('supports value equality', () {
      expect(
        HomeState(),
        equals(
          const HomeState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const HomeState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const homeState = HomeState(
            customProperty: 'My property',
          );
          expect(
            homeState.copyWith(),
            equals(homeState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const homeState = HomeState(
            customProperty: 'My property',
          );
          final otherHomeState = HomeState(
            customProperty: 'My property 2',
          );
          expect(homeState, isNot(equals(otherHomeState)));

          expect(
            homeState.copyWith(
              customProperty: otherHomeState.customProperty,
            ),
            equals(otherHomeState),
          );
        },
      );
    });
  });
}
