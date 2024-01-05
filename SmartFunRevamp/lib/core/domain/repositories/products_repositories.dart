import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/errors/failures.dart';

import '../entities/buy_card/create_order_response.dart';
import '../entities/buy_card/create_transaction_response.dart';
import '../entities/buy_card/discount_coupon.dart';
import '../entities/data.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<CardProduct>>> getProductPrice(int siteId);
  Future<Either<Failure, Data<AddCardProductResponse>>> AddDiscountCoupon(int transactionId,Map<String, dynamic> body);
  Future<Either<Failure, Data<DiscountCountResponse>>> AddSaveTransaction(int transactionId);
  Future<Either<Failure, EstimateTransactionResponse>> getEstimateTransaction(Map<String, dynamic> body);
  Future<Either<Failure, Data<CreateOrderResponse>>> createOrder(Map<String, dynamic> body);
  Future<Either<Failure, Data<CreateTransactionResponse>>> createTransaction(int transactionId,Map<String, dynamic> body);
  Future<Either<Failure, Data<AddCardProductResponse>>> addCardProduct(int transactionId,List<Map<String, dynamic>> body);
   linkCustomer(int transactionId,int body);
}
