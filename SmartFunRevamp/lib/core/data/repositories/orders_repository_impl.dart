import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/orders/order_details.dart';
import 'package:semnox/core/domain/entities/orders/order_status.dart';

import 'package:semnox/core/domain/repositories/orders_repository.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/utils/extensions.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final SmartFunApi _api;

  OrdersRepositoryImpl(this._api);

  @override
  Future<Either<Failure, List<OrderDetails>>> getCustomerTransactions(String customerId) async {
    try {
      final response = await _api.getCustomerTransactions(customerId);
      Logger().d('Transactions ${response.data.length}');
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, List<OrderStatus>>> getCustomerTransactionStatus(String customerId) async {
    try {
      final response = await _api.getCustomerTransactionStatus(customerId);
      Logger().d('Transactions ${response.data.length}');
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, OrderDetails>> getTransactionDetail(String transactionId) async {
    try {
      final response = await _api.getTransactionByTransactionId(transactionId);
      Logger().d('Transaction Detail ${response.data.length}');
      return Right(response.data.first);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }
}
