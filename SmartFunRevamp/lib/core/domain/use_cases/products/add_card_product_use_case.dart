

import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../errors/failures.dart';
import '../../entities/buy_card/estimate_transaction_response.dart';
import '../../entities/data.dart';
import '../../repositories/products_repositories.dart';

class AddCardProductUseCase {
  final ProductsRepository _repository;
  AddCardProductUseCase(this._repository);
  Future<Either<Failure, Data<AddCardProductResponse>>> call(int transactionId,List<Map<String, dynamic>> body) async {
    return await _repository.addCardProduct(transactionId,body);
  }
}