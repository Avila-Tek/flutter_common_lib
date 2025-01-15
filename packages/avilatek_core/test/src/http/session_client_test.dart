import 'package:avilatek_core/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHeadersInjector extends Mock implements HeadersInjector {}

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

void main() {
  late MockHeadersInjector mockHeadersInjector;
  late MockHttpClient mockHttpClient;
  late SessionHttpClient client;

  final uri = Uri.parse('https://example.com');

  setUp(() {
    mockHeadersInjector = MockHeadersInjector();
    mockHttpClient = MockHttpClient();
    client = SessionHttpClient(
      headersInjector: mockHeadersInjector,
      inner: mockHttpClient,
    );

    registerFallbackValue(Uri.parse('https://example.com'));
    registerFallbackValue(http.Request('GET', uri));
  });

  group(
    'SessionHttpClient',
    () {
      group('default', () {
        test(
          'GET method should include headers from HeadersInjector in the '
          'request',
          () async {
            when(
              () => mockHeadersInjector.headers(),
            ).thenAnswer((_) async => {'foo': 'foo'});
            when(
              () => mockHttpClient.get(
                any<Uri>(),
                headers: any(named: 'headers'),
              ),
            ).thenAnswer((_) async => MockResponse());

            await client.get(uri);

            verify(() => mockHeadersInjector.headers()).called(1);
            verify(
              () => mockHttpClient.get(uri, headers: {'foo': 'foo'}),
            ).called(1);
          },
        );
        test(
          'POST method should include headers from HeadersInjector in the'
          ' request',
          () async {
            when(
              () => mockHeadersInjector.headers(),
            ).thenAnswer((_) async => {'foo': 'foo'});
            when(
              () => mockHttpClient.post(
                any<Uri>(),
                headers: any(named: 'headers'),
              ),
            ).thenAnswer((_) async => MockResponse());

            await client.post(uri);

            verify(() => mockHeadersInjector.headers()).called(1);
            verify(
              () => mockHttpClient.post(uri, headers: {'foo': 'foo'}),
            ).called(1);
          },
        );
        test(
          'PUT method should include headers from HeadersInjector in the '
          'request',
          () async {
            when(
              () => mockHeadersInjector.headers(),
            ).thenAnswer((_) async => {'foo': 'foo'});
            when(
              () => mockHttpClient.put(
                any<Uri>(),
                headers: any(named: 'headers'),
              ),
            ).thenAnswer((_) async => MockResponse());

            await client.put(uri);

            verify(() => mockHeadersInjector.headers()).called(1);
            verify(
              () => mockHttpClient.put(uri, headers: {'foo': 'foo'}),
            ).called(1);
          },
        );
        test(
          'PATCH method should include headers from HeadersInjector in the '
          'request',
          () async {
            when(
              () => mockHeadersInjector.headers(),
            ).thenAnswer((_) async => {'foo': 'foo'});
            when(
              () => mockHttpClient.patch(
                any<Uri>(),
                headers: any(named: 'headers'),
              ),
            ).thenAnswer((_) async => MockResponse());

            await client.patch(uri);

            verify(() => mockHeadersInjector.headers()).called(1);
            verify(
              () => mockHttpClient.patch(uri, headers: {'foo': 'foo'}),
            ).called(1);
          },
        );
        test(
          'DELETE method should include headers from HeadersInjector in the'
          ' request',
          () async {
            when(
              () => mockHeadersInjector.headers(),
            ).thenAnswer((_) async => {'foo': 'foo'});
            when(
              () => mockHttpClient.delete(
                any<Uri>(),
                headers: any(named: 'headers'),
              ),
            ).thenAnswer((_) async => MockResponse());

            await client.delete(uri);

            verify(() => mockHeadersInjector.headers()).called(1);
            verify(
              () => mockHttpClient.delete(uri, headers: {'foo': 'foo'}),
            ).called(1);
          },
        );
      });

      group('factory withRetry', () {
        test(
          'should call onRetry on a response of status 401',
          () async {
            var counter = 0;

            client = SessionHttpClient.withRetry(
              headersInjector: mockHeadersInjector,
              onRetry: (_, __, ___) async {
                counter++;
              },
              inner: mockHttpClient,
            );

            when(
              () => mockHeadersInjector.headers(),
            ).thenAnswer((_) async => {});

            /// Stub a streamed response
            when(() => mockHttpClient.send(any())).thenAnswer(
              (_) async => http.StreamedResponse(
                const Stream.empty(),
                401,
                headers: {},
                request: http.Request('GET', uri),
              ),
            );

            await client.get(uri);

            expect(counter, 1);
          },
        );
        test(
          'should not call onRetry when the response is not 401 and "when" is '
          'not provided',
          () async {
            var counter = 0;

            client = SessionHttpClient.withRetry(
              headersInjector: mockHeadersInjector,
              onRetry: (_, __, ___) async {
                counter++;
              },
              inner: mockHttpClient,
            );

            when(
              () => mockHeadersInjector.headers(),
            ).thenAnswer((_) async => {});

            /// Stub a streamed response
            when(() => mockHttpClient.send(any())).thenAnswer(
              (_) async => http.StreamedResponse(
                const Stream.empty(),
                200,
                headers: {},
                request: http.Request('GET', uri),
              ),
            );

            await client.get(uri);

            expect(counter, 0);
          },
        );

        test(
          'should override "when" when provided',
          () async {
            var counter = 0;

            client = SessionHttpClient.withRetry(
              headersInjector: mockHeadersInjector,
              onRetry: (_, __, ___) async {
                counter++;
              },
              inner: mockHttpClient,
              when: (response) async => response.statusCode == 200,
            );

            when(
              () => mockHeadersInjector.headers(),
            ).thenAnswer((_) async => {});

            /// Stub a streamed response
            when(() => mockHttpClient.send(any())).thenAnswer(
              (_) async => http.StreamedResponse(
                const Stream.empty(),
                200,
                headers: {},
                request: http.Request('GET', uri),
              ),
            );

            await client.get(uri);

            expect(counter, 1);
          },
        );
      });
    },
  );
}
