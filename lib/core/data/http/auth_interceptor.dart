import 'dart:developer';

import 'package:http_interceptor/http_interceptor.dart';

class AuthInterceptor implements InterceptorContract {
  @override
  Future<bool> shouldInterceptRequest() async => true;

  // We need to intercept request
  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    try {
      // Add necessary headers
    } catch (error, stackTrace) {
      log(
        'interceptRequest error',
        error: error,
        stackTrace: stackTrace,
      );
    }
    return request;
  }

  @override
  Future<bool> shouldInterceptResponse() async => false;

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    return response;
  }
}
