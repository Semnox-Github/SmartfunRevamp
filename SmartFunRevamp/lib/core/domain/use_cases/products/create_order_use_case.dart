import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/buy_card/create_order_response.dart';
import '../../../errors/failures.dart';
import '../../entities/data.dart';
import '../../repositories/products_repositories.dart';

class CreateOrderUseCase {
  final ProductsRepository _repository;
  CreateOrderUseCase(this._repository);
  Future<Either<Failure, Data<CreateOrderResponse>>> call(Map<String, dynamic> body) async {
    return await _repository.createOrder(body);
  }
}