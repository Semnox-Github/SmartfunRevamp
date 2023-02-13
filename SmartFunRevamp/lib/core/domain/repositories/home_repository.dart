import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/home/card_details.dart';
import 'package:semnox/core/errors/failures.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<CardDetails>>> getCardDetails(String userId);
}
