import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/orders/order_details.dart';

import 'package:semnox/core/domain/repositories/orders_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final SmartFunApi _api;

  OrdersRepositoryImpl(this._api);

  @override
  Future<Either<Failure, List<OrderDetails>>> getCustomerTransactions(String customerId) async {
    try {
      final response = await _api.getCustomerTransactions(customerId);
      Logger().d('Transactions ${response.data.length}');
      return Right(response.data);
    } on DioError catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    } catch (e) {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, OrderDetails>> getTransactionDetail(String transactionId) async {
    try {
      final response = await _api.getTransactionByTransactionId(transactionId);
      Logger().d('Transaction Detail ${response.data.length}');
      return Right(response.data.first);
    } on DioError catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    } catch (e) {
      Logger().e(e);
      return Left(ServerFailure(''));
    }
  }
}
