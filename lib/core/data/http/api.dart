import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/export_domain.dart';
import 'package:pokedex_code_challenge_21a/core/commons/services/export_services.dart';
import 'package:pokedex_code_challenge_21a/core/data/http/auth_interceptor.dart';

class Api {
  Api._();

  static final _client = InterceptedClient.build(
    interceptors: [
      AuthInterceptor(),
    ],
    requestTimeout: const Duration(
      seconds: _Constants.timeoutInSeconds,
    ),
  );

  /// Might throw an Exception if request failed.
  static Future<http.Response> requestHttp({
    required String endPoint,
    HttpMethod type = HttpMethod.GET,
    Map<String, String>? headers,
    Map<String, dynamic>? params,
    String? body,
  }) async {
    final String baseUrl =
        locator<EnvironmentService>().getValue(EnvKeys.baseUrl) as String;
    final Uri uri = Uri.parse('$baseUrl$endPoint');

    log(
      'Endpoint: $uri\nType: ${type.name}\n'
      'Params: $params\nBody: $body',
    );

    final response = switch (type) {
      HttpMethod.HEAD => await _client.head(
          uri,
          headers: headers,
        ),
      HttpMethod.GET => await _client.get(
          uri,
          headers: headers,
          params: params,
        ),
      HttpMethod.POST => await _client.post(
          uri,
          headers: headers,
          params: params,
          body: body,
        ),
      HttpMethod.PUT => await _client.put(
          uri,
          headers: headers,
          params: params,
          body: body,
        ),
      HttpMethod.PATCH => await _client.patch(
          uri,
          headers: headers,
          params: params,
          body: body,
        ),
      HttpMethod.DELETE => await _client.delete(
          uri,
          headers: headers,
          params: params,
          body: body,
        ),
    };

    log('Response statusCode: ${response.statusCode}');

    return response;
  }
}

class _Constants {
  static const int timeoutInSeconds = 8;
}
