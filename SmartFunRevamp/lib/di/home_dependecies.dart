import 'package:get/instance_manager.dart';
import 'package:semnox/core/data/repositories/home_repository_impl.dart';
import 'package:semnox/core/domain/repositories/home_repository.dart';
import 'package:semnox/core/domain/use_cases/home/get_user_cards_use_case.dart';

void homeDependecies() {
  //Repository
  Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl(Get.find()));

  //Use Cases
  Get.lazyPut<GetUserCardsUseCase>(() => GetUserCardsUseCase(Get.find()));
}
