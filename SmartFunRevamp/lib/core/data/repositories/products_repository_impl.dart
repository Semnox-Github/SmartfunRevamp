import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/domain/repositories/products_repositories.dart';
import 'package:semnox/core/errors/failures.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final SmartFunApi _api;

  ProductsRepositoryImpl(this._api);
  @override
  Future<Either<Failure, List<CardProduct>>> getProductPrice() async {
    try {
      final response = await _api.getProductsPrices(DateTime.now().toIso8601String());
      final cards = response.data;
      cards.removeWhere((element) => element.productId == null);
      return Right(cards);
    } on DioError catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    }
  }

  @override
  Future<Either<Failure, EstimateTransactionResponse>> getEstimateTransaction(Map<String, dynamic> body) async {
    try {
      final response = await _api.estimateTransaction(body);
      return Right(response.data);
    } on DioError catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    }
  }
}
