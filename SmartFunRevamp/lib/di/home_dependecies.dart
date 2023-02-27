import 'package:get/instance_manager.dart';
import 'package:semnox/core/data/repositories/cards_repository_impl.dart';
import 'package:semnox/core/domain/repositories/cards_repository.dart';
import 'package:semnox/core/domain/use_cases/cards/get_account_games_summary_use_case.dart';
import 'package:semnox/core/domain/use_cases/cards/get_bonus_summary_use_case.dart';
import 'package:semnox/core/domain/use_cases/cards/link_card_use_case.dart';

import 'package:semnox/core/domain/use_cases/home/get_user_cards_use_case.dart';

void homeDependecies() {
  //Repository
  Get.lazyPut<CardsRepository>(() => CardsRepositoryImpl(Get.find()));

  //Use Cases
  Get.lazyPut<GetUserCardsUseCase>(() => GetUserCardsUseCase(Get.find()));
  Get.lazyPut<GetBonusSummaryUseCase>(() => GetBonusSummaryUseCase(Get.find()));
  Get.lazyPut<GetAccountGamesSummaryUseCase>(() => GetAccountGamesSummaryUseCase(Get.find()));
  Get.lazyPut<LinkCardUseCase>(() => LinkCardUseCase(Get.find()));
}
