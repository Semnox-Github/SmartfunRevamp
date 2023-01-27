import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.baseUrl = '${Get.find<String>(tag: 'baseURL')}/api/';
    if (Get.isRegistered<String>(tag: 'Token')) {
      options.headers[HttpHeaders.authorizationHeader] = Get.find<String>(tag: 'Token');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    handler.next(err);
  }
}
