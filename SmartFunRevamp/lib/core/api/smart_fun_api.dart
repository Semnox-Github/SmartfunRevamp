import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:semnox/core/api/api_interceptor.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/domain/entities/card_details/account_credit_plus_dto_list.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/entities/data.dart';

import 'package:semnox/core/domain/entities/login/create_otp_response.dart';
import 'package:semnox/core/domain/entities/sign_up/sites_response.dart';
import 'package:semnox/core/domain/entities/splash_screen/authenticate_system_user.dart';
import 'package:semnox/core/domain/entities/payment/payment_mode.dart';
import 'package:semnox/core/domain/entities/payment/hosted_payment_gateway.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

part 'smart_fun_api.g.dart';

@RestApi()
abstract class SmartFunApi {
  factory SmartFunApi([String baseUrl = '', String token = '']) {
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
      receiveTimeout: 40000,
      connectTimeout: 40000,
      headers: {
        'Authorization': token,
        'content-type': 'application/json',
      },
    );
    return _SmartFunApi(dio);
  }

  @POST('Login/AuthenticateSystemUsers')
  Future<Data<SystemUser>> authenticateSystemUser(@Body() Map<String, dynamic> body);

  @POST('Customer/CustomerLogin')
  Future<Data<CustomerDTO>> loginUser(@Body() Map<String, dynamic> body);

  @POST('/Customer/Customers')
  Future<Data<CustomerDTO>> signUpUser(@Body() Map<String, dynamic> body);

  @GET('Product/ProductPrice')
  Future<ListDataWrapper<CardProduct>> getProductsPrices(
    @Query('dateTime') String dateTime, {
    @Query('menuType') String menuType = 'O',
    @Query('transactionProfileId') int transactionProfileId = -1,
    @Query('membershipId') int membershipId = -1,
  });

  @POST('CommonServices/GenericOTP/Create')
  Future<Data<CreateOtpResponse>> sendOTP(@Body() Map<String, dynamic> body);

  ///Default code OTP 141448
  @POST('CommonServices/GenericOTP/{id}/Validate')
  Future<HttpResponse> validateOTP(
    @Body() Map<String, dynamic> body,
    @Path('id') otpId,
  );

  @GET('Customer/Customers')
  Future<ListDataWrapper<CustomerDTO>> getCustomerByPhoneorEmail(
    @Query('phoneoremail') String phoneOrEmail, {
    @Query('buildChildRecords') bool buildChildRecords = true,
  });
  @GET('ParafaitEnvironment/ExecutionContext')
  Future<HttpResponse> getExecutionController(
    @Query('siteId') int siteId, {
    @Query('posMachineName') String posMachineName = 'webplatform',
    @Query('languageCode') String languageCode = 'en-US',
  });
  @POST('Transaction/Transactions')
  Future<Data<EstimateTransactionResponse>> estimateTransaction(@Body() Map<String, dynamic> body);

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
  Future<Data<GetAllSitesResponse>> getAllSites();

  @GET('Common/Images')
  Future<HttpResponse> getAppProductsImages(
    @Query('lastModifiedDate') String lastModifiedDate,
    @Query('imageType') String imageType,
  );

  @GET('Customer/CustomerUIMetadataContainer')
  Future<HttpResponse> getSignUpMetadata({
    @Query('siteId') String siteId = '1010',
    @Query('hash') String? hash,
    @Query('rebuildCache') bool rebuildCache = false,
  });

  //----- Transaction -----// ->

  //
  @GET('Transaction/PaymentModes')
  Future<ListDataWrapper<PaymentMode>> getPaymentModes({
    @Query('siteId') String siteId = '1010',
    @Query('isActive') int isActive = 1,
  });

  @GET('Transaction/HostedPaymentGateways')
  Future<Data<HostedPaymentGateway>> getHostedPaymentGateways(
    @Query('hostedPaymentGateway') String hostedPaymentGateway,
    @Query('amount') double amount,
    @Query('transactionId') int transactionId,
  );

  @GET('Customer/Account/AccountSummaryView')
  Future<ListDataWrapper<CardDetails>> getCardDetails(
    @Query('accountNumber') String accountNumber, {
    @Query('isActive') String isActive = 'Y',
  });

  @GET('Customer/Account/Accounts')
  Future<ListDataWrapper<CardDetails>> getBonusSummary(
    @Query('accountNumber') String accountNumber, {
    @Query('activeRecordsOnly') bool activeRecordsOnly = true,
    @Query('buildChildRecords') bool buildChildRecords = true,
  });

  @GET('Customer/Account/LinkedAccountsSummary')
  Future<ListDataWrapper<CardDetails>> getUserCards(@Query('customerId') String customerId);

  @GET('Customer/Account/{customerId}/AccountGamesSummary')
  Future<ListDataWrapper<AccountCreditPlusConsumptionDTO>> getGamesAccountSummart(@Path('customerId') String customerId);
}
