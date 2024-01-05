import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/buy_card/create_transaction_response.dart';
import '../../../errors/failures.dart';
import '../../entities/data.dart';
import '../../repositories/products_repositories.dart';

class CreateTransactionUseCase {
  final ProductsRepository _repository;
  CreateTransactionUseCase(this._repository);
  Future<Either<Failure, Data<CreateTransactionResponse>>> call(int transactionId,Map<String, dynamic> body) async {
    return await _repository.createTransaction(transactionId,body);
  }
}