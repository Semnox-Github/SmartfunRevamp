import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/orders/order_details.dart';
import 'package:semnox/core/domain/entities/orders/order_status.dart';

import 'package:semnox/core/errors/failures.dart';

abstract class OrdersRepository {
  Future<Either<Failure, List<OrderDetails>>> getCustomerTransactions(
      String customerId);
  Future<Either<Failure, OrderDetails>> getTransactionDetail(
      String transactionId);
  Future<Either<Failure, List<OrderStatus>>> getCustomerTransactionStatus(
      String transactionId);
}
