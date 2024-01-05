import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../errors/failures.dart';
import '../../entities/data.dart';
import '../../repositories/products_repositories.dart';

class LinkToCustomerUseCase {
  final ProductsRepository _repository;
  LinkToCustomerUseCase(this._repository);
   call(int transactionId,int body) async {
    return await _repository.linkCustomer(transactionId,body);
  }
}