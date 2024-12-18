import 'package:avilatek_core/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDeviceStorage extends Mock implements DeviceStorage {}

void main() {
  late MockDeviceStorage mockStorage;
  late PersistentHeadersInjector headersInjector;

  setUp(() {
    mockStorage = MockDeviceStorage();
    headersInjector = PersistentHeadersInjector(
      storage: mockStorage,
      // Setting empty default headers to avoid conflicts with the test
      // values.
      defaultHeaders: {},
    );
  });

  group(
    'PersistentHeadersInjector',
    () {
      group('getAll', () {
        test(
          'should return stored headers as a Map<String, String>',
          () async {
            when(
              () => mockStorage.getValue(PersistentHeadersInjector.storeKey),
            ).thenAnswer((_) async => '{"foo": "foo", "bar": "bar"}');

            final headers = await headersInjector.getAll();

            expect(headers, {'foo': 'foo', 'bar': 'bar'});
            expect(headers, isA<Map<String, String>>());
            verify(
              () => mockStorage.getValue(PersistentHeadersInjector.storeKey),
            ).called(1);
            verifyNoMoreInteractions(mockStorage);
          },
        );

        group('no stored headers in DeviceStorage', () {
          test(
            'should return an empty map when DeviceStorage.getValue() '
            'returns null',
            () async {
              when(
                () => mockStorage.getValue(PersistentHeadersInjector.storeKey),
              ).thenAnswer((_) async => null);

              final headers = await headersInjector.getAll();

              expect(headers, <String, String>{});
              expect(headers, isA<Map<String, String>>());
              verify(
                () => mockStorage.getValue(PersistentHeadersInjector.storeKey),
              ).called(1);
              verifyNoMoreInteractions(mockStorage);
            },
          );
          test(
            'should return an empty map when DeviceStorage.getValue() '
            'returns an empty string',
            () async {
              when(
                () => mockStorage.getValue(PersistentHeadersInjector.storeKey),
              ).thenAnswer((_) async => '');

              final headers = await headersInjector.getAll();

              expect(headers, <String, String>{});
              expect(headers, isA<Map<String, String>>());
              verify(
                () => mockStorage.getValue(PersistentHeadersInjector.storeKey),
              ).called(1);
              verifyNoMoreInteractions(mockStorage);
            },
          );
        });
      });

      group('headers', () {
        test(
          'should return default headers',
          () async {
            headersInjector = PersistentHeadersInjector(
              storage: mockStorage,
              defaultHeaders: {'default': 'default'},
            );

            when(
              () => mockStorage.getValue(PersistentHeadersInjector.storeKey),
            ).thenAnswer((_) async => '');

            final headers = await headersInjector.headers();

            expect(headers, {'default': 'default'});
            expect(headers, isA<Map<String, String>>());
            verify(
              () => mockStorage.getValue(PersistentHeadersInjector.storeKey),
            ).called(1);
            verifyNoMoreInteractions(mockStorage);
          },
        );
        test(
          'should return the stored headers',
          () async {
            when(
              () => mockStorage.getValue(PersistentHeadersInjector.storeKey),
            ).thenAnswer((_) async => '{"foo": "foo", "bar": "bar"}');

            final headers = await headersInjector.headers();

            expect(headers, {'foo': 'foo', 'bar': 'bar'});
          },
        );
        test(
          'stored headers should override default headers with the same key',
          () async {
            headersInjector = PersistentHeadersInjector(
              storage: mockStorage,
              defaultHeaders: {'default': 'default'},
            );

            when(
              () => mockStorage.getValue(PersistentHeadersInjector.storeKey),
            ).thenAnswer((_) async => '{"default": "stored"}');
            final headers = await headersInjector.headers();

            expect(headers, {'default': 'stored'});
          },
        );
        test(
          'extra headers should override stored headers and default headers '
          'with the same key',
          () async {
            headersInjector = PersistentHeadersInjector(
              storage: mockStorage,
              defaultHeaders: {'default': 'default'},
            );

            when(
              () => mockStorage.getValue(PersistentHeadersInjector.storeKey),
            ).thenAnswer((_) async => '{"default": "stored"}');

            final headers = await headersInjector.headers(
              extra: {
                'default': 'extra',
              },
            );

            expect(headers, {'default': 'extra'});
          },
        );

        test(
          'extra headers should be merged with stored and default headers',
          () async {
            headersInjector = PersistentHeadersInjector(
              storage: mockStorage,
              defaultHeaders: {'default': 'default'},
            );

            when(
              () => mockStorage.getValue(PersistentHeadersInjector.storeKey),
            ).thenAnswer((_) async => '{"stored": "stored"}');

            final headers = await headersInjector.headers(
              extra: {
                'extra': 'extra',
              },
            );

            expect(headers, {
              'default': 'default',
              'stored': 'stored',
              'extra': 'extra',
            });
          },
        );
      });

      group(
        'get',
        () {
          test(
            'should return the stored header value',
            () async {
              when(
                () => mockStorage.getValue(PersistentHeadersInjector.storeKey),
              ).thenAnswer((_) async => '{"foo": "foo", "bar": "bar"}');
              final header = await headersInjector.get('foo');

              expect(header, 'foo');
            },
          );
          test(
            'should return null when the header is not found',
            () async {
              when(
                () => mockStorage.getValue(PersistentHeadersInjector.storeKey),
              ).thenAnswer((_) async => '{"foo": "foo", "bar": "bar"}');
              final header = await headersInjector.get('baz');

              expect(header, null);
            },
          );
        },
      );
      group(
        'set',
        () {
          test(
            'should update header value if it was already exists',
            () async {
              when(
                () => mockStorage.getValue(PersistentHeadersInjector.storeKey),
              ).thenAnswer((_) async => '{"foo": "foo", "bar": "bar"}');
              when(
                () => mockStorage.setValue(
                  key: any(named: 'key'),
                  value: any(named: 'value'),
                ),
              ).thenAnswer((_) async {});

              await headersInjector.set('foo', 'overriden');

              verify(
                () => mockStorage.setValue(
                  key: PersistentHeadersInjector.storeKey,
                  value: '{"foo":"overriden","bar":"bar"}',
                ),
              ).called(1);
            },
          );
          test(
            'should add header if it was not already stored',
            () async {
              when(
                () => mockStorage.getValue(PersistentHeadersInjector.storeKey),
              ).thenAnswer((_) async => '{"foo":"foo"}');
              when(
                () => mockStorage.setValue(
                  key: any(named: 'key'),
                  value: any(named: 'value'),
                ),
              ).thenAnswer((_) async {});

              await headersInjector.set('bar', 'bar');

              verify(
                () => mockStorage.setValue(
                  key: PersistentHeadersInjector.storeKey,
                  value: '{"foo":"foo","bar":"bar"}',
                ),
              ).called(1);
            },
          );
        },
      );
      group(
        'delete',
        () {
          test(
            'should delete header value',
            () async {
              when(
                () => mockStorage.getValue(PersistentHeadersInjector.storeKey),
              ).thenAnswer((_) async => '{"foo": "foo", "bar": "bar"}');
              when(
                () => mockStorage.setValue(
                  key: any(named: 'key'),
                  value: any(named: 'value'),
                ),
              ).thenAnswer((_) async {});

              await headersInjector.delete('foo');

              verify(
                () => mockStorage.setValue(
                  key: PersistentHeadersInjector.storeKey,
                  value: '{"bar":"bar"}',
                ),
              ).called(1);
            },
          );

          test(
            'should do nothing if the header did not exist',
            () async {
              when(
                () => mockStorage.getValue(PersistentHeadersInjector.storeKey),
              ).thenAnswer((_) async => '{"foo": "foo", "bar": "bar"}');
              when(
                () => mockStorage.setValue(
                  key: any(named: 'key'),
                  value: any(named: 'value'),
                ),
              ).thenAnswer((_) async {});

              await headersInjector.delete('baz');

              verify(
                () => mockStorage.setValue(
                  key: PersistentHeadersInjector.storeKey,
                  value: '{"foo":"foo","bar":"bar"}',
                ),
              ).called(1);
            },
          );
        },
      );
    },
  );
}
