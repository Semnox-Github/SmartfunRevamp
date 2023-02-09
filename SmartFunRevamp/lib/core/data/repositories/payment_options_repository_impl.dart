import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/payment/payment_mode.dart';
import 'package:semnox/core/domain/repositories/payment_options_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class PaymentOptionsRepositoryImpl implements PaymentOptionsRepository {
  final SmartFunApi _api;

  PaymentOptionsRepositoryImpl(this._api);

  @override
    Future<Either<Failure, List<PaymentMode>>> getPaymentModes() async {
      try {
        final response = await _api.getPaymentModes();
        final paymentModes = response.data..removeWhere((element) => element.paymentGateway == null);
        return Right(paymentModes);
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
