
import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';
import '../../entities/buy_card/discount_coupon.dart';
import '../../entities/buy_card/estimate_transaction_response.dart';
import '../../entities/data.dart';
import '../../repositories/products_repositories.dart';

class DiscountCouponUseCase {
  final ProductsRepository _repository;
  DiscountCouponUseCase(this._repository);
  Future<Either<Failure, Data<AddCardProductResponse>>> call(int transactionId,Map<String, dynamic> body) async {
    return await _repository.AddDiscountCoupon(transactionId,body);
  }
}