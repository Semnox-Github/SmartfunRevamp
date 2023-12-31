import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_performance_dio/firebase_performance_dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:semnox/core/api/api_interceptor.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/domain/entities/card_details/account_credit_plus_dto_list.dart';
import 'package:semnox/core/domain/entities/card_details/card_activity.dart';
import 'package:semnox/core/domain/entities/card_details/card_activity_details.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/entities/data.dart';
import 'package:semnox/core/domain/entities/feedback/survey_details.dart';
import 'package:semnox/core/domain/entities/feedback/survey_request.dart';
import 'package:semnox/core/domain/entities/gameplays/account_gameplays.dart';
import 'package:semnox/core/domain/entities/language/language_container_dto.dart';
import 'package:semnox/core/domain/entities/login/create_otp_response.dart';
import 'package:semnox/core/domain/entities/lookups/lookups_dto.dart';
import 'package:semnox/core/domain/entities/membership/membership_info.dart';
import 'package:semnox/core/domain/entities/membership/membership_tier.dart';
import 'package:semnox/core/domain/entities/notifications/notifications_response.dart';
import 'package:semnox/core/domain/entities/notifications_register/notification_register_entity.dart';
import 'package:semnox/core/domain/entities/orders/order_details.dart';
import 'package:semnox/core/domain/entities/orders/order_status.dart';
import 'package:semnox/core/domain/entities/payment/hosted_payment_gateway.dart';
import 'package:semnox/core/domain/entities/payment/payment_mode.dart';
import 'package:semnox/core/domain/entities/sign_up/sites_response.dart';
import 'package:semnox/core/domain/entities/sign_up/user_metadata.dart';
import 'package:semnox/core/domain/entities/splash_screen/app_config_response.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

part 'smart_fun_api.g.dart';

