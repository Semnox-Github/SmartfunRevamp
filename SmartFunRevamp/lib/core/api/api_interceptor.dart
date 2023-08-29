import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/main.dart';

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
      final localDataSource = Get.find<LocalDataSource>();
      await localDataSource.resetUser();
      navigatorKey.currentState?.pushNamedAndRemoveUntil(Routes.kLogInPage, ModalRoute.withName(Routes.kLogInPage));
    }
    handler.next(err);
  }
}
