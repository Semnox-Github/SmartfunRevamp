import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:semnox/core/api/api_interceptor.dart';

part 'parafait_api.g.dart';

const String kGetBaseUrl = 'https://parafaitdevcentral.parafait.com/api/';

@RestApi(baseUrl: kGetBaseUrl)
abstract class ParafaitApi {
  factory ParafaitApi({String token = ''}) {
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
    return _ParafaitApi(dio);
  }

  @POST('ClientApp/ClientAppVersion')
  Future<HttpResponse> getBaseURLFromCentral(
    @Query('appId') String appId,
    @Query('buildNumber') String buildNumber,
    @Query('generatedTime') String generatedTime,
    @Query('securityCode') String securityCode,
    @Body() Map<String, dynamic> body,
  );
}
