import 'package:get/instance_manager.dart';
import 'package:semnox/core/data/repositories/card_gameplays_repository_impl.dart';
import 'package:semnox/core/domain/repositories/card_gameplays_repository.dart';
import 'package:semnox/core/domain/use_cases/gameplays/get_card_gameplays_use_case.dart';

void gameplaysDependencies() {
  //Repository
  Get.lazyPut<CardGameplaysRepository>(() => CardGameplaysRepositoryImpl(Get.find()));

  //Use Cases
  Get.lazyPut<GetCardGameplaysUseCase>(() => GetCardGameplaysUseCase(Get.find()));
}