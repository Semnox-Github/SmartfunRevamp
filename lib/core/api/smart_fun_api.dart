import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:semnox/core/api/api_interceptor.dart';
import 'package:semnox/core/environment.dart';

part 'smart_fun_api.g.dart';

@RestApi(baseUrl: Environment.baseUrl)
abstract class SmartFunApi {
  factory SmartFunApi([String token = '']) {
    final dio = Dio();
    dio.interceptors.addAll([
      AuthorizationInterceptor(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        request: true,
        error: true,
        compact: true,
        maxWidth: 150,
      )
    ]);

    dio.options = BaseOptions(
      receiveTimeout: 20000,
      connectTimeout: 20000,
      headers: {
        'Authorization': token,
        'content-type': 'application/json',
      },
    );
    return _SmartFunApi(dio);
  }
  @POST('Login/AuthenticateUsers')
  Future<HttpResponse> loginUser(@Body() Map<String, dynamic> body);
}
