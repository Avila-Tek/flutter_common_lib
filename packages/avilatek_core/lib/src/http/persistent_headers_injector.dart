import 'dart:convert';

import 'package:avilatek_core/src/http/headers_injector.dart';
import 'package:avilatek_core/src/interfaces/device_storage.dart';
import 'package:flutter/foundation.dart';

/// {@template http_headers_injector}
/// This class simplifies the process of injecting headers into HTTP requests
/// and makes it possible to share across the application using device storage.
///
/// To use, simply call the [headers] method to get the stored headers and
/// optionally provide extra headers that will have priority over the stored
/// values.
/// {@endtemplate}
final class PersistentHeadersInjector extends HeadersInjector {
  /// {@macro http_headers_injector}
  /// Creates a new instance of [HeadersInjector]. The [storage] parameter
  /// is required to store the headers values. It is highly recommended that
  /// a secured storage implementation is used, like
  /// [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage).
  ///
  /// The [defaultHeaders] parameter is optional and can be used to set default
  /// headers that will be used if the headers are not stored.
  ///
  /// {@macro http_headers_injector}
  PersistentHeadersInjector({
    required DeviceStorage storage,
    Map<String, String> defaultHeaders = const {
      'accept': 'application/json',
      'content-type': 'application/json',
    },
  })  : _storage = storage,
        _defaultHeaders = defaultHeaders;

  @visibleForTesting

  /// The key used to store the headers in the device storage. Public for
  /// testing only..
  static const String storeKey = '__http_headers__';

  final DeviceStorage _storage;
  final Map<String, String> _defaultHeaders;

  String _preProcessHeaderKey(String value) {
    return value.toLowerCase();
  }

  @override
  Future<Map<String, String>> getAll() async {
    final headersStr = await _storage.getValue(storeKey);

    if (headersStr == null || headersStr.isEmpty) {
      return {};
    }

    return Map<String, String>.from(jsonDecode(headersStr) as Map);
  }

  @override
  Future<String?> get(String key) async {
    final headers = await getAll();
    return headers[_preProcessHeaderKey(key)];
  }

  @override
  Future<void> set(String key, String value) async {
    final headers = await getAll();
    headers[_preProcessHeaderKey(key)] = value;
    return _storage.setValue(key: storeKey, value: jsonEncode(headers));
  }

  @override
  Future<void> delete(String key) async {
    final headers = await getAll();
    headers.remove(_preProcessHeaderKey(key));
    return _storage.setValue(key: storeKey, value: jsonEncode(headers));
  }

  @override
  Future<Map<String, String>> headers({Map<String, String>? extra}) async {
    final currentHeaders = await getAll();
    final extraNormalized =
        extra?.map((key, value) => MapEntry(_preProcessHeaderKey(key), value));

    return {
      ..._defaultHeaders,
      ...currentHeaders,
      ...?extraNormalized,
    };
  }
}
