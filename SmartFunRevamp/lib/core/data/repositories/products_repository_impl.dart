import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/create_transaction_response.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/domain/repositories/products_repositories.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

import '../../../di/injection_container.dart';
import '../../domain/entities/buy_card/create_order_response.dart';
import '../../domain/entities/buy_card/discount_coupon.dart';
import '../../domain/entities/data.dart';
import '../../domain/entities/splash_screen/authenticate_system_user.dart';
import '../datasources/local_data_source.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final SmartFunApi _api;

  ProductsRepositoryImpl(this._api);
  @override
  Future<Either<Failure, List<CardProduct>>> getProductPrice(int siteId) async {
    try {
      // final siteTokenResponse = await _api.getExecutionContext(siteId: siteId);
      final siteTokenResponse = await _api.authenticateSystemUserContext({
        "LoginId": dotenv.env['LOGIN_ID'],
        "Password": dotenv.env['PASSWORD'],
        "Siteid" :siteId,
        "MachineName" : dotenv.env['MACHINE_NAME']
      });

      final siteToken = siteTokenResponse.response.data['data']['WebApiToken'] ?? '';
      var Site =
      SiteViewDTO(siteId: siteTokenResponse.data['data']['SiteId'], openDate: DateTime.now(), closureDate: DateTime.now());
      await GluttonLocalDataSource().saveCustomClass(LocalDataSource.kSelectedSite, Site.toJson());
      GluttonLocalDataSource().saveValue(LocalDataSource.POSMachineId,siteTokenResponse.response.data['data']['MachineId']);

      final response = await _api.getProductsPrices(
        DateTime.now().toIso8601String(),
        "Bearer ${siteToken}",
      );
      final cards = response.data;
      cards.removeWhere((element) => element.productId == null);
      return Right(cards);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }


  @override
  Future<Either<Failure, EstimateTransactionResponse>> getEstimateTransaction(Map<String, dynamic> body) async {
    try {
      final response = await _api.estimateTransaction(body);
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, Data<CreateOrderResponse>>> createOrder(Map<String, dynamic> body) async {
    try {
      final response = await _api.createOrder(body);
      return Right(response);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, Data<CreateTransactionResponse>>> createTransaction(int transactionId,Map<String, dynamic> body) async {
    try {
      final response = await _api.createTransaction(transactionId,body);
      return Right(response);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  void linkCustomer(int transactionId,int body) async {
    try {
      final response = await _api.linkCustomer(transactionId,body);
     // return Right(HttpResponse(data: response));
    } on Exception catch (e) {
     // return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, Data<AddCardProductResponse>>> addCardProduct(int transactionId,List<Map<String, dynamic>> body) async {
    try {
      final response = await _api.addCardProduct(transactionId,body);
      return Right(response);
    } on Exception catch (e) {
       return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, Data<DiscountCountResponse>>> AddSaveTransaction(int transactionId) async{
    try {
      final response = await _api.saveTransaction(transactionId.toString());
      return Right(response);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, Data<AddCardProductResponse>>> AddDiscountCoupon(int transactionId, Map<String, dynamic> body) async{
    try {
      final response = await _api.addDiscount(transactionId.toString(),body);
      return Right(response);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }
}
