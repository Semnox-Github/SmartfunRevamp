import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/orders/order_details.dart';
import 'package:semnox/core/domain/repositories/orders_repository.dart';
import 'package:semnox/core/errors/failures.dart';

import '../../entities/card_details/transaction_details.dart';

class GetTransactionDetailUseCase {
  final OrdersRepository _repository;
  GetTransactionDetailUseCase(this._repository);
  Future<Either<Failure, OrderDetails>> call(String customerId) async {
    return await _repository.getTransactionDetail(customerId);
  }
}
