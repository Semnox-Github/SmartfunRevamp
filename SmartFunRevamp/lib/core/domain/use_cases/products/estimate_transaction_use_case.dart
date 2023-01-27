import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/domain/repositories/products_repositories.dart';
import 'package:semnox/core/errors/failures.dart';

class EstimateTransactionUseCase {
  final ProductsRepository _repository;
  EstimateTransactionUseCase(this._repository);
  Future<Either<Failure, EstimateTransactionResponse>> call(Map<String, dynamic> body) async {
    return await _repository.getEstimateTransaction(body);
  }
}
