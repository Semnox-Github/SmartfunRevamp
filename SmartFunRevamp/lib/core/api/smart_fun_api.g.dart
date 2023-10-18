// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_fun_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _SmartFunApi implements SmartFunApi {
  _SmartFunApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<dynamic>> authenticateSystemUser(
      Map<String, dynamic> body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result =
        await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Login/AuthenticateUsers',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<void> deleteProfile(int customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'Customer/Customers/${customerId}/Delete',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<Data<EstimateTransactionResponse>> estimateTransaction(
      Map<String, dynamic> body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Data<EstimateTransactionResponse>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Transaction/Transactions',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Data<EstimateTransactionResponse>.fromJson(
      _result.data!,
      (json) =>
          EstimateTransactionResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ListDataWrapper<AccountGameplays>> getAccountGamePlays(
    int accountId, {
    bool urlId = true,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'accountId': accountId,
      r'gameplayId': urlId,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDataWrapper<AccountGameplays>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Transaction/Gameplays',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ListDataWrapper<AccountGameplays>.fromJson(
      _result.data!,
      (json) => AccountGameplays.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ListDataWrapper<NotificationsResponse>> getAllNotifications(
    String fromDate,
    String toDate,
    String customerId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'From_Date': fromDate,
      r'To_Date': toDate,
      r'CustomerId': customerId,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDataWrapper<NotificationsResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Communication/MessagingRequests?MessageType=A',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ListDataWrapper<NotificationsResponse>.fromJson(
      _result.data!,
      (json) => NotificationsResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<Data<GetAllSitesResponse>> getAllSites() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Data<GetAllSitesResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Organization/SiteContainer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Data<GetAllSitesResponse>.fromJson(
      _result.data!,
      (json) => GetAllSitesResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<Data<AppConfigResponse>> getAppConfiguration(int siteId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'siteId': siteId};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Data<AppConfigResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'CustomerApp/CustomerAppConfiguration',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Data<AppConfigResponse>.fromJson(
      _result.data!,
      (json) => AppConfigResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<HttpResponse<dynamic>> getAppImages(
    String imageType,
    String lastModifiedDate,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'imageType': imageType,
      r'lastModifiedDate': lastModifiedDate,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Common/Images',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<dynamic>> getAppProductsImages(
    String lastModifiedDate,
    String imageType,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'lastModifiedDate': lastModifiedDate,
      r'imageType': imageType,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Common/Images',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<ListDataWrapper<CardDetails>> getBonusSummary(
    String accountNumber, {
    bool activeRecordsOnly = true,
    bool buildChildRecords = true,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'accountNumber': accountNumber,
      r'activeRecordsOnly': activeRecordsOnly,
      r'buildChildRecords': buildChildRecords,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDataWrapper<CardDetails>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Customer/Account/Accounts',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ListDataWrapper<CardDetails>.fromJson(
      _result.data!,
      (json) => CardDetails.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ListDataWrapper<CardActivity>> getCardActivityDetail(
      String accountId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'accountId': accountId};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDataWrapper<CardActivity>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Customer/Account/${accountId}/AccountActivity',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ListDataWrapper<CardActivity>.fromJson(
      _result.data!,
      (json) => CardActivity.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ListDataWrapper<CardDetails>> getCardDetails(
    String accountNumber, {
    String isActive = 'Y',
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'accountNumber': accountNumber,
      r'isActive': isActive,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDataWrapper<CardDetails>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Customer/Account/AccountSummaryView',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ListDataWrapper<CardDetails>.fromJson(
      _result.data!,
      (json) => CardDetails.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<HttpResponse<dynamic>> getContactType() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Customer/ContactTypes',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<ListDataWrapper<CustomerDTO>> getCustomerByPhoneorEmail(
    String phoneOrEmail, {
    bool buildChildRecords = true,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'phoneoremail': phoneOrEmail,
      r'buildChildRecords': buildChildRecords,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDataWrapper<CustomerDTO>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Customer/Customers',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ListDataWrapper<CustomerDTO>.fromJson(
      _result.data!,
      (json) => CustomerDTO.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ListDataWrapper<SurveyDetailsResponse>> getCustomerFeedbackActions({
    bool loadActiveChild = true,
    bool buildChildRecords = true,
    String posMachine = 'CustomerApp',
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'loadActiveChild': loadActiveChild,
      r'buildChildRecords': buildChildRecords,
      r'posMachine': posMachine,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDataWrapper<SurveyDetailsResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Customer/FeedbackSurvey/FeedbackSurveys',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ListDataWrapper<SurveyDetailsResponse>.fromJson(
      _result.data!,
      (json) => SurveyDetailsResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ListDataWrapper<OrderDetails>> getCustomerTransactions(
    String customerId, {
    bool buildChildRecords = true,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'customerId': customerId,
      r'buildChildRecords': buildChildRecords,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDataWrapper<OrderDetails>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Transaction/Transactions',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ListDataWrapper<OrderDetails>.fromJson(
      _result.data!,
      (json) => OrderDetails.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ListDataWrapper<OrderStatus>> getCustomerTransactionStatus(
      String customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'customerId': customerId};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDataWrapper<OrderStatus>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Transaction/CustomerTransactionStatus',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ListDataWrapper<OrderStatus>.fromJson(
      _result.data!,
      (json) => OrderStatus.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<HttpResponse<dynamic>> getExecutionContext({
    int? siteId,
    String? token,
    String languageCode = 'en-US',
    String posMachineName = 'CustomerApp',
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'siteId': siteId,
      r'languageCode': languageCode,
      r'posMachineName': posMachineName,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'ParafaitEnvironment/ExecutionContext',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<ListDataWrapper<AccountCreditPlusConsumptionDTO>>
      getGamesAccountSummart(String customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDataWrapper<AccountCreditPlusConsumptionDTO>>(
            Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
                .compose(
                  _dio.options,
                  'Customer/Account/${customerId}/AccountGamesSummary',
                  queryParameters: queryParameters,
                  data: _data,
                )
                .copyWith(
                    baseUrl: _combineBaseUrls(
                  _dio.options.baseUrl,
                  baseUrl,
                ))));
    final value = ListDataWrapper<AccountCreditPlusConsumptionDTO>.fromJson(
      _result.data!,
      (json) => AccountCreditPlusConsumptionDTO.fromJson(
          json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ListDataWrapper<HomePageCMSResponse>> getHomePageCMS({
    String defaultValueName = 'IMAGE_DIRECTORY',
    String fileName = 'CMSSmartFun.json',
    bool secure = true,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'defaultValueName': defaultValueName,
      r'fileName': fileName,
      r'secure': secure,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDataWrapper<HomePageCMSResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Common/FileResource',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ListDataWrapper<HomePageCMSResponse>.fromJson(
      _result.data!,
      (json) => HomePageCMSResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<Data<HostedPaymentGateway>> getHostedPaymentGateways(
    String hostedPaymentGateway,
    double amount,
    int transactionId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'hostedPaymentGateway': hostedPaymentGateway,
      r'amount': amount,
      r'transactionId': transactionId,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Data<HostedPaymentGateway>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Transaction/HostedPaymentGateways',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Data<HostedPaymentGateway>.fromJson(
      _result.data!,
      (json) => HostedPaymentGateway.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<Data<LookupsContainer>> getLookups(
    String siteId,
    bool rebuildCache,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'siteId': siteId,
      r'rebuildCache': rebuildCache,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Data<LookupsContainer>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Lookups/LookupsContainer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Data<LookupsContainer>.fromJson(
      _result.data!,
      (json) => LookupsContainer.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<MembershipContainerResponse> getMembershipContainer(
    int siteId, {
    bool rebuildCachec = false,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'siteId': siteId,
      r'rebuildCache': rebuildCachec,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MembershipContainerResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Customer/Membership/MembershipsContainer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = MembershipContainerResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Data<MembershipInfo>> getMembershipInfo(int customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Data<MembershipInfo>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Customer/${customerId}/Summary',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Data<MembershipInfo>.fromJson(
      _result.data!,
      (json) => MembershipInfo.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<Data<ParafaitDefaultsResponse>> getParafaitDefaults(
    String siteId,
    int userPkId,
    int machineId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'siteId': siteId,
      r'userPkId': userPkId,
      r'machineId': machineId,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Data<ParafaitDefaultsResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Configuration/ParafaitDefaultContainer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Data<ParafaitDefaultsResponse>.fromJson(
      _result.data!,
      (json) => ParafaitDefaultsResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<Data<LanguageContainerDTO>> getParafaitLanguages(String siteId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'siteId': siteId};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Data<LanguageContainerDTO>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Configuration/LanguageContainer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Data<LanguageContainerDTO>.fromJson(
      _result.data!,
      (json) => LanguageContainerDTO.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ListDataWrapper<PaymentMode>> getPaymentModes(
    String siteId, {
    int isActive = 1,
    String paymentChannel = 'CUSTOMER_APP_PAYMENT',
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'siteId': siteId,
      r'isActive': isActive,
      r'paymentChannel': paymentChannel,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDataWrapper<PaymentMode>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Transaction/PaymentModes',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ListDataWrapper<PaymentMode>.fromJson(
      _result.data!,
      (json) => PaymentMode.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ListDataWrapper<CardProduct>> getProductsPrices(
    String dateTime,
    String token, {
    String menuType = 'O',
    int transactionProfileId = -1,
    int membershipId = -1,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'dateTime': dateTime,
      r'menuType': menuType,
      r'transactionProfileId': transactionProfileId,
      r'membershipId': membershipId,
    };
    final _headers = <String, dynamic>{r'authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDataWrapper<CardProduct>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Product/ProductPrice',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ListDataWrapper<CardProduct>.fromJson(
      _result.data!,
      (json) => CardProduct.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<Data<UserMetaDataResponse>> getSignUpMetadata(
    String siteId, {
    String? hash,
    bool rebuildCache = false,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'siteId': siteId,
      r'hash': hash,
      r'rebuildCache': rebuildCache,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Data<UserMetaDataResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Customer/CustomerUIMetadataContainer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Data<UserMetaDataResponse>.fromJson(
      _result.data!,
      (json) => UserMetaDataResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<HttpResponse<dynamic>> getStringsForLocalization(
    String siteId,
    String languageId,
    String outputForm,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'siteId': siteId,
      r'languageId': languageId,
      r'outputFormat': outputForm,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Localization/Headers',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<ListDataWrapper<OrderDetails>> getTransactionByTransactionId(
    String transactionId, {
    bool buildReceipt = true,
    bool buildChildRecords = true,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'transactionId': transactionId,
      r'buildReceipt': buildReceipt,
      r'buildChildRecords': buildChildRecords,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDataWrapper<OrderDetails>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Transaction/Transactions',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ListDataWrapper<OrderDetails>.fromJson(
      _result.data!,
      (json) => OrderDetails.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ListDataWrapper<CardActivityDetails>> getTransactionDetail(
    String transactionId, {
    bool buildReceipt = true,
    bool buildChildRecords = true,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'transactionId': transactionId,
      r'buildReceipt': buildReceipt,
      r'buildChildRecords': buildChildRecords,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDataWrapper<CardActivityDetails>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Transaction/Transactions',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ListDataWrapper<CardActivityDetails>.fromJson(
      _result.data!,
      (json) => CardActivityDetails.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ListDataWrapper<CardDetails>> getUserCards(String customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'customerId': customerId};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDataWrapper<CardDetails>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Customer/Account/LinkedAccountsSummary',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ListDataWrapper<CardDetails>.fromJson(
      _result.data!,
      (json) => CardDetails.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<Data<String>> linkCardToCustomer(Map<String, dynamic> body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Data<String>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Customer/Account/AccountService/LinkAccountToCustomers',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Data<String>.fromJson(
      _result.data!,
      (json) => json as String,
    );
    return value;
  }

  @override
  Future<Data<CustomerDTO>> loginUser(Map<String, dynamic> body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Data<CustomerDTO>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Customer/CustomerLogin',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Data<CustomerDTO>.fromJson(
      _result.data!,
      (json) => CustomerDTO.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<Data<String>> lostCard(Map<String, dynamic> body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Data<String>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Customer/Account/AccountService/LostCard',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Data<String>.fromJson(
      _result.data!,
      (json) => json as String,
    );
    return value;
  }

  @override
  Future<void> sendCustomerFeedback(List<SurveyRequest> body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = body.map((e) => e.toJson()).toList();
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'Customer/FeedbackSurvey/FeedbackSurveyDataSet',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<Data<CreateOtpResponse>> sendOTP(Map<String, dynamic> body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Data<CreateOtpResponse>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'CommonServices/GenericOTP/Create',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Data<CreateOtpResponse>.fromJson(
      _result.data!,
      (json) => CreateOtpResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<void> sendResetPasswordLink(Map<String, dynamic> body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'Customer/PasswordReset',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<Data<CustomerDTO>> signUpUser(Map<String, dynamic> body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Data<CustomerDTO>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/Customer/Customers',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Data<CustomerDTO>.fromJson(
      _result.data!,
      (json) => CustomerDTO.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<Data<String>> transferBalance(Map<String, dynamic> body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Data<String>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'Customer/Account/AccountService/TransferBalances',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Data<String>.fromJson(
      _result.data!,
      (json) => json as String,
    );
    return value;
  }

  @override
  Future<void> updateCardNickname(
    String accountId,
    Map<String, dynamic> body,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'Customer/Account/${accountId}/AccountIdentifier',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<HttpResponse<dynamic>> validateOTP(
    Map<String, dynamic> body,
    dynamic otpId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result =
        await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'CommonServices/GenericOTP/${otpId}/Validate',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
