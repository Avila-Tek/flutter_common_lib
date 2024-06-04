import 'dart:io';

import 'package:code_standards/core/core.dart';
import 'package:test/test.dart';

void main() {
  group(
    '[ServerFailure]',
    () {
      const tFailure = ServerFailure(message: '', statusCode: 0);

      test(
        'should be a subclass of [Failure]',
        () async => expect(tFailure, isA<Failure>()),
      );
      test(
        'should return [message] and [statusCode] properties',
        () async {
          expect(tFailure.message, '');
          expect(tFailure.statusCode, 0);
        },
      );
      test(
        'should create [ServerFailure] from [ServerException]',
        () async => expect(
          ServerFailure.fromException(
            const ServerException(
              message: '',
              statusCode: 0,
            ),
          ),
          equals(tFailure),
        ),
      );
      test(
        'should equal [ServerFailure] with the same [message] and [statusCode] '
        'properties',
        () async => expect(
          tFailure,
          equals(const ServerFailure(message: '', statusCode: 0)),
        ),
      );
      test(
        'should not be equal with different properties',
        () async {
          expect(
            tFailure,
            isNot(equals(const ServerFailure(message: '', statusCode: 100))),
          );

          expect(
            tFailure,
            isNot(equals(const ServerFailure(message: 'Error', statusCode: 0))),
          );
        },
      );
    },
  );

  group('[UnknownFailure]', () {
    test(
      'should be a subclass of [Failure]',
      () async => expect(const UnknownFailure(''), isA<Failure>()),
    );

    test(
      'should set default message when [error] is null',
      () async {
        expect(const UnknownFailure(null).message, equals('Unknown failure'));
      },
    );
    test(
      'should show exception as string when [error] is not null',
      () async {
        expect(
          UnknownFailure(Exception()).message,
          equals('Unknown failure: Exception'),
        );
        // ignore: lines_longer_than_80_chars
        expect(
          UnknownFailure(const HttpException('Mock exception')).message,
          equals('Unknown failure: HttpException: Mock exception'),
        );
      },
    );
  });
}
