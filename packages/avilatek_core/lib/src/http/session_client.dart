import 'dart:async';
import 'dart:convert';

import 'package:avilatek_core/common.dart';
import 'package:avilatek_core/src/http/headers_injector.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

/// {@template custom_http_client}
/// Implementation of package:http BaseClient with header persistence using
///  [HeadersInjector].
/// {@endtemplate}
final class SessionHttpClient extends http.BaseClient {
  /// {@macro custom_http_client}
  SessionHttpClient({
    required HeadersInjector headersInjector,
    ErrorRadarDelegate? errorRadar,
    http.Client? inner,
  })  : _inner = inner ?? http.Client(),
        _headersInjector = headersInjector,
        _errorRadar = errorRadar;

  /// Creates a [SessionHttpClient] with retry on 401 status code. Useful when
  /// working with OAuth2.0 and refresh tokens.
  factory SessionHttpClient.withRetry({
    required HeadersInjector headersInjector,
    required FutureOr<void> Function(http.BaseRequest, http.BaseResponse?, int)?
        onRetry,
    FutureOr<bool> Function(http.BaseResponse) when = _defaultWhen,
    http.Client? inner,
    ErrorRadarDelegate? errorRadar,
  }) {
    const retries = 1;

    final retryClient = errorRadar != null
        ? RetryClient(
            inner ?? http.Client(),
            retries: retries,
            when: when,
            whenError: (e, s) {
              errorRadar.captureException(e, s);
              return true;
            },
            onRetry: onRetry,
          )
        : RetryClient(
            inner ?? http.Client(),
            retries: retries,
            when: when,
            onRetry: onRetry,
          );

    return SessionHttpClient(
      headersInjector: headersInjector,
      inner: retryClient,
    );
  }

  final HeadersInjector _headersInjector;
  final http.Client _inner;
  final ErrorRadarDelegate? _errorRadar;

  @override
  Future<http.Response> get(
    Uri url, {
    Map<String, String>? headers,
  }) async {
    final requestHeaders = await _headersInjector.headers(extra: headers);
    return _inner.get(url, headers: requestHeaders);
  }

  @override
  Future<http.Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final requestHeaders = await _headersInjector.headers(extra: headers);
    return _inner.delete(
      url,
      headers: requestHeaders,
      body: body,
      encoding: encoding,
    );
  }

  @override
  Future<http.Response> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final requestHeaders = await _headersInjector.headers(extra: headers);
    return _inner.patch(
      url,
      headers: requestHeaders,
      body: body,
      encoding: encoding,
    );
  }

  @override
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final requestHeaders = await _headersInjector.headers(extra: headers);
    return _inner.post(
      url,
      headers: requestHeaders,
      body: body,
      encoding: encoding,
    );
  }

  @override
  Future<http.Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final requestHeaders = await _headersInjector.headers(extra: headers);
    return _inner.put(
      url,
      headers: requestHeaders,
      body: body,
      encoding: encoding,
    );
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    try {
      return _inner.send(request);
    } catch (e, s) {
      _errorRadar?.captureException(e, s);
      rethrow;
    }
  }
}

bool _defaultWhen(http.BaseResponse response) => response.statusCode == 401;
