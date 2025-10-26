import 'dart:developer';
import 'dart:io';
import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/core/services/localstorage/storage_key.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';

import 'api_client.dart';

class ApiService {
  final ApiClient _client;
  final LocalStorageService _localStorage;
  final SessionMemory _sessionMemory;

  ApiService(this._client, this._localStorage, this._sessionMemory);

  Future<Map<String, String>> _getHeaders({Map<String, String>? extra}) async {
    String? token = await _localStorage.getString(StorageKey.token);
    token ??= _sessionMemory.token;
    final headers = {
      'Accept-Language': 'en',
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      if (token != null) 'SignUpToken': 'signUpToken $token',
      if (token != null) 'Forget-password': 'Forget-password $token',

      if (extra != null) ...extra,
    };
    return headers;
  }

  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? extraHeaders,
    bool fullUrl = false,
  }) async {
    final url =
        (fullUrl)
            ? Uri.parse(endpoint)
            : Uri.parse('${ApiEndpoints.baseUrl}$endpoint');
    log(url.toString());
    final headers = await _getHeaders(extra: extraHeaders);
    return _client.get(url, headers: headers);
  }

  Future<dynamic> post(
    String endpoint,
    dynamic body, {
    Map<String, String>? extraHeaders,
  }) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}$endpoint');
    final headers = await _getHeaders(extra: extraHeaders);
    return _client.post(url, headers: headers, body: body);
  }

  Future<dynamic> put(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? extraHeaders,
  }) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}$endpoint');
    final headers = await _getHeaders(extra: extraHeaders);
    return _client.put(url, headers: headers, body: body);
  }

  Future<dynamic> patch(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? extraHeaders,
  }) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}$endpoint');
    final headers = await _getHeaders(extra: extraHeaders);
    return _client.patch(url, headers: headers, body: body);
  }

  Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? extraHeaders,
    Map<String, dynamic>? body,
  }) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}$endpoint');
    final headers = await _getHeaders(extra: extraHeaders);
    return _client.delete(url, headers: headers, body: body);
  }

  Future<dynamic> multipart(
    String endpoint, {
    String method = 'POST',
    Map<String, File>? files,
    dynamic body,
    String bodyFieldName = 'data', // field name for JSON body
    Map<String, String>? extraHeaders,
  }) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}$endpoint');
    final headers = await _getHeaders(extra: extraHeaders);
    return _client.sendMultipart(
      url,
      method: method,
      headers: headers,
      files: files,
      body: body,
      bodyFieldName: bodyFieldName,
    );
  }
}
