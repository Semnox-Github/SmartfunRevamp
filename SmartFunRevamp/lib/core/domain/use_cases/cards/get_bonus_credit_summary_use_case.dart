import 'package:dartz/dartz.dart';
import '../../../errors/failures.dart';
import '../../entities/card_details/credit_plus_summary.dart';
import '../../repositories/cards_repository.dart';

class GetBonusCreditSummaryUseCase {
  final CardsRepository _repository;
  GetBonusCreditSummaryUseCase(this._repository);
  Future<Either<Failure, List<CreditPlusSummary>>> call(String accountNumber) async {
    return await _repository.getBonusCreditSummary(accountNumber);
  }
}