@RestApi()
abstract class SmartFunApi {
  factory SmartFunApi([String baseUrl = '', String token = '']) {
    final dio = Dio();
    dio.interceptors.addAll([
      AuthorizationInterceptor(),
      PrettyDioLogger(
        requestBody: false,
        responseBody: false,
        requestHeader: false,
        responseHeader: false,
        request: false,
        error: true,
        compact: true,
        maxWidth: 150,
      ),
      DioFirebasePerformanceInterceptor(),
    ]);
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: const Duration(seconds: 20),
      connectTimeout: const Duration(seconds: 20),
      headers: {
        HttpHeaders.authorizationHeader: token,
        HttpHeaders.contentTypeHeader: 'application/json',
        'Origin': dotenv.env['CENTRAL_API_ORIGIN'],
      },
    );
    return _SmartFunApi(dio);
  }

  @POST('Login/AuthenticateUsers')
  Future<HttpResponse> authenticateSystemUser(@Body() Map<String, dynamic> body);

  @POST('Customer/Customers/{CustomerId}/Delete')
  Future<void> deleteProfile(@Path('CustomerId') int customerId);

  @POST('Transaction/Transactions')
  Future<Data<EstimateTransactionResponse>> estimateTransaction(@Body() Map<String, dynamic> body);

  //----- Transaction -----// <-

  //----- Gameplays -----// ->

  @GET('Transaction/Gameplays')
  Future<ListDataWrapper<AccountGameplays>> getAccountGamePlays(
    @Query('accountId') int accountId, {
    @Query('gameplayId') bool urlId = true,
  });

  @GET('Communication/MessagingRequests?MessageType=A')
  Future<ListDataWrapper<NotificationsResponse>> getAllNotifications(
    @Query('From_Date') String fromDate,
    @Query('To_Date') String toDate,
    @Query('CustomerId') String customerId,
  );

  @GET('Organization/SiteContainer')
  Future<Data<GetAllSitesResponse>> getAllSites();

  @GET('CustomerApp/CustomerAppConfiguration')
  Future<Data<AppConfigResponse>> getAppConfiguration(@Query('siteId') int siteId);

  @GET('Common/Images')
  Future<HttpResponse> getAppImages(
    @Query('imageType') String imageType,
    @Query('lastModifiedDate') String lastModifiedDate,
  );

  @GET('Common/Images')
  Future<HttpResponse> getAppProductsImages(
    @Query('lastModifiedDate') String lastModifiedDate,
    @Query('imageType') String imageType,
  );

  @GET('Customer/Account/Accounts')
  Future<ListDataWrapper<CardDetails>> getBonusSummary(
    @Query('accountNumber') String accountNumber, {
    @Query('activeRecordsOnly') bool activeRecordsOnly = true,
    @Query('buildChildRecords') bool buildChildRecords = true,
  });

  @GET('Customer/Account/{accountId}/AccountActivity')
  Future<ListDataWrapper<CardActivity>> getCardActivityDetail(
    @Path('accountId') @Query('accountId') String accountId,
  );

  // /api/Transaction/Gameplays?gameplayId=true&accountId=244065

  //----- Gameplays -----// <-

  //----- Accoount Details -----// ->
  @GET('Customer/Account/AccountSummaryView')
  Future<ListDataWrapper<CardDetails>> getCardDetails(
    @Query('accountNumber') String accountNumber, {
    @Query('isActive') String isActive = 'Y',
  });

  @GET('Customer/ContactTypes')
  Future<HttpResponse> getContactType();

  @GET('Customer/Customers')
  Future<ListDataWrapper<CustomerDTO>> getCustomerByPhoneorEmail(
    @Query('phoneoremail') String phoneOrEmail, {
    @Query('buildChildRecords') bool buildChildRecords = true,
  });

  @GET('Customer/FeedbackSurvey/FeedbackSurveys')
  Future<ListDataWrapper<SurveyDetailsResponse>> getCustomerFeedbackActions({
    @Query('loadActiveChild') bool loadActiveChild = true,
    @Query('buildChildRecords') bool buildChildRecords = true,
    @Query('posMachine') String posMachine = 'CustomerApp',
  });

  @GET('Transaction/Transactions')
  Future<ListDataWrapper<OrderDetails>> getCustomerTransactions(
    @Query('customerId') String customerId, {
    @Query('buildChildRecords') bool buildChildRecords = true,
  });

  @GET('Transaction/CustomerTransactionStatus')
  Future<ListDataWrapper<OrderStatus>> getCustomerTransactionStatus(@Query('customerId') String customerId);

  @GET('ParafaitEnvironment/ExecutionContext')
  Future<HttpResponse> getExecutionContext({
    @Query('siteId') int? siteId,
    @Header(HttpHeaders.authorizationHeader) String? token,
    @Query('languageCode') String languageCode = 'en-US',
    @Query('posMachineName') String posMachineName = 'CustomerApp',
  });

  @GET('Customer/Account/{customerId}/AccountGamesSummary')
  Future<ListDataWrapper<AccountCreditPlusConsumptionDTO>> getGamesAccountSummart(
      @Path('customerId') String customerId);

  @GET('Common/FileResource')
  Future<ListDataWrapper<HomePageCMSResponse>> getHomePageCMS({
    @Query('defaultValueName') String defaultValueName = 'IMAGE_DIRECTORY',
    @Query('fileName') String fileName = 'CMSSmartFun.json',
    @Query('secure') bool secure = true,
  });

  @GET('Transaction/HostedPaymentGateways')
  Future<Data<HostedPaymentGateway>> getHostedPaymentGateways(
    @Query('hostedPaymentGateway') String hostedPaymentGateway,
    @Query('amount') double amount,
    @Query('transactionId') int transactionId,
  );

  @GET('Lookups/LookupsContainer')
  Future<Data<LookupsContainer>> getLookups(@Query('siteId') String siteId, @Query('rebuildCache') bool rebuildCache);

  @GET('Customer/Membership/MembershipsContainer')
  Future<MembershipContainerResponse> getMembershipContainer(
    @Query('siteId') int siteId, {
    @Query('rebuildCache') bool rebuildCachec = false,
  });

  @GET('Customer/{CustomerId}/Summary')
  Future<Data<MembershipInfo>> getMembershipInfo(@Path('CustomerId') int customerId);

  @GET('Configuration/ParafaitDefaultContainer')
  Future<Data<ParafaitDefaultsResponse>> getParafaitDefaults(
    @Query('siteId') String siteId,
    @Query('userPkId') int userPkId,
    @Query('machineId') int machineId,
  );

  @GET('Configuration/LanguageContainer')
  Future<Data<LanguageContainerDTO>> getParafaitLanguages(
    @Query('siteId') String siteId,
  );

  //----- Transaction -----// ->

  @GET('Transaction/PaymentModes')
  Future<ListDataWrapper<PaymentMode>> getPaymentModes(
    @Query('siteId') String siteId, {
    @Query('isActive') int isActive = 1,
    @Query('paymentChannel') String paymentChannel = 'CUSTOMER_APP_PAYMENT',
  });

  @GET('Product/ProductPrice')
  Future<ListDataWrapper<CardProduct>> getProductsPrices(
    @Query('dateTime') String dateTime,
    @Header(HttpHeaders.authorizationHeader) String token, {
    @Query('menuType') String menuType = 'O',
    @Query('transactionProfileId') int transactionProfileId = -1,
    @Query('membershipId') int membershipId = -1,
  });

  @GET('Customer/CustomerUIMetadataContainer')
  Future<Data<UserMetaDataResponse>> getSignUpMetadata(
    @Query('siteId') String siteId, {
    @Query('hash') String? hash,
    @Query('rebuildCache') bool rebuildCache = false,
  });

  @GET('Localization/Headers')
  Future<HttpResponse> getStringsForLocalization(
    @Query('siteId') String siteId,
    @Query('languageId') String languageId,
    @Query('outputFormat') String outputForm,
  );

  @GET('Transaction/Transactions')
  Future<ListDataWrapper<OrderDetails>> getTransactionByTransactionId(
    @Query('transactionId') String transactionId, {
    @Query('buildReceipt') bool buildReceipt = true,
    @Query('buildChildRecords') bool buildChildRecords = true,
  });

  @GET('Transaction/Transactions')
  Future<ListDataWrapper<CardActivityDetails>> getTransactionDetail(
    @Query('transactionId') String transactionId, {
    @Query('buildReceipt') bool buildReceipt = true,
    @Query('buildChildRecords') bool buildChildRecords = true,
  });

  @GET('Customer/Account/LinkedAccountsSummary')
  Future<ListDataWrapper<CardDetails>> getUserCards(@Query('customerId') String customerId);

  @POST('Customer/Account/AccountService/LinkAccountToCustomers')
  Future<Data<String>> linkCardToCustomer(@Body() Map<String, dynamic> body);

  @POST('Customer/CustomerLogin')
  Future<Data<CustomerDTO>> loginUser(@Body() Map<String, dynamic> body);

  @POST('Customer/Account/AccountService/LostCard')
  Future<Data<String>> lostCard(@Body() Map<String, dynamic> body);

  @POST('Customer/FeedbackSurvey/FeedbackSurveyDataSet')
  Future<void> sendCustomerFeedback(
    @Body() List<SurveyRequest> body,
  );

  @POST('CommonServices/GenericOTP/Create')
  Future<Data<CreateOtpResponse>> sendOTP(@Body() Map<String, dynamic> body);

  @POST('Customer/PasswordReset')
  Future<void> sendResetPasswordLink(
    @Body() Map<String, dynamic> body,
  );

  @POST('/Customer/Customers')
  Future<Data<CustomerDTO>> signUpUser(@Body() Map<String, dynamic> body);

  @POST('Customer/Account/AccountService/TransferBalances')
  Future<Data<String>> transferBalance(@Body() Map<String, dynamic> body);
  @POST('Customer/Account/{accountId}/AccountIdentifier')
  Future<void> updateCardNickname(@Path('accountId') String accountId, @Body() Map<String, dynamic> body);

  ///Default code OTP 141448
  @POST('CommonServices/GenericOTP/{id}/Validate')
  Future<HttpResponse> validateOTP(
    @Body() Map<String, dynamic> body,
    @Path('id') otpId,
  );

  @GET('Communication/PushNotificationDevices')
  Future<ListDataWrapper<NotificationRegisterEntity>> checkNotificationTokenRegistered(
      @Query('customerId') int customerId);

  @POST('Communication/PushNotificationDevices')
  Future<HttpResponse> registerNotificationToken(
    @Body() List<NotificationRegisterEntity> body,
  );
}
