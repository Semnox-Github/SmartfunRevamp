import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

import 'package:logger/logger.dart';

import 'package:semnox/core/domain/use_cases/splash_screen/authenticate_base_url_use_case.dart';
import 'package:semnox/di/injection_container.dart';

class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.baseUrl = '${Get.find<String>(tag: 'baseURL')}/api/';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      final reAuthenticate = Get.find<AuthenticateBaseURLUseCase>();
      final response = await reAuthenticate();
      response.fold(
        (l) {
          Logger().e(l.message);
        },
        (r) async {
          authenticateApi(r, Get.find<String>(tag: 'baseURL'));
          final opts = Options(
            method: err.requestOptions.method,
            headers: {
              HttpHeaders.authorizationHeader: r.webApiToken,
            },
          );

          final cloneReq = await Dio().request(
            '${err.requestOptions.baseUrl}${err.requestOptions.path}',
            options: opts,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
          );
          return handler.resolve(cloneReq);
        },
      );
    } else {
      return handler.next(err);
    }
  }
}
