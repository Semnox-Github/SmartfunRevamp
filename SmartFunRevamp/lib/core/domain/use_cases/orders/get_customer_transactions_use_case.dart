import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/orders/order_details.dart';
import 'package:semnox/core/domain/repositories/orders_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetCustomerTransactionsUseCase {
  final OrdersRepository _repository;
  GetCustomerTransactionsUseCase(this._repository);
  Future<Either<Failure, List<OrderDetails>>> call(String customerId) async {
    return await _repository.getCustomerTransactions(customerId);
  }
}
