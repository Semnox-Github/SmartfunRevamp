import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/orders/order_status.dart';
import 'package:semnox/core/domain/repositories/orders_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetCustomerTransactionStatusUseCase {
  final OrdersRepository _repository;
  GetCustomerTransactionStatusUseCase(this._repository);
  Future<Either<Failure, List<OrderStatus>>> call(String customerId) async {
    return await _repository.getCustomerTransactionStatus(customerId);
  }
}
