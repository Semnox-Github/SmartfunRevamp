import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/repositories/products_repositories.dart';
import 'package:semnox/core/errors/failures.dart';

class GetProductsPriceUseCase {
  final ProductsRepository _repository;
  GetProductsPriceUseCase(this._repository);
  Future<Either<Failure, List<CardProduct>>> call(int siteId) async {
    return await _repository.getProductPrice(siteId);
  }
}
