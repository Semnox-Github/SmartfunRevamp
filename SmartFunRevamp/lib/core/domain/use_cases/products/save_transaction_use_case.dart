import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:semnox/core/domain/entities/buy_card/discount_coupon.dart';

import 'package:semnox/core/errors/failures.dart';

import '../../entities/data.dart';
import '../../repositories/products_repositories.dart';

class SaveTransactionUseCase {
  final ProductsRepository _repository;
  SaveTransactionUseCase(this._repository);
  Future<Either<Failure, Data<DiscountCountResponse>>> call(int transactionId) async {
    return await _repository.AddSaveTransaction(transactionId);
  }
}