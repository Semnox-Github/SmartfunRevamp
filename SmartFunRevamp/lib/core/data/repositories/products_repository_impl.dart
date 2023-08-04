import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/domain/repositories/products_repositories.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final SmartFunApi _api;

  ProductsRepositoryImpl(this._api);
  @override
  Future<Either<Failure, List<CardProduct>>> getProductPrice(int siteId) async {
    try {
      final siteTokenResponse = await _api.getExecutionContext(siteId: siteId);
      final siteToken = siteTokenResponse.response.headers.value(HttpHeaders.authorizationHeader) ?? '';
      final response = await _api.getProductsPrices(
        DateTime.now().toIso8601String(),
        siteToken,
      );
      final cards = response.data;
      cards.removeWhere((element) => element.productId == null);
      return Right(cards);
    } on DioException catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure(SplashScreenNotifier.getLanguageLabel('Not Found')));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(SplashScreenNotifier.getLanguageLabel(message['data'])));
    }
  }

  @override
  Future<Either<Failure, EstimateTransactionResponse>> getEstimateTransaction(Map<String, dynamic> body) async {
    try {
      final response = await _api.estimateTransaction(body);
      return Right(response.data);
    } on DioException catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure(SplashScreenNotifier.getLanguageLabel('Not Found')));
      }
      if (e.response?.statusCode == 500) {
        final message = json.decode(e.response.toString());
        return Left(InvalidCouponFailure(message['data']));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(SplashScreenNotifier.getLanguageLabel(message['data'])));
    }
  }
}
