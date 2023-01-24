import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'server_exception.dart';
import 'api_response.dart';

class ParafaitServer {
  ExecutionContextDTO? executionContext;
  ParafaitServer(this.executionContext) {
    Map<String, dynamic> header = {"Content-Type": "application/json"};
    if (executionContext?.authToken != null) {
      header["Authorization"] = executionContext?.authToken;
    }
    dio = Dio(BaseOptions(baseUrl: executionContext!.apiUrl!, headers: header));
    dio.interceptors.addAll(
      [
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
      ],
    );
  }

  late final Map<String, dynamic> _defaultQueryParams = {};
  late Dio dio;

  Future<APIResponse> get<T>(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      log('''
            ${"*" * 10}

            Server Url: ${executionContext?.apiUrl}
            API End Point: $path 
            Type: GET
            queryParameters: $queryParameters

            defaultQueryParameter : $_defaultQueryParams

            Auth Token: ${executionContext?.authToken}

            ${"*" * 10}
      ''');

      final params = queryParameters ?? {};
      if (_defaultQueryParams.isNotEmpty) params.addAll(_defaultQueryParams);
      // final hasSlash = dio.options.baseUrl.endsWith("/");

      Response response = await dio.get(getFormattedPath(path), queryParameters: params);
      return APIResponse(data: response.data, header: response.headers.map);
    } on DioError catch (e) {
      handelException(e);
    } catch (e) {
      throw AppException(e.toString(), "");
    }
    return APIResponse(data: null, header: {});
  }

  Future<APIResponse> post<T>(String path, body, {Map<String, dynamic>? queryParameters}) async {
    try {
      log('''
              ${"*" * 10}

              Server Url: ${executionContext?.apiUrl}
              API End Point: $path 
              Type: POST
              queryParameters: $queryParameters
              body: $body

              Auth Token: ${executionContext?.authToken}

              ${"*" * 10}

      ''');
      Response response = await dio.post(getFormattedPath(path), data: body, queryParameters: queryParameters);
      return APIResponse(data: response.data, header: response.headers.map);
    } on DioError catch (e) {
      // handelException(e);
      if (e.response?.statusCode == 404) {
        throw AppException('Not Found');
      }
      final message = json.decode(e.response.toString());
      throw AppException(message['data']);
    } catch (e) {
      throw AppException(e.toString(), "");
    }
    //return APIResponse(data: null, header: {});
  }

  String getFormattedPath(String path) {
    if (dio.options.baseUrl.endsWith("/")) {
      if (path.startsWith("/")) {
        return path.substring(1);
      }
      return path;
    }
    if (!path.startsWith("/")) {
      return "/$path";
    }
    return path;
  }

  void handelException(DioError e) {
    // log(e.message);
    switch (e.type) {
      case DioErrorType.connectTimeout:
        throw AppException("Connection Timeout while reaching server", "Connection Timeout : ");

      case DioErrorType.sendTimeout:
        throw AppException("Connection Timeout while Sending data to server", "Send Timeout : ");

      case DioErrorType.receiveTimeout:
        throw AppException("Connection Timeout while recieving data from server", "Recieve Timeout : ");

      case DioErrorType.response:
        switch (e.response?.statusCode) {
          case 400:
            throw BadRequestException(e.response?.data["data"]?.toString() ?? e.response?.statusMessage ?? "");
          case 401:
          case 403:
            throw UnauthorizedException(e.response?.statusMessage.toString() ?? "");
          case 404:
            throw NotFoundException(e.response?.statusMessage.toString() ?? "");

          case 422:
            throw InvalidInputException(e.response?.data["message"].toString() ?? "");
          case 500:
          default:
            throw FetchDataException('Error occurred while Communication with Server: ${e.message}');
        }

      case DioErrorType.cancel:
        throw AppException("Request was canceled", "Cancel:");

      case DioErrorType.other:
        throw FetchDataException(e.error?.toString() ?? "Unknown Error occured while Requesting");
    }
  }
}
