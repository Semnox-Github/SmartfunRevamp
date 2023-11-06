import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_performance_dio/firebase_performance_dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:semnox/core/domain/entities/data.dart';
import 'package:semnox/core/domain/entities/splash_screen/get_base_url_response.dart';

part 'parafait_api.g.dart';

String kGetBaseUrl = dotenv.env['GET_BASE_URL']!;

@RestApi()
abstract class ParafaitApi {
  factory ParafaitApi({String token = ''}) {
    final dio = Dio();
    dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        request: true,
        error: true,
        compact: true,
        maxWidth: 150,
      ),
      DioFirebasePerformanceInterceptor(),
    ]);

    dio.options = BaseOptions(
      baseUrl: kGetBaseUrl,
      receiveTimeout: const Duration(seconds: 20),
      connectTimeout: const Duration(seconds: 20),
      headers: {
        HttpHeaders.authorizationHeader: token,
        HttpHeaders.contentTypeHeader: 'application/json',
        'Origin': dotenv.env['CENTRAL_API_ORIGIN'],
      },
    );
    return _ParafaitApi(dio);
  }

  @POST('ClientApp/ClientAppVersion')
  Future<Data<GetBaseUrlResponse>> getBaseURLFromCentral(
    @Query('appId') String appId,
    @Query('buildNumber') String buildNumber,
    @Query('generatedTime') String generatedTime,
    @Query('securityCode') String securityCode,
    @Body() Map<String, dynamic> body,
  );
}
