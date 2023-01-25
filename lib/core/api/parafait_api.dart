import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:semnox/core/domain/entities/data.dart';
import 'package:semnox/core/domain/entities/splash_screen/get_base_url_response.dart';

part 'parafait_api.g.dart';

const String kGetBaseUrl = 'https://parafaitdevcentral.parafait.com/api/';

@RestApi(baseUrl: kGetBaseUrl)
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
      )
    ]);

    dio.options = BaseOptions(
      receiveTimeout: 20000,
      connectTimeout: 20000,
      headers: {
        'Authorization': token,
        'content-type': 'application/json',
        'Origin': 'mQ/btZP6wd74Sgd59JETzEtAkBO8QIL4KpE2pjz9hRg=',
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
