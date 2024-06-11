import 'dart:io';

import 'package:code_standards/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    '[ServerFailure]',
    () {
      test(
        'should be a subclass of [Failure]',
        () async => expect(
          const ServerFailure(message: '', statusCode: 0),
          isA<Failure>(),
        ),
      );
      test(
        'should return [message] and [statusCode] properties',
        () async {
          const tFailure = ServerFailure(message: '', statusCode: 0);

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
          equals(const ServerFailure(message: '', statusCode: 0)),
        ),
      );
      test(
        'should equal [ServerFailure] with the same [message] and [statusCode] '
        'properties',
        () async => expect(
          const ServerFailure(message: '', statusCode: 0),
          equals(const ServerFailure(message: '', statusCode: 0)),
        ),
      );
      test(
        'should not be equal with different properties',
        () async {
          expect(
            const ServerFailure(message: '', statusCode: 0),
            isNot(equals(const ServerFailure(message: '', statusCode: 1))),
          );

          expect(
            const ServerFailure(message: '', statusCode: 0),
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
