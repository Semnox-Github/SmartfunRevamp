import 'package:get/instance_manager.dart';
import 'package:semnox/core/data/repositories/cards_repository_impl.dart';
import 'package:semnox/core/domain/repositories/cards_repository.dart';
import 'package:semnox/core/domain/use_cases/cards/get_account_games_summary_use_case.dart';
import 'package:semnox/core/domain/use_cases/cards/get_bonus_summary_use_case.dart';
import 'package:semnox/core/domain/use_cases/cards/get_card_activity_log_use_case.dart';
import 'package:semnox/core/domain/use_cases/cards/get_card_activity_transaction_detail_use_case.dart';
import 'package:semnox/core/domain/use_cases/cards/link_card_use_case.dart';
import 'package:semnox/core/domain/use_cases/cards/lost_card_use_case.dart';
import 'package:semnox/core/domain/use_cases/cards/transfer_balance_use_case.dart';
import 'package:semnox/core/domain/use_cases/cards/update_card_nickname_use_case.dart';
import 'package:semnox/core/domain/use_cases/home/get_user_cards_use_case.dart';

import '../core/domain/use_cases/cards/get_bonus_credit_summary_use_case.dart';
import '../core/domain/use_cases/cards/get_card_activity_transaction_print_use_case.dart';

void homeDependecies() {
  //Repository
  Get.lazyPut<CardsRepository>(() => CardsRepositoryImpl(Get.find()));

  //Use Cases
  Get.lazyPut<GetUserCardsUseCase>(() => GetUserCardsUseCase(Get.find()));
  Get.lazyPut<GetBonusSummaryUseCase>(() => GetBonusSummaryUseCase(Get.find()));
  Get.lazyPut<GetBonusCreditSummaryUseCase>(() => GetBonusCreditSummaryUseCase(Get.find()));
  Get.lazyPut<GetAccountGamesSummaryUseCase>(() => GetAccountGamesSummaryUseCase(Get.find()));
  Get.lazyPut<LinkCardUseCase>(() => LinkCardUseCase(Get.find()));
  Get.lazyPut<UpdateCardNicknameUseCase>(() => UpdateCardNicknameUseCase(Get.find()));
  Get.lazyPut<GetCardActivityLogUseCase>(() => GetCardActivityLogUseCase(Get.find()));
  Get.lazyPut<GetCardActivityTransactionDetailUseCase>(() => GetCardActivityTransactionDetailUseCase(Get.find()));
  Get.lazyPut<GetCardActivityTransactionPrintUseCase>(() => GetCardActivityTransactionPrintUseCase(Get.find()));
  Get.lazyPut<TransferBalanceUseCase>(() => TransferBalanceUseCase(Get.find()));
  Get.lazyPut<LostCardUseCase>(() => LostCardUseCase(Get.find()));
}
