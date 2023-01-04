import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:semnox/core/api/api_interceptor.dart';
import 'package:semnox/core/environment.dart';

part 'smart_fun_api.g.dart';

@RestApi(baseUrl: Environment.baseUrl)
abstract class SmartFunApi {
  factory SmartFunApi([String token = '', String baseUrl = Environment.baseUrl]) {
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
      baseUrl: baseUrl,
      receiveTimeout: 20000,
      connectTimeout: 20000,
      headers: {
        'Authorization': token,
        'content-type': 'application/json',
      },
    );
    return _SmartFunApi(dio);
  }

  @POST('ClientApp/ClientAppVersion')
  Future<HttpResponse> getBaseURLFromCentral(
    @Query('appId') String appId,
    @Query('buildNumber') String buildNumber,
    @Query('generatedTime') String generatedTime,
    @Query('securityCode') String securityCode,
  );

  //This use the response from getBaseURLFromCentral request
  @POST('Login/AuthenticateUsers')
  Future<HttpResponse> loginUser(@Body() Map<String, dynamic> body);

  @POST('')
  Future<HttpResponse> signUpUser(@Body() Map<String, dynamic> body);

  @GET('Configuration/ParafaitDefaultContainer')
  Future<HttpResponse> getParafaitDefaults(
    @Query('siteId') String siteId,
    @Query('userPkId') String userPkId,
    @Query('machineId') String machineId,
  );

  @GET('Configuration/LanguageContainer')
  Future<HttpResponse> getParafaitLanguages(
    @Query('siteId') String siteId,
  );

  @GET('Localization/Headers')
  Future<HttpResponse> getStringsForLocalization(
    @Query('siteId') String siteId,
    @Query('languageId') String languageId,
    @Query('outputForm') String outputForm,
  );

  @GET('Common/Images')
  Future<HttpResponse> getAppImages(
    @Query('imageType') String imageType,
    @Query('lastModifiedDate') String lastModifiedDate,
  );

  @GET('Customer/ContactTypes')
  Future<HttpResponse> getContactType();

  @GET('api/WebCMS/CMSModules')
  Future<HttpResponse> getHomePageCMS(
    @Query('moduleName') String moduleName,
    @Query('isActive') String isActive,
    @Query('buildChildRecords') String buildChildRecords,
    @Query('activeChildRecords') String activeChildRecords,
  );

  @GET('Organization/SiteContainer')
  Future<HttpResponse> getAllSites();

  @GET('Common/Images')
  Future<HttpResponse> getAppProductsImages(
    @Query('lastModifiedDate') String lastModifiedDate,
    @Query('imageType') String imageType,
  );
}
