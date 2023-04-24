import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/gameplays/account_gameplays.dart';
import 'package:semnox/core/errors/failures.dart';

abstract class CardGameplaysRepository {
  Future<Either<Failure, List<AccountGameplays>>> getAccountGamePlays({int accountId});
}
