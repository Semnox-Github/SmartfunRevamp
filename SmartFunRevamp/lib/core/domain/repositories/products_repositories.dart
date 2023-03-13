import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/errors/failures.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<CardProduct>>> getProductPrice();
  Future<Either<Failure, List<CardProduct>>> getProductPriceBySite(int siteId);
  Future<Either<Failure, EstimateTransactionResponse>> getEstimateTransaction(Map<String, dynamic> body);
}